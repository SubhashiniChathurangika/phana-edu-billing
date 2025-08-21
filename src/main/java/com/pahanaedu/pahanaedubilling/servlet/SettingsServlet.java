package com.pahanaedu.pahanaedubilling.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class SettingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // For now, just show a simple settings page
        // In a real application, you would load settings from database or configuration files
        request.getRequestDispatcher("settings.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("update".equals(action)) {
            // Handle settings update
            String companyName = request.getParameter("companyName");
            String companyAddress = request.getParameter("companyAddress");
            String companyPhone = request.getParameter("companyPhone");
            String companyEmail = request.getParameter("companyEmail");
            
            // In a real application, you would save these to database or configuration
            request.setAttribute("successMessage", "Settings updated successfully");
        }
        
        doGet(request, response);
    }
}
