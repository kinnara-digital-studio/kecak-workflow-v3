package org.joget.apps.form.lib;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.joget.apps.app.service.AppUtil;
import org.joget.apps.form.model.Element;
import org.joget.apps.form.model.FormBuilderPaletteElement;
import org.joget.apps.form.model.FormBuilderPalette;
import org.joget.apps.form.model.FormData;
import org.joget.apps.form.model.FormRow;
import org.joget.apps.form.model.FormRowSet;
import org.joget.apps.form.service.FormUtil;
import org.joget.commons.util.ResourceBundleUtil;
import org.joget.commons.util.StringUtil;
import org.joget.workflow.model.WorkflowAssignment;
import org.joget.workflow.model.service.WorkflowManager;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;

public class HiddenField extends Element implements FormBuilderPaletteElement {

    @Override
    public String getName() {
        return "Hidden Field";
    }

    @Override
    public String getVersion() {
        return "5.0.0";
    }

    @Override
    public String getDescription() {
        return "Hidden Field Element";
    }

    @Override
    public String renderTemplate(FormData formData, Map dataModel) {
        String template = "hiddenField.ftl";

        // set value
        String value = FormUtil.getElementPropertyValue(this, formData);
        String priority = getPropertyString("useDefaultWhenEmpty");
        
        if (priority != null && !priority.isEmpty()) {
            if (("true".equals(priority) && (value == null || value.isEmpty()))
                    || "valueOnly".equals(priority)) {
                value = getPropertyString("value");
            }
        } else {
            if (getPropertyString("value") != null && !getPropertyString("value").isEmpty()) {
                value = getPropertyString("value");
            }
        } 

        dataModel.put("value", value);

        String html = FormUtil.generateElementHtml(this, formData, template, dataModel);
        return html;
    }

    @Override
    public String getClassName() {
        return getClass().getName();
    }

    @Override
    public String getFormBuilderTemplate() {
        return "<label class='label'>" + ResourceBundleUtil.getMessage("org.joget.apps.form.lib.HiddenField.pluginLabel") + "</label>";
    }

    @Override
    public String getLabel() {
        return "Hidden Field";
    }

    @Override
    public String getPropertyOptions() {
        return AppUtil.readPluginResource(getClass().getName(), "/properties/form/hiddenField.json", null, true, "message/form/HiddenField");
    }

    @Override
    public String getFormBuilderCategory() {
        return FormBuilderPalette.CATEGORY_GENERAL;
    }

    @Override
    public int getFormBuilderPosition() {
        return 100;
    }

    @Override
    public String getFormBuilderIcon() {
        return "<i class=\"fas fa-eye-slash\"></i>";
    }
    
    //Force to be readonly when it set to `Always Use Default Value`
    @Override
    public Boolean isReadonly(FormData formData) {
        if ("valueOnly".equalsIgnoreCase(getPropertyString("useDefaultWhenEmpty"))) {
            return true;
        } else {
            return super.isReadonly(formData);
        }
    }
    
    /**
     * to force the value stored for `Always Use Default Value` is always the default value
     */
    @Override
    public FormRowSet formatData(FormData formData) {
        FormRowSet rowSet = null;

        // get value
        String id = getPropertyString(FormUtil.PROPERTY_ID);
        if (id != null) {
            String value = FormUtil.getElementPropertyValue(this, formData);
            if ("valueOnly".equalsIgnoreCase(getPropertyString("useDefaultWhenEmpty"))) {
                value = getPropertyString("value");
            }
            if (value != null) {
                // set value into Properties and FormRowSet object
                FormRow result = new FormRow();
                result.setProperty(id, value);
                rowSet = new FormRowSet();
                rowSet.add(result);
            }
        }

        return rowSet;
    }

    @Override
    public String[] handleMultipartDataRequest(@Nonnull String[] values, @Nonnull Element element, @Nonnull FormData formData) {
        return handleDataRequestParameter(element, formData);
    }

    @Override
    public String[] handleJsonDataRequest(@Nullable Object value, @Nonnull Element element, @Nonnull FormData formData) {
        return handleDataRequestParameter(element, formData);
    }

    protected String[] handleDataRequestParameter(Element element, FormData formData) {
        WorkflowManager workflowManager = (WorkflowManager) AppUtil.getApplicationContext().getBean("workflowManager");
        WorkflowAssignment assignment = workflowManager.getAssignment(formData.getActivityId());

        String elementId = element.getPropertyString(FormUtil.PROPERTY_ID);
        String defaultValue = AppUtil.processHashVariable(element.getPropertyString(FormUtil.PROPERTY_VALUE), assignment, null, null);
        FormRowSet rows = formData.getLoadBinderData(element);
        if(rows == null || rows.isEmpty()) {
            return new String[] { defaultValue };
        }

        String databaseValue = rows.get(0).getProperty(elementId, "");

        String priority = element.getPropertyString("useDefaultWhenEmpty");

        if (StringUtils.isNotEmpty(priority) && (("true".equals(priority) && StringUtils.isEmpty(databaseValue)) || "valueOnly".equals(priority))) {
            return new String[] { defaultValue };
        }

        return new String[] { StringUtils.firstNonEmpty(databaseValue, defaultValue) };
    }
}
