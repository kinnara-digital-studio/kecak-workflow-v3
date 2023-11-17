package org.kecak.webapi.security;


import org.kecak.apps.workflow.security.JwtAuthenticationToken;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class WorkflowJwtAuthProcessingFilter extends AbstractAuthenticationProcessingFilter {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    public final static String TOKEN_HEADER = "Authorization";

    protected WorkflowJwtAuthProcessingFilter() {
        super(new AntPathRequestMatcher("/**"));
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException, IOException, ServletException {
        String header = request.getHeader(TOKEN_HEADER);
        if (header != null && header.startsWith("Bearer ")) {
            String jwtToken = header.substring(7);
            Authentication authenticationToken = new JwtAuthenticationToken(jwtToken);
            return getAuthenticationManager().authenticate(authenticationToken);
        }

        // unsuccessful authentication
        return new JwtAuthenticationToken(null);
    }

    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain, Authentication authResult) throws IOException, ServletException {
        if(authResult.isAuthenticated()) {
            super.successfulAuthentication(request, response, chain, authResult);
        }
        chain.doFilter(request, response);
    }
}
