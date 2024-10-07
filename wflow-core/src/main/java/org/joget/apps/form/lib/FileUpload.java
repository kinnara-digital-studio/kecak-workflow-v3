package org.joget.apps.form.lib;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.*;
import java.util.function.Function;
import java.util.regex.Matcher;
import java.util.stream.Collectors;
import javax.annotation.Nonnull;
import javax.annotation.Nullable;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.joget.apps.app.model.AppDefinition;
import org.joget.apps.app.service.AppUtil;
import org.joget.apps.form.model.Element;
import org.joget.apps.form.model.FileDownloadSecurity;
import org.joget.apps.form.model.Form;
import org.joget.apps.form.model.FormBuilderPaletteElement;
import org.joget.apps.form.model.FormBuilderPalette;
import org.joget.apps.form.model.FormData;
import org.joget.apps.form.model.FormPermission;
import org.joget.apps.form.model.FormRow;
import org.joget.apps.form.model.FormRowSet;
import org.joget.apps.form.service.FileUtil;
import org.joget.apps.form.service.FormUtil;
import org.joget.apps.userview.model.Permission;
import org.joget.apps.userview.model.PwaOfflineResources;
import org.joget.commons.util.*;
import org.joget.directory.model.User;
import org.joget.plugin.base.PluginManager;
import org.joget.plugin.base.PluginWebSupport;
import org.joget.workflow.model.service.WorkflowUserManager;
import org.joget.workflow.util.WorkflowUtil;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.kecak.apps.form.service.FormDataUtil;
import org.springframework.web.multipart.MultipartFile;

public class FileUpload extends Element implements FormBuilderPaletteElement, FileDownloadSecurity, PluginWebSupport, PwaOfflineResources {

    @Override
    public String getName() {
        return "File Upload";
    }

    @Override
    public String getVersion() {
        return "5.0.0";
    }

    @Override
    public String getDescription() {
        return "FileUpload Element";
    }

    @Override
    public String renderTemplate(FormData formData, Map dataModel) {
        String template = "fileUpload.ftl";

        // set value
        String[] values = FormUtil.getElementPropertyValues(this, formData);
        
        //check is there a stored value
        String storedValue = formData.getStoreBinderDataProperty(this);
        if (storedValue != null) {
            values = storedValue.split(";");
        }
        
        
        Map<String, String> tempFilePaths = new LinkedHashMap<String, String>();
        Map<String, String> filePaths = new LinkedHashMap<String, String>();
        
        String primaryKeyValue = getPrimaryKeyValue(formData);
        String filePathPostfix = "_path";
        String id = FormUtil.getElementParameterName(this);
        String[] tempExisting = formData.getRequestParameterValues(id + filePathPostfix);
            
        if (tempExisting != null && tempExisting.length > 0) {
            values = tempExisting;
        }
        
        String formDefId = "";
        Form form = FormUtil.findRootForm(this);
        if (form != null) {
            formDefId = form.getPropertyString(FormUtil.PROPERTY_ID);
        }
        String appId = "";
        String appVersion = "";

        AppDefinition appDef = AppUtil.getCurrentAppDefinition();

        if (appDef != null) {
            appId = appDef.getId();
            appVersion = appDef.getVersion().toString();
        }
                
        for (String value : values) {
            // check if the file is in temp file
            File file = FileManager.getFileByPath(value);
            
            if (file != null) {
                tempFilePaths.put(value, file.getName());
            } else if (value != null && !value.isEmpty()) {
                // determine actual path for the file uploads
                String fileName = value;
                String encodedFileName = fileName;
                if (fileName != null) {
                    try {
                        encodedFileName = URLEncoder.encode(fileName, "UTF8").replaceAll("\\+", "%20");
                    } catch (UnsupportedEncodingException ex) {
                        // ignore
                    }
                }
                
                String filePath = "/web/client/app/" + appId + "/" + appVersion + "/form/download/" + formDefId + "/" + primaryKeyValue + "/" + encodedFileName + ".";
                if (Boolean.valueOf(getPropertyString("attachment")).booleanValue()) {
                    filePath += "?attachment=true";
                }
                filePaths.put(filePath, value);
            }
        }
        
        if (!tempFilePaths.isEmpty()) {
            dataModel.put("tempFilePaths", tempFilePaths);
        }
        if (!filePaths.isEmpty()) {
            dataModel.put("filePaths", filePaths);
        }
        
        String html = FormUtil.generateElementHtml(this, formData, template, dataModel);
        return html;
    }

