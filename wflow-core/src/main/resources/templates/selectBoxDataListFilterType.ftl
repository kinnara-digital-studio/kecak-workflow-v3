<div style="padding-right: 8px;">
    <#assign elementId = elementUniqueKey! + "_" + name! + "_Filter" >

    <select class="chosen-select" id="${elementId}" name="${name!}" ${multivalue!}>
        <#list options as option>
            <option value="${option.value!?html}" <#if values?? && values?seq_contains(option.value!)>selected</#if>>${option.label!?html}</option>
        </#list>
    </select>
</div>
