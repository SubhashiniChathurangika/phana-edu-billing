package com.pahanaedu.pahanaedubilling.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pahanaedu.pahanaedubilling.util.DBConnection;


public class CustomersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            showAddForm(request, response);
        } else if ("edit".equals(action)) {
            showEditForm(request, response);
        } else if ("delete".equals(action)) {
            deleteCustomer(request, response);
        } else {
            listCustomers(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addCustomer(request, response);
        } else if ("edit".equals(action)) {
            updateCustomer(request, response);
        } else {
            doGet(request, response);
        }
    }

    private void listCustomers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try (Connection conn = DBConnection.getConnection()) {
            
            String search = request.getParameter("search");
            
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT id, name, address, phone, email, created_at ");
            sql.append("FROM customers ");
            
            List<Object> params = new ArrayList<>();
            
            if (search != null && !search.trim().isEmpty()) {
                sql.append("WHERE name LIKE ? OR email LIKE ? OR phone LIKE ? ");
                params.add("%" + search.trim() + "%");
                params.add("%" + search.trim() + "%");
                params.add("%" + search.trim() + "%");
            }
            
            sql.append("ORDER BY name");
            
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = pstmt.executeQuery();
            List<Map<String, Object>> customers = new ArrayList<>();
            
            while (rs.next()) {
                Map<String, Object> customer = new HashMap<>();
                customer.put("id", rs.getInt("id"));
                customer.put("name", rs.getString("name"));
                customer.put("address", rs.getString("address"));
                customer.put("telephone", rs.getString("phone"));
                customer.put("email", rs.getString("email"));
                customer.put("createdAt", rs.getTimestamp("created_at"));
                customers.add(customer);
            }
            
            request.setAttribute("customers", customers);
            request.setAttribute("search", search);
            request.getRequestDispatcher("customers.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("add-customer.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String customerId = request.getParameter("id");
        
        if (customerId == null || customerId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Customer ID is required");
            return;
        }
        
        try (Connection conn = DBConnection.getConnection()) {
            
            String sql = "SELECT id, name, address, phone, email FROM customers WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(customerId));
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Map<String, Object> customer = new HashMap<>();
                customer.put("id", rs.getInt("id"));
                customer.put("name", rs.getString("name"));
                customer.put("address", rs.getString("address"));
                customer.put("telephone", rs.getString("phone"));
                customer.put("email", rs.getString("email"));
                
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("edit-customer.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Customer not found");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }

    private void addCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        String email = request.getParameter("email");
        
        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Customer name is required");
            request.getRequestDispatcher("add-customer.jsp").forward(request, response);
            return;
        }
        
        try (Connection conn = DBConnection.getConnection()) {
            
            String sql = "INSERT INTO customers (name, address, phone, email) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name.trim());
            pstmt.setString(2, address != null ? address.trim() : null);
            pstmt.setString(3, telephone != null ? telephone.trim() : null);
            pstmt.setString(4, email != null ? email.trim() : null);
            
            pstmt.executeUpdate();
            
            response.sendRedirect("customers?success=Customer added successfully");
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error adding customer: " + e.getMessage());
            request.getRequestDispatcher("add-customer.jsp").forward(request, response);
        }
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String customerId = request.getParameter("id");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        String email = request.getParameter("email");
        
        if (customerId == null || customerId.trim().isEmpty() || 
            name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Customer ID and name are required");
            request.getRequestDispatcher("edit-customer.jsp").forward(request, response);
            return;
        }
        
        try (Connection conn = DBConnection.getConnection()) {
            
            String sql = "UPDATE customers SET name = ?, address = ?, phone = ?, email = ? WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name.trim());
            pstmt.setString(2, address != null ? address.trim() : null);
            pstmt.setString(3, telephone != null ? telephone.trim() : null);
            pstmt.setString(4, email != null ? email.trim() : null);
            pstmt.setInt(5, Integer.parseInt(customerId));
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                response.sendRedirect("customers?success=Customer updated successfully");
            } else {
                request.setAttribute("errorMessage", "Customer not found");
                request.getRequestDispatcher("edit-customer.jsp").forward(request, response);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error updating customer: " + e.getMessage());
            request.getRequestDispatcher("edit-customer.jsp").forward(request, response);
        }
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String customerId = request.getParameter("id");
        
        if (customerId == null || customerId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Customer ID is required");
            return;
        }
        
        try (Connection conn = DBConnection.getConnection()) {
            
            String sql = "DELETE FROM customers WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(customerId));
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                response.getWriter().write("{\"success\": true, \"message\": \"Customer deleted successfully\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Customer not found\"}");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"Database error occurred\"}");
        }
    }
}
