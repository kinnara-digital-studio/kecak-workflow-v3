package org.kecak.apps.workflow.security;

import com.kinnarastudio.commons.Try;
import org.joget.commons.util.LogUtil;
import org.joget.workflow.model.service.WorkflowUserManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

public class JwtAuthSuccessHandler implements AuthenticationSuccessHandler {
    private WorkflowUserManager workflowUserManager;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        UserDetails currentUser = (UserDetails) authentication.getPrincipal();
        workflowUserManager.setCurrentThreadUser(currentUser.getUsername());

        Optional<String> loginAs = getOptionalParameter(request, "loginAs");
        if (loginAs.isPresent() && workflowUserManager.isCurrentUserInRole(WorkflowUserManager.ROLE_ADMIN)) {
            String loginAsUser = loginAs.get();
            LogUtil.info(getClass().getName(), "Login As [" + loginAsUser + "]");
            workflowUserManager.setCurrentThreadUser(loginAsUser);
        }
    }

    public void setWorkflowUserManager(WorkflowUserManager workflowUserManager) {
        this.workflowUserManager = workflowUserManager;
    }

    /**
     * Get optional parameter for http request
     *
     * @param request
     * @param parameterName
     * @return
     */
    protected Optional<String> getOptionalParameter(HttpServletRequest request, String parameterName) {
        return Optional.of(parameterName)
                .map(request::getParameter)
                .map(String::trim)
                .filter(Try.onPredicate(String::isEmpty).negate());
    }
}
