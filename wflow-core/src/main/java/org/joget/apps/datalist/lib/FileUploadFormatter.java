package org.joget.apps.datalist.lib;

import org.joget.apps.app.model.AppDefinition;
import org.joget.apps.app.service.AppUtil;
import org.joget.apps.datalist.model.*;
import org.json.JSONException;

import javax.annotation.Nonnull;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

public class FileUploadFormatter extends DataListColumnFormatDefault {
    public final static String LABEL = "File Upload Formatter";

    @Override
    public String format(DataList dataList, DataListColumn column, Object row, Object value) {
        final String primaryKeyColumn = Optional.of(dataList)
                .map(DataList::getBinder)
                .map(DataListBinder::getPrimaryKeyColumnName)
                .orElse("id");

        final String primaryKey = String.valueOf(((Map<String, String>) row).get(primaryKeyColumn));

        return Optional.ofNullable(value)
                .stream()
                .map(String::valueOf)
                .map(s -> s.split(";"))
                .flatMap(Arrays::stream)
                .map(s -> "<a href='" + getFileDownloadLink(primaryKey, s) + "'>" + s + "</a>")
                .collect(Collectors.joining("; "));
    }

    @Override
    public String getName() {
        return LABEL;
    }

    @Override
    public String getVersion() {
        return getClass().getPackage().getImplementationVersion();
    }

    @Override
    public String getDescription() {
        return "Display URL link to file";
    }

    @Override
    public String getLabel() {
        return LABEL;
    }

    @Override
    public String getClassName() {
        return getClass().getName();
    }

    @Override
    public String getPropertyOptions() {
        return AppUtil.readPluginResource(getClass().getName(), "/properties/datalist/fileUploadFormatter.json");
    }

    @Override
    public Object handleColumnValueResponse(@Nonnull DataList dataList, @Nonnull DataListColumn column, DataListColumnFormat formatter, Map<String, Object> row, String value) throws JSONException {
        final String primaryKeyColumn = Optional.of(dataList)
                .map(DataList::getBinder)
                .map(DataListBinder::getPrimaryKeyColumnName)
                .orElse("id");

        final String primaryKey = String.valueOf(row.get(primaryKeyColumn));
        return Optional.ofNullable(value)
                .stream()
                .map(s -> s.split(";"))
                .flatMap(Arrays::stream)
                .filter(s -> !s.isEmpty())
                .map(s -> getFileDownloadLink(primaryKey, s))
                .toArray(String[]::new);
    }

    protected String getFileDownloadLink(String primaryKeyValue, String value) {
        AppDefinition appDefinition = AppUtil.getCurrentAppDefinition();
        return Optional.ofNullable(value)
                .map(fileName -> {
                    // determine actual path for the file uploads
                    String appId = appDefinition.getAppId();
                    long appVersion = appDefinition.getVersion();
                    String formDefId = getFormDefId();
                    String encodedFileName = fileName;
                    try {
                        encodedFileName = URLEncoder.encode(fileName, "UTF8").replaceAll("\\+", "%20");
                    } catch (UnsupportedEncodingException ex) {
                        // ignore
                    }

                    String filePath = "/web/client/app/" + appId + "/" + appVersion + "/form/download/" + formDefId + "/" + primaryKeyValue + "/" + encodedFileName + ".";
                    if (isAsAttachment()) {
                        filePath += "?attachment=true";
                    }

                    return filePath;
                })
                .orElse(value);
    }

    protected String getFormDefId() {
        return getPropertyString("formDefId");
    }

    protected boolean isAsAttachment() {
        return "true".equalsIgnoreCase(getPropertyString("asAttachment"));
    }
}