    @Override
    public FormData formatDataForValidation(FormData formData) {
        String filePathPostfix = "_path";
        String id = FormUtil.getElementParameterName(this);
        if (id != null) {
            String[] tempFilenames = formData.getRequestParameterValues(id);
            String[] tempExisting = formData.getRequestParameterValues(id + filePathPostfix);
            
            List<String> filenames = new ArrayList<String>();
            if (tempFilenames != null && tempFilenames.length > 0) {
                filenames.addAll(Arrays.asList(tempFilenames));
            }

            if (tempExisting != null && tempExisting.length > 0) {
                filenames.addAll(Arrays.asList(tempExisting));
            }

            if (filenames.isEmpty()) {
                formData.addRequestParameterValues(id, new String[]{""});
            } else if (!"true".equals(getPropertyString("multiple"))) {
                formData.addRequestParameterValues(id, new String[]{filenames.get(0)});
            } else {
                formData.addRequestParameterValues(id, filenames.toArray(new String[]{}));
            }
        }
        return formData;
    }
    
    @Override
    public FormRowSet formatData(FormData formData) {
        FormRowSet rowSet = null;
        
        String id = getPropertyString(FormUtil.PROPERTY_ID);
        
        Set<String> remove = null;
        if ("true".equals(getPropertyString("removeFile"))) {
            remove = new HashSet<String>();
            Form form = FormUtil.findRootForm(this);
            String originalValues = formData.getLoadBinderDataProperty(form, id);
            if (originalValues != null) {
                remove.addAll(Arrays.asList(originalValues.split(";")));
            }
        }

        // get value
        if (id != null) {
            String[] values = FormUtil.getElementPropertyValues(this, formData);
            if (values != null && values.length > 0) {
                // set value into Properties and FormRowSet object
                FormRow result = new FormRow();
                List<String> resultedValue = new ArrayList<String>();
                List<String> filePaths = new ArrayList<String>();
                
                for (String value : values) {
                    // check if the file is in temp file
                    File file = FileManager.getFileByPath(value);
                    if (file != null) {
                        filePaths.add(value);
                        resultedValue.add(file.getName());
                    } else {
                        if (remove != null && !value.isEmpty()) {
                            remove.remove(value);
                        }
                        resultedValue.add(value);
                    }
                }
                
                if (!filePaths.isEmpty()) {
                    result.putTempFilePath(id, filePaths.toArray(new String[]{}));
                }
                
                if (remove != null) {
                    result.putDeleteFilePath(id, remove.toArray(new String[]{}));
                }
                
                // formulate values
                String delimitedValue = FormUtil.generateElementPropertyValues(resultedValue.toArray(new String[]{}));
                String paramName = FormUtil.getElementParameterName(this);
                formData.addRequestParameterValues(paramName, resultedValue.toArray(new String[]{}));
                        
                // set value into Properties and FormRowSet object
                result.setProperty(id, delimitedValue);
                rowSet = new FormRowSet();
                rowSet.add(result);
                
                String filePathPostfix = "_path";
                formData.addRequestParameterValues(id + filePathPostfix, new String[]{});
            }
        }
        
        return rowSet;
    }

    @Override
    public String getClassName() {
        return getClass().getName();
    }

    @Override
    public String getFormBuilderTemplate() {
        return "<label class='label'>" + ResourceBundleUtil.getMessage("org.joget.apps.form.lib.FileUpload.pluginLabel") + "</label><input type='file' />";
    }

    @Override
    public String getLabel() {
        return "File Upload";
    }

