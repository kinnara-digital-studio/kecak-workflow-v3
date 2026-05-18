<%@ include file="/WEB-INF/jsp/includes/taglibs.jsp" %>

<commons:popupHeader />

    <div id="main-body-header">
        <fmt:message key="console.setting.apiKeys.create.label.title"/>
    </div>

    <div id="main-body-content">
        <form:form id="createApiKey" action="${pageContext.request.contextPath}/web/console/setting/apiKeys/submit/create" method="POST" commandName="apiKey" cssClass="form">
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
                <div class="form-row">
                    <label for="impersonates"><fmt:message key="console.setting.apiKeys.common.label.impersonates"/></label>
                    <span class="form-input"><form:select path="impersonates" cssErrorClass="form-input-error">
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
                    <span class="form-input"><form:input path="validUntil" cssErrorClass="form-input-error" size="20" placeholder="YYYY-MM-DD" class="validUntilDatepicker"/></span>
                </div>
                <div class="form-row">
                    <label for="active"><fmt:message key="console.setting.apiKeys.common.label.active"/></label>
                    <span class="form-input"><form:checkbox path="active" cssErrorClass="form-input-error" value="true" checked="checked"/></span>
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
            $("#createApiKey").submit();
        }

        function closeDialog() {
            if (parent && parent.PopupDialog.closeDialog) {
                parent.PopupDialog.closeDialog();
            }
            return false;
        }

        Calendar.show("validUntil");
    </script>
<commons:popupFooter />
