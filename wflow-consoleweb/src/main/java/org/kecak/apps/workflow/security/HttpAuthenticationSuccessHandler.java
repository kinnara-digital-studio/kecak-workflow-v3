package org.kecak.apps.workflow.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class HttpAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        String redirect = request.getParameter("redirect");
        if (redirect != null && !redirect.isEmpty()) {
            // Use the redirect parameter if available
            getRedirectStrategy().sendRedirect(request, response, redirect);
        }

        super.onAuthenticationSuccess(request, response, authentication);
    }
}