    @Override
    public String getPropertyOptions() {
        return AppUtil.readPluginResource(getClass().getName(), "/properties/form/fileUpload.json", null, true, "message/form/FileUpload");
    }

    @Override
    public String getFormBuilderCategory() {
        return FormBuilderPalette.CATEGORY_GENERAL;
    }

    @Override
    public int getFormBuilderPosition() {
        return 900;
    }

    @Override
    public String getFormBuilderIcon() {
        return "<i class=\"fas fa-upload\"></i>";
    }
    
    @Override
    public Boolean selfValidate(FormData formData) {
        String id = FormUtil.getElementParameterName(this);
        Boolean valid = true;
        String error = "";
        try {
            String[] values = FormUtil.getElementPropertyValues(this, formData);

            for (String value : values) {
                File file = FileManager.getFileByPath(value);
                if (file != null) {
                    if(getPropertyString("maxSize") != null && !getPropertyString("maxSize").isEmpty()) {
                        long maxSize = Long.parseLong(getPropertyString("maxSize")) * 1024;

                        if (file.length() > maxSize) {
                            valid = false;
                            error += getPropertyString("maxSizeMsg") + " ";

                        }
                    }
                    if(getPropertyString("fileType") != null && !getPropertyString("fileType").isEmpty()) {
                        String[] fileType = getPropertyString("fileType").split(";");
                        String filename = file.getName().toUpperCase();
                        Boolean found = false;
                        for (String type : fileType) {
                            if (filename.endsWith(type.toUpperCase())) {
                                found = true;
                            }
                        }
                        if (!found) {
                            valid = false;
                            error += getPropertyString("fileTypeMsg");
                            FileManager.deleteFile(file);
                        }
                    }
                }
            }
            
            if (!valid) {
                formData.addFormError(id, error);
            }
        } catch (Exception e) {}
        
        return valid;
    }
    
    public boolean isDownloadAllowed(Map requestParameters) {
        String permissionType = getPropertyString("permissionType");
        if (permissionType.equals("public")) {
            return true;
        } else if (permissionType.equals("custom")) {
            Object permissionElement = getProperty("permissionPlugin");
            if (permissionElement != null && permissionElement instanceof Map) {
                Map elementMap = (Map) permissionElement;
                String className = (String) elementMap.get("className");
                Map<String, Object> properties = (Map<String, Object>) elementMap.get("properties");

                //convert it to plugin
                PluginManager pm = (PluginManager) AppUtil.getApplicationContext().getBean("pluginManager");
                Permission plugin = (Permission) pm.getPlugin(className);
                if (plugin != null && plugin instanceof FormPermission) {
                    WorkflowUserManager workflowUserManager = (WorkflowUserManager) AppUtil.getApplicationContext().getBean("workflowUserManager");
                    User user = workflowUserManager.getCurrentUser();

                    plugin.setProperties(properties);
                    plugin.setCurrentUser(user);
                    plugin.setRequestParameters(requestParameters);

                    return plugin.isAuthorize();
                }
            }
            return false;
        } else {
            return !WorkflowUtil.isCurrentUserAnonymous();
        }
    }
    
    public String getServiceUrl() {
        String url = WorkflowUtil.getHttpServletRequest().getContextPath()+ "/web/json/plugin/org.joget.apps.form.lib.FileUpload/service";
        AppDefinition appDef = AppUtil.getCurrentAppDefinition();
        
        //create nonce
        String paramName = FormUtil.getElementParameterName(this);
        String fileType = getPropertyString("fileType");
        String nonce = SecurityUtil.generateNonce(new String[]{"FileUpload", appDef.getAppId(), appDef.getVersion().toString(), paramName, fileType}, 1);
        
        try {
            url = url + "?_nonce="+URLEncoder.encode(nonce, "UTF-8")+"&_paramName="+URLEncoder.encode(paramName, "UTF-8")+"&_appId="+URLEncoder.encode(appDef.getAppId(), "UTF-8")+"&_appVersion="+URLEncoder.encode(appDef.getVersion().toString(), "UTF-8")+"&_ft="+URLEncoder.encode(fileType, "UTF-8");
        } catch (Exception e) {}
        return url;
    }
    
