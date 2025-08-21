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


public class ItemsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            showAddForm(request, response);
        } else if ("edit".equals(action)) {
            showEditForm(request, response);
        } else if ("delete".equals(action)) {
            deleteItem(request, response);
        } else {
            listItems(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addItem(request, response);
        } else if ("edit".equals(action)) {
            updateItem(request, response);
        } else {
            doGet(request, response);
        }
    }

    private void listItems(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try (Connection conn = DBConnection.getConnection()) {
            
            String search = request.getParameter("search");
            String category = request.getParameter("category");
            
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT id, name, price, description, category, created_at ");
            sql.append("FROM items ");
            
            List<Object> params = new ArrayList<>();
            
            if (search != null && !search.trim().isEmpty()) {
                sql.append("WHERE name LIKE ? OR description LIKE ? ");
                params.add("%" + search.trim() + "%");
                params.add("%" + search.trim() + "%");
            }
            
            if (category != null && !category.trim().isEmpty()) {
                if (params.isEmpty()) {
                    sql.append("WHERE category = ? ");
                } else {
                    sql.append("AND category = ? ");
                }
                params.add(category.trim());
            }
            
            sql.append("ORDER BY name");
            
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = pstmt.executeQuery();
            List<Map<String, Object>> items = new ArrayList<>();
            
            while (rs.next()) {
                Map<String, Object> item = new HashMap<>();
                item.put("id", rs.getInt("id"));
                item.put("name", rs.getString("name"));
                item.put("price", rs.getDouble("price"));
                item.put("description", rs.getString("description"));
                item.put("category", rs.getString("category"));
                item.put("createdAt", rs.getTimestamp("created_at"));
                items.add(item);
            }
            
            // Get unique categories for filter
            List<String> categories = getCategories(conn);
            
            request.setAttribute("items", items);
            request.setAttribute("categories", categories);
            request.setAttribute("search", search);
            request.setAttribute("selectedCategory", category);
            request.getRequestDispatcher("items.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("add-item.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String itemId = request.getParameter("id");
        
        if (itemId == null || itemId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Item ID is required");
            return;
        }
        
        try (Connection conn = DBConnection.getConnection()) {
            
            String sql = "SELECT id, name, price,  description, category FROM items WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(itemId));
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Map<String, Object> item = new HashMap<>();
                item.put("id", rs.getInt("id"));
                item.put("name", rs.getString("name"));
                item.put("price", rs.getDouble("price"));
                item.put("description", rs.getString("description"));
                item.put("category", rs.getString("category"));
                
                request.setAttribute("item", item);
                request.getRequestDispatcher("edit-item.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Item not found");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }

    private void addItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String qty = request.getParameter("qty");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        
        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Item name is required");
            request.getRequestDispatcher("add-item.jsp").forward(request, response);
            return;
        }
        
        try (Connection conn = DBConnection.getConnection()) {
            
            String sql = "INSERT INTO items (name, price, qty, description, category) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name.trim());
            pstmt.setDouble(2, price != null ? Double.parseDouble(price) : 0.0);
            pstmt.setInt(3, qty != null ? Integer.parseInt(qty) : 0);
            pstmt.setString(4, description != null ? description.trim() : null);
            pstmt.setString(5, category != null ? category.trim() : null);
            
            pstmt.executeUpdate();
            
            response.sendRedirect("items?success=Item added successfully");
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error adding item: " + e.getMessage());
            request.getRequestDispatcher("add-item.jsp").forward(request, response);
        }
    }

    private void updateItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String itemId = request.getParameter("id");
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String qty = request.getParameter("qty");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        
        if (itemId == null || itemId.trim().isEmpty() || 
            name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Item ID and name are required");
            request.getRequestDispatcher("edit-item.jsp").forward(request, response);
            return;
        }
        
        try (Connection conn = DBConnection.getConnection()) {
            
            String sql = "UPDATE items SET name = ?, price = ?, qty = ?, description = ?, category = ? WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name.trim());
            pstmt.setDouble(2, price != null ? Double.parseDouble(price) : 0.0);
            pstmt.setInt(3, qty != null ? Integer.parseInt(qty) : 0);
            pstmt.setString(4, description != null ? description.trim() : null);
            pstmt.setString(5, category != null ? category.trim() : null);
            pstmt.setInt(6, Integer.parseInt(itemId));
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                response.sendRedirect("items?success=Item updated successfully");
            } else {
                request.setAttribute("errorMessage", "Item not found");
                request.getRequestDispatcher("edit-item.jsp").forward(request, response);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error updating item: " + e.getMessage());
            request.getRequestDispatcher("edit-item.jsp").forward(request, response);
        }
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String itemId = request.getParameter("id");
        
        if (itemId == null || itemId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Item ID is required");
            return;
        }
        
        try (Connection conn = DBConnection.getConnection()) {
            
            String sql = "DELETE FROM items WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(itemId));
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                response.getWriter().write("{\"success\": true, \"message\": \"Item deleted successfully\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Item not found\"}");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"Database error occurred\"}");
        }
    }

    private List<String> getCategories(Connection conn) throws SQLException {
        List<String> categories = new ArrayList<>();
        
        String sql = "SELECT DISTINCT category FROM items WHERE category IS NOT NULL ORDER BY category";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        
        while (rs.next()) {
            categories.add(rs.getString("category"));
        }
        
        return categories;
    }
}
