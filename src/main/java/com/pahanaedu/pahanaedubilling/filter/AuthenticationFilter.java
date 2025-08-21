package com.pahanaedu.pahanaedubilling.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthenticationFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        // Check if user is logged in
        boolean isLoggedIn = (session != null && session.getAttribute("isLoggedIn") != null && 
                             (Boolean) session.getAttribute("isLoggedIn"));
        
        // Get the requested URI
        String requestURI = httpRequest.getRequestURI();
        
        // Allow access to login page and static resources
        if (requestURI.contains("/login") || 
            requestURI.contains("/css/") || 
            requestURI.contains("/js/") || 
            requestURI.contains("/images/") ||
            requestURI.contains("/fonts/") ||
            requestURI.endsWith(".css") ||
            requestURI.endsWith(".js") ||
            requestURI.endsWith(".png") ||
            requestURI.endsWith(".jpg") ||
            requestURI.endsWith(".jpeg") ||
            requestURI.endsWith(".gif") ||
            requestURI.endsWith(".ico")) {
            
            chain.doFilter(request, response);
            return;
        }
        
        // If not logged in, redirect to login page
        if (!isLoggedIn) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
            return;
        }
        
        // User is logged in, continue with the request
        chain.doFilter(request, response);
    }

    public void destroy() {
        // Cleanup code if needed
    }
}