    public void webService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nonce = request.getParameter("_nonce");
        String paramName = request.getParameter("_paramName");
        String appId = request.getParameter("_appId");
        String appVersion = request.getParameter("_appVersion");
        String filePath = request.getParameter("_path");
        String fileType = request.getParameter("_ft");

        if (SecurityUtil.verifyNonce(nonce, new String[]{"FileUpload", appId, appVersion, paramName, fileType})) {
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                
                try {
                    JSONObject obj = new JSONObject();
                    try {
                        // handle multipart files
                        String validatedParamName = SecurityUtil.validateStringInput(paramName);
                        MultipartFile file = FileStore.getFile(validatedParamName);
                        if (file != null && file.getOriginalFilename() != null && !file.getOriginalFilename().isEmpty()) {
                            String ext = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")).toLowerCase();
                            if (fileType != null && (fileType.isEmpty() || fileType.contains(ext+";") || fileType.endsWith(ext))) {
                                String path = FileManager.storeFile(file);
                                obj.put("path", path);
                                obj.put("filename", file.getOriginalFilename());
                                obj.put("newFilename", path.substring(path.lastIndexOf(File.separator) + 1));
                            } else {
                                obj.put("error", ResourceBundleUtil.getMessage("form.fileupload.fileType.msg.invalidFileType"));
                            }
                        }

                        Collection<String> errorList = FileStore.getFileErrorList();
                        if (errorList != null && !errorList.isEmpty() && errorList.contains(paramName)) {
                            obj.put("error", ResourceBundleUtil.getMessage("general.error.fileSizeTooLarge", new Object[]{FileStore.getFileSizeLimit()}));
                        }
                    } catch (Exception e) {
                        obj.put("error", e.getLocalizedMessage());
                    } finally {
                        FileStore.clear();
                    }
                    obj.write(response.getWriter());
                } catch (Exception ex) {}
            } else if (filePath != null && !filePath.isEmpty()) {
                String normalizedFilePath = SecurityUtil.normalizedFileName(filePath);
                
                File file = FileManager.getFileByPath(normalizedFilePath);
                if (file != null) {
                    ServletOutputStream stream = response.getOutputStream();
                    DataInputStream in = new DataInputStream(new FileInputStream(file));
                    byte[] bbuf = new byte[65536];
                        
                    try {
                        String contentType = request.getSession().getServletContext().getMimeType(file.getName());
                        if (contentType != null) {
                            response.setContentType(contentType);
                        }

                        // send output
                        int length = 0;
                        while ((in != null) && ((length = in.read(bbuf)) != -1)) {
                            stream.write(bbuf, 0, length);
                        }
                    } catch (Exception e) {
                    
                    } finally {
                        in.close();
                        stream.flush();
                        stream.close();
                    }    
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
            }
        } else {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, ResourceBundleUtil.getMessage("general.error.error403"));
        }
    }
    
    @Override
    public Set<String> getOfflineStaticResources() {
        Set<String> urls = new HashSet<String>();
        String contextPath = AppUtil.getRequestContextPath();
        urls.add(contextPath + "/js/dropzone/dropzone.css");
        urls.add(contextPath + "/js/dropzone/dropzone.js");
        urls.add(contextPath + "/plugin/org.joget.apps.form.lib.FileUpload/js/jquery.fileupload.js");
        
        return urls;
    }

    @Override
    public String[] handleMultipartDataRequest(String[] values, Element element, FormData formData) {
        final String elementId = element.getPropertyString("id");

        List<String> filePathList = new ArrayList<>();

        try {
            MultipartFile[] fileStore = FileStore.getFiles(elementId);
            if (fileStore != null) {
                for (MultipartFile file : fileStore) {
                    final String filePath = FileManager.storeFile(file);
                    filePathList.add(filePath);
                }
            }
        } catch (FileLimitException e) {
            LogUtil.error(getClassName(), e, e.getMessage());
        }

        if (filePathList.isEmpty()) {
            return FormUtil.getElementPropertyValues(element, formData);
        } else {
            return filePathList.toArray(new String[0]);
        }
    }

    @Override
    public String[] handleJsonDataRequest(@Nullable Object value, @Nonnull Element element, FormData formData) {
        String stringValue = value == null ? "" : value.toString();

        JSONArray jsonValue;
        try {
            jsonValue = new JSONArray(stringValue);
        } catch (JSONException e) {
            // handle if it is not an array
            jsonValue = new JSONArray();
            jsonValue.put(stringValue);
        }

        List<String> result = new ArrayList<>();
        for (int i = 0, size = jsonValue.length(); i < size; i++) {
            try {
                String data = jsonValue.getString(i);
                Matcher dataPattern = FormDataUtil.DATA_PATTERN.matcher(data);

                String tempFilePath;

                // as data uri
                if (dataPattern.find()) {
                    String contentType = dataPattern.group("mime");
                    String extension = contentType.split("/")[1];
                    String fileName = FormDataUtil.getFileName(dataPattern.group("properties"), extension);
                    String base64 = dataPattern.group("data");

                    // store in app_tempupload
                    MultipartFile multipartFile = FormDataUtil.decodeFile(fileName, contentType, base64.trim());
                    tempFilePath = FileManager.storeFile(multipartFile);
                } else {
                    tempFilePath = data;
                }

                // check if file really exist in app_tempupload or in current record
                if (FileManager.getFileByPath(tempFilePath) != null || FileUtil.getFile(tempFilePath, this, getPrimaryKeyValue(formData)).isFile()) {
                    result.add(tempFilePath);
                }

            } catch (JSONException | IOException e) {
                LogUtil.error(getClassName(), e, e.getMessage());
            }
        }

        // clean field for empty result
        if (result.isEmpty()) {
            result.add("");
        }

        return result.toArray(new String[0]);
    }

    @Override
    public Object handleElementValueResponse(@Nonnull Element element, @Nonnull FormData formData) throws JSONException {
        if (isReadOnlyLabel() || asAttachment(formData)) {
            return getFileDownloadLink(formData);
        } else {
            return FormUtil.getElementPropertyValue(this, formData);
        }
    }

    protected boolean isReadOnlyLabel() {
        return "true".equalsIgnoreCase(getPropertyString(FormUtil.PROPERTY_READONLY))
                && "true".equalsIgnoreCase(getPropertyString(FormUtil.PROPERTY_READONLY_LABEL));
    }

    protected boolean asAttachment(FormData formData) {
        return Boolean.parseBoolean(getPropertyString("attachment"))
                || "true".equalsIgnoreCase(formData.getRequestParameter(PARAMETER_AS_LINK));
    }

    protected String getFileDownloadLink(FormData formData) {
        AppDefinition appDefinition = AppUtil.getCurrentAppDefinition();
        // set value
        String[] values = FormUtil.getElementPropertyValues(this, formData);
        return Arrays.stream(values)
                .filter(Objects::nonNull)
                .map(fileName -> {
                    // determine actual path for the file uploads
                    String appId = appDefinition.getAppId();
                    long appVersion = appDefinition.getVersion();
                    String formDefId = Optional.ofNullable(FormUtil.findRootForm(this))
                            .map(new Function<Form, String>() {
                                @Override
                                public String apply(Form f) {
                                    return f.getPropertyString(FormUtil.PROPERTY_ID);
                                }
                            })
                            .orElse("");
                    String encodedFileName = fileName;
                    String primaryKeyValue = formData.getPrimaryKeyValue();
                    try {
                        encodedFileName = URLEncoder.encode(fileName, "UTF8").replaceAll("\\+", "%20");
                    } catch (UnsupportedEncodingException ex) {
                        // ignore
                    }

                    String filePath = "/web/client/app/" + appId + "/" + appVersion + "/form/download/" + formDefId + "/" + primaryKeyValue + "/" + encodedFileName + ".";
                    if (asAttachment(formData)) {
                        filePath += "?attachment=true";
                    }

                    return filePath;
                })
                .collect(Collectors.joining(";"));
    }
}
