<div class="form-cell" ${elementMetaData!}>
    <script type="text/javascript" src="${request.contextPath}/node_modules/select2/dist/js/select2.full.min.js"></script>
    <link rel="stylesheet" href="${request.contextPath}/node_modules/select2/dist/css/select2.min.css">
    <script type="text/javascript" src="${request.contextPath}/js/select2.kecak.js"></script>

    <label class="label" for="${elementParamName!}${element.properties.elementUniqueKey!}" field-tooltip="${elementParamName!}">${element.properties.label} <span class="form-cell-validator">${decoration}</span><#if error??> <span class="form-error-message">${error}</span></#if></label>
    <#if (element.properties.readonly! == 'true' && element.properties.readonlyLabel! == 'true') >
        <div class="form-cell-value">
            <#list options as option>
                <#if values?? && values?seq_contains(option.value!)>
                    <label class="readonly_label">
                        <span>${option.label!?html}</span>
                    </label>
                </#if>
            </#list>
        </div>
        <div style="clear:both;"></div>
    <#else>
        <style>
            .select2-container {
                margin-bottom:18px !important;
            }

            .select2-search--dropdown .select2-search__field{
                float:none !important;
            }
        </style>
        <select class="js-select2" <#if element.properties.readonly! != 'true'>id="${elementParamName!}${element.properties.elementUniqueKey!}"</#if> name="${elementParamName!}" <#if element.properties.size?? && element.properties.size != ''> style="width:${element.properties.size!}%"</#if> <#if element.properties.multiple! == 'true'>multiple="multiple" data-role="none" data-native-menu="true"</#if> <#if error??>class="form-error-cell"</#if> <#if element.properties.readonly! == 'true'> disabled </#if>>
            <#if element.properties.lazyLoading! != 'true' >
                <#list options as option>
                    <option value="${option.value!?html}" grouping="${option.grouping!?html}" <#if values?? && values?seq_contains(option.value!)>selected</#if> <#if element.properties.readonly! == 'true'>disabled</#if>>${option.label!?html}</option>
                </#list>
            <#else>
                <#list options! as option>
                    <#if values?? && values?seq_contains(option.value!) || option.value == ''>
                        <option value="${option.value!?html}" grouping="${option.grouping!?html}" <#if values?? && values?seq_contains(option.value!)>selected</#if>>${option.label!?html}</option>
                    </#if>
                </#list>
            </#if>
        </select>
    </#if>

    <#if element.properties.readonly! == 'true'>    
        <#list values as value>
            <input type="hidden" id="${elementParamName!}" name="${elementParamName!}" value="${value?html}" />
        </#list>
    </#if>

    <#if (element.properties.controlField?? && element.properties.controlField! != "" && !(element.properties.readonly! == 'true' && element.properties.readonlyLabel! == 'true')) >
        <script type="text/javascript">
            $(document).ready(function(){
                $("#${elementParamName!}${element.properties.elementUniqueKey!}").dynamicOptions({
                    controlField : "${element.properties.controlFieldParamName!}",
                    paramName : "${elementParamName!}",
                    type : "selectbox",
                    readonly : "${element.properties.readonly!}",
                    nonce : "${element.properties.nonce!}",
                    binderData : "${element.properties.binderData!}",
                    appId : "${element.properties.appId!}",
                    appVersion : "${element.properties.appVersion!}",
                    contextPath : "${request.contextPath}"
                });
            });
        </script>
    </#if>

    <#-- Select2 Implementation -->
    <script type="text/javascript">
        $(document).ready(function(){
            let $selectbox = $('select#${elementParamName!}${element.properties.elementUniqueKey!}.js-select2').kecakSelect2({
                dropdownAutoWidth : true,
                width : '${(element.properties.size)!"70"}%',
                theme : 'default',
                language : {
                   errorLoading: () => '${element.properties.messageErrorLoading!'@@form.selectbox.messageErrorLoading.value@@'}',
                   loadingMore: () => '${element.properties.messageLoadingMore!'@@form.selectbox.messageLoadingMore.value@@'}',
                   noResults: () => '${element.properties.messageNoResults!'@@form.selectbox.messageNoResults.value@@'}',
                   searching: () => '${element.properties.messageSearching!'@@form.selectbox.messageSearching.value@@'}'
                }

                <#if element.properties.lazyLoading! == 'true' && element.properties.controlField! != ''>
                    ,ajax: {
                        url: '${request.contextPath}/web/json/app/${appId!}/${appVersion!}/plugin/${className}/service',
                        delay : 500,
                        dataType: 'json',
                        data : function(params) {
                            return {
                                search: params.term,
                                formDefId : '${formDefId!}',
                                fieldId : '${element.properties.id!}',
                                nonce : "${element.properties.nonce!}",
                                binderData : "${element.properties.binderData!}",
                                grouping : FormUtil.getValue('${element.properties.controlField!}'),
                                page : params.page || 1
                            };
                        }
                    }
                </#if>
            });
        });
    </script>
</div>
