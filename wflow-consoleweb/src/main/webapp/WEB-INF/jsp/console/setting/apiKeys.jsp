<%@ include file="/WEB-INF/jsp/includes/taglibs.jsp"%>
<%@ page import="org.joget.workflow.util.WorkflowUtil,org.joget.commons.util.HostManager"%>

<c:set var="isVirtualHostEnabled" value="<%=HostManager.isVirtualHostEnabled()%>" />

<commons:header />

<div id="nav">
	<div id="nav-title">
		<p>
			<i class="icon-cogs"></i>
			<fmt:message key='console.header.top.label.settings' />
		</p>
	</div>
	<div id="nav-body">
		<ul id="nav-list">
			<jsp:include page="subMenu.jsp" flush="true" />
		</ul>
	</div>
</div>

<div id="main">
	<div id="main-title"></div>
	<div id="main-action">
		<ul id="main-action-buttons">
			<li><button onclick="onCreate()">
					<fmt:message key="console.setting.apiKeys.create.label" />
				</button></li>
		</ul>
	</div>
	<div id="main-body">
		<ui:jsontable
			url="${pageContext.request.contextPath}/web/json/console/setting/apiKeys/list?${pageContext.request.queryString}"
			var="JsonDataTable"
			divToUpdate="apiKeysContentList"
			jsonData="data"
			rowsPerPage="10"
			width="100%"
			sort="apiKey" desc="false"
			href="${pageContext.request.contextPath}/web/console/setting/apiKeys/edit"
			hrefParam="id"
			hrefQuery="false"
			hrefDialog="true"
			hrefDialogTitle=""
			checkbox="true"
			checkboxButton2="general.method.label.delete"
			checkboxCallback2="apiKeysDelete"
			searchItems="apiKey|impersonates|remark"
			fields="['id','impersonates','remark','active','dateCreated','createdBy','validUntil']"
			column1="{key: 'impersonates', label: 'console.setting.apiKeys.common.label.impersonates', sortable: true}"
			column2="{key: 'remark', label: 'console.setting.apiKeys.common.label.remark', sortable: true}"
			column3="{key: 'active', label: 'console.setting.apiKeys.common.label.active', sortable: true}"
			column4="{key: 'dateCreated', label: 'console.setting.apiKeys.common.label.dateCreated', sortable: true}"
			column5="{key: 'createdBy', label: 'console.setting.apiKeys.common.label.createdBy', sortable: true}"
			column6="{key: 'validUntil', label: 'console.setting.apiKeys.common.label.validUntil', sortable: true}"/>
	</div>
</div>

<script>
    $(document).ready(function(){
        $('#JsonDataTable_searchTerm').hide();

    });

    <ui:popupdialog var="popupDialog" src="${pageContext.request.contextPath}/web/console/setting/apiKeys/create"/>

    function onCreate(){
        popupDialog.init();
    }

    function closeDialog() {
        popupDialog.close();
    }


	function apiKeysDelete(selectedList) {
		if (confirm('<fmt:message key="console.setting.apiKeys.delete.label.confirmation"/>')) {

			var callback = {
				success : function() {
					filter(JsonDataTable, '', '');
				}
			}
			var request = ConnectionManager.post('${pageContext.request.contextPath}/web/console/setting/apiKeys/delete', callback, 'ids=' + selectedList);
		}
	}
</script>

<script>
	Template.init("", "#nav-setting-api-keys");
</script>

<commons:footer />
