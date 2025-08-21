package com.pahanaedu.pahanaedubilling.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pahanaedu.pahanaedubilling.util.DBConnection;


public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username and password are required");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT id, username, password, role FROM users WHERE username = ? AND password = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username.trim());
            pstmt.setString(2, password.trim());
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                // Login successful
                HttpSession session = request.getSession();
                session.setAttribute("userId", rs.getInt("id"));
                session.setAttribute("username", rs.getString("username"));
                session.setAttribute("role", rs.getString("role"));
                session.setAttribute("isLoggedIn", true);
                
                // Redirect to dashboard
                response.sendRedirect("dashboard");
            } else {
                // Login failed
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error occurred. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect GET requests to login page
        response.sendRedirect("login.jsp");
    }
}
