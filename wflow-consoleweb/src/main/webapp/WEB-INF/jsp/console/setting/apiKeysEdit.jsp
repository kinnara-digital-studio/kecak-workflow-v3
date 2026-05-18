<%@ include file="/WEB-INF/jsp/includes/taglibs.jsp" %>

<commons:popupHeader />

    <div id="main-body-header">
        <fmt:message key="console.setting.apiKeys.edit.label.title"/>
    </div>

    <div id="main-body-content">
        <form:form id="editApiKey" action="${pageContext.request.contextPath}/web/console/setting/apiKeys/submit/edit" method="POST" commandName="apiKey" cssClass="form">
            <form:errors path="*" cssClass="form-errors"/>
            <c:if test="${!empty errors}">
                <span class="form-errors" style="display:block">
                    <c:forEach items="${errors}" var="error">
                        <fmt:message key="${error}"/>
                    </c:forEach>
                </span>
            </c:if>
            <fieldset>
                <legend><fmt:message key="console.setting.apiKeys.common.label.details"/></legend>
                <input id="id" type="hidden" value="${apiKey.id}" name="id"/>
                <div class="form-row">
                    <label for="apiKey"><fmt:message key="console.setting.apiKeys.common.label.key"/></label>
                    <span class="form-input">
                        <form:textarea id="apiKey" path="apiKey" cssErrorClass="form-input-error" rows="4" cols="60" readonly="true"/>
                        <i class="fas fa-copy" onclick="copyToClipboard()" style="cursor: pointer; margin-left: 10px; margin-top: 10px; vertical-align: top;" title="Copy to clipboard"></i>
                    </span>
                </div>
                <div class="form-row">
                    <label for="impersonates"><fmt:message key="console.setting.apiKeys.common.label.impersonates"/></label>
                    <form:select path="impersonates" cssErrorClass="form-input-error" readonly="true" disabled="true">
                        <form:option value="" label=""/>
                        <form:options items="${users}" itemValue="username" itemLabel="username"/>
                    </form:select></span>
                </div>
                <div class="form-row">
                    <label for="remark"><fmt:message key="console.setting.apiKeys.common.label.remark"/></label>
                    <span class="form-input"><form:input path="remark" cssErrorClass="form-input-error" size="50"/></span>
                </div>
                <div class="form-row">
                     <label for="validUntil"><fmt:message key="console.setting.apiKeys.common.label.validUntil"/></label>
                     <span class="form-input"><form:input path="validUntil" cssErrorClass="form-input-error" size="20" placeholder="YYYY-MM-DD" class="validUntilDatepicker" readonly="true" disabled="true"/></span>
                 </div>
                <div class="form-row">
                    <label for="active"><fmt:message key="console.setting.apiKeys.common.label.active"/></label>
                    <span class="form-input"><form:checkbox path="active" cssErrorClass="form-input-error"/></span>
                </div>
            </fieldset>
            <div class="form-buttons">
                <input class="form-button" type="button" value="<fmt:message key="general.method.label.save"/>"  onclick="validateField()"/>
                <input class="form-button" type="button" value="<fmt:message key="general.method.label.cancel"/>" onclick="closeDialog()"/>
            </div>
        </form:form>
    </div>

    <script type="text/javascript">
        function validateField(){
            // For edit, we don't validate the key since it's readonly
            $("#editApiKey").submit();
        }

        function closeDialog() {
            if (parent && parent.PopupDialog.closeDialog) {
                parent.PopupDialog.closeDialog();
            }
            return false;
        }

        function copyToClipboard() {
            var apiKeyText = document.getElementById("apiKey").value;
            if (apiKeyText) {
                navigator.clipboard.writeText(apiKeyText).then(function() {
                    alert('<fmt:message key="console.setting.apiKeys.label.copied"/>');
                }).catch(function(err) {
                    alert('Failed to copy to clipboard');
                });
            } else {
                alert('No API Key to copy');
            }
        }

        Calendar.show("validUntil");

    </script>
<commons:popupFooter />
