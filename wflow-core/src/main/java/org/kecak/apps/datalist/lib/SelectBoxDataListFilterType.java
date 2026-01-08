package org.kecak.apps.datalist.lib;

import org.joget.apps.app.service.AppUtil;
import org.joget.apps.datalist.model.DataList;
import org.joget.apps.datalist.model.DataListFilterQueryObject;
import org.joget.apps.datalist.model.DataListFilterTypeDefault;
import org.joget.apps.form.model.FormAjaxOptionsBinder;
import org.joget.apps.form.model.FormRow;
import org.joget.apps.form.model.FormRowSet;
import org.joget.apps.form.service.FormUtil;
import org.joget.commons.util.LogUtil;
import org.joget.plugin.base.Plugin;
import org.joget.plugin.base.PluginManager;
import org.joget.plugin.property.model.PropertyEditable;
import org.joget.workflow.util.WorkflowUtil;

import javax.annotation.Nonnull;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class SelectBoxDataListFilterType extends DataListFilterTypeDefault {
    public final static String LABEL = "SelectBox";

    @Override
    public String getTemplate(DataList datalist, String name, String label) {
        PluginManager pluginManager = (PluginManager) AppUtil.getApplicationContext().getBean("pluginManager");
        @SuppressWarnings("rawtypes")
        Map dataModel = new HashMap();
        dataModel.put("name", datalist.getDataListEncodedParamName(DataList.PARAMETER_FILTER_PREFIX + name));
        dataModel.put("label", label);
        dataModel.put("values", getValueSet(datalist, name, AppUtil.processHashVariable(getPropertyString("defaultValue"), null, null, null)));

        FormRowSet options = getStreamOptions()
                .collect(Collectors.toCollection(FormRowSet::new));

        String size = getPropertyString("size") + "px";

        dataModel.put("options", options);
        dataModel.put("size", size);

        dataModel.put(FormUtil.PROPERTY_ELEMENT_UNIQUE_KEY, FormUtil.getUniqueKey());

        return pluginManager.getPluginFreeMarkerTemplate(dataModel, getClassName(), "/templates/selectBoxDataListFilterType.ftl", null);
    }

    public Stream<FormRow> getStreamOptions() {
        return Stream.concat(getOptions().stream(), getOptionsBinder().stream());
    }

    @Override
    public DataListFilterQueryObject getQueryObject(DataList datalist, String name) {
        DataListFilterQueryObject queryObject = new DataListFilterQueryObject();
        if (datalist != null && datalist.getBinder() != null) {
            List<String> paramList = new ArrayList<>(getValueSet(datalist, name, AppUtil.processHashVariable(getPropertyString("defaultValue"), null, null, null)));

            final String columnName = datalist.getBinder().getColumnName(name);
            String query;

            if (paramList.isEmpty()) {
                query = "1 = 1";
            } else {
                query = "FIND_IN_SET(" + columnName + "," + paramList.stream().map(s -> "?").collect(Collectors.joining(",")) + ") > 0";
            }


            String[] params = paramList.toArray(new String[0]);

            LogUtil.info(getClassName(), "query [" + query + "] param [" + String.join(";", params) + "]");

            queryObject.setQuery(query);
            queryObject.setValues(params);
            queryObject.setOperator("AND");

            return queryObject;
        }
        return null;
    }

    protected <T> Stream<T> repeat(T value, int n) {
        return IntStream.rangeClosed(1, n).limit(n).boxed().map(i -> value);
    }

    /**
     * Return values as set
     *
     * @param datalist
     * @param name
     * @param defaultValue
     * @return
     */
    @Nonnull
    protected Set<String> getValueSet(DataList datalist, String name, String defaultValue) {
        return Optional.ofNullable(getValues(datalist, name, defaultValue))
                .stream()
                .flatMap(Arrays::stream)
                .map(s -> s.split(";"))
                .flatMap(Arrays::stream)
                .filter(ss -> !ss.isEmpty())
                .collect(Collectors.toSet());
    }

    @Override
    public String getClassName() {
        return SelectBoxDataListFilterType.class.getName();
    }

    @Override
    public String getLabel() {
        return LABEL;
    }

    @Override
    public String getPropertyOptions() {
        return AppUtil.readPluginResource(getClass().getName(), "/properties/SelectBoxDataListFilterType.json", null, true, "messages/");
    }

    @Override
    public String getDescription() {
        return getClass().getPackage().getImplementationTitle();
    }

    @Override
    public String getName() {
        return LABEL;
    }

    @Override
    public String getVersion() {
        return getClass().getPackage().getImplementationVersion();
    }

    /**
     * Get property "options"
     *
     * @return
     */
    private FormRowSet getOptions() {
        return getPropertyGridOptions("options");
    }

    /**
     * Get property "optionsBinder"
     *
     * @return
     */
    private FormRowSet getOptionsBinder() {
        return getPropertyElementSelectOptions("optionsBinder");
    }

    protected boolean isAuthorize(@Nonnull DataList dataList) {
        return isDefaultUserToHavePermission();
    }

    protected boolean isDefaultUserToHavePermission() {
        return WorkflowUtil.isCurrentUserInRole(WorkflowUtil.ROLE_ADMIN);
    }

    @Nonnull
    protected FormRowSet getPropertyElementSelectOptions(String name) {
        PluginManager pluginManager = (PluginManager) AppUtil.getApplicationContext().getBean("pluginManager");

        Map<String, Object> optionsBinder = (Map<String, Object>)getProperty(name);

        if(optionsBinder != null){
            String className = optionsBinder.get("className").toString();
            Plugin optionsBinderPlugins = pluginManager.getPlugin(className);
            if(optionsBinderPlugins != null && optionsBinder.get("properties") != null) {
                ((PropertyEditable) optionsBinderPlugins).setProperties((Map) optionsBinder.get("properties"));
                return ((FormAjaxOptionsBinder) optionsBinderPlugins).loadAjaxOptions(null);
            }
        }

        return new FormRowSet();
    }

    @Nonnull
    protected FormRowSet getPropertyGridOptions(String name) {
        return Optional.ofNullable((Object[]) getProperty(name)).stream()
                .flatMap(Arrays::stream)
                .map(o -> (Map<String, String>)o)
                .map(m -> new FormRow() {{
                    String value = String.valueOf(m.get("value"));
                    String label = String.valueOf(m.get("label"));

                    setProperty(FormUtil.PROPERTY_VALUE, value);
                    setProperty(FormUtil.PROPERTY_LABEL, label.isEmpty() ? value : label);
                }})
                .collect(Collectors.toCollection(FormRowSet::new));
    }
}
