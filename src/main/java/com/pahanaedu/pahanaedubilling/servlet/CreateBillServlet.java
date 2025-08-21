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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pahanaedu.pahanaedubilling.util.DBConnection;


public class CreateBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try (Connection conn = DBConnection.getConnection()) {
            
            // Get all customers for dropdown
            List<Map<String, Object>> customers = getAllCustomers(conn);
            request.setAttribute("customers", customers);
            
            // Get all items for dropdown
            List<Map<String, Object>> items = getAllItems(conn);
            request.setAttribute("items", items);
            
            request.getRequestDispatcher("create-bill.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String customerId = request.getParameter("customerId");
        String[] itemIds = request.getParameterValues("itemId");
        String[] quantities = request.getParameterValues("quantity");
        
        if (customerId == null || itemIds == null || quantities == null) {
            request.setAttribute("errorMessage", "Please select customer and items");
            doGet(request, response);
            return;
        }
        
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            
            try {
                // Create bill
                String createBillSql = "INSERT INTO bills (customer_id, total, created_by) VALUES (?, 0, ?)";
                PreparedStatement pstmt = conn.prepareStatement(createBillSql, PreparedStatement.RETURN_GENERATED_KEYS);
                pstmt.setInt(1, Integer.parseInt(customerId));
                pstmt.setInt(2, (Integer) request.getSession().getAttribute("userId"));
                pstmt.executeUpdate();
                
                // Get generated bill ID
                ResultSet rs = pstmt.getGeneratedKeys();
                int billId = 0;
                if (rs.next()) {
                    billId = rs.getInt(1);
                }
                
                double totalAmount = 0.0;
                
                // Add bill items
                for (int i = 0; i < itemIds.length; i++) {
                    if (itemIds[i] != null && !itemIds[i].trim().isEmpty() && 
                        quantities[i] != null && !quantities[i].trim().isEmpty()) {
                        
                        int itemId = Integer.parseInt(itemIds[i]);
                        int quantity = Integer.parseInt(quantities[i]);
                        
                        // Get item price
                        String getItemSql = "SELECT price FROM items WHERE id = ?";
                        pstmt = conn.prepareStatement(getItemSql);
                        pstmt.setInt(1, itemId);
                        rs = pstmt.executeQuery();
                        
                        if (rs.next()) {
                            double price = rs.getDouble("price");
                            double lineTotal = price * quantity;
                            totalAmount += lineTotal;
                            
                            // Insert bill item
                            String insertBillItemSql = "INSERT INTO bill_items (bill_id, item_id, quantity, unit_price, line_total) VALUES (?, ?, ?, ?, ?)";
                            pstmt = conn.prepareStatement(insertBillItemSql);
                            pstmt.setInt(1, billId);
                            pstmt.setInt(2, itemId);
                            pstmt.setInt(3, quantity);
                            pstmt.setDouble(4, price);
                            pstmt.setDouble(5, lineTotal);
                            pstmt.executeUpdate();
                        }
                    }
                }
                
                // Update bill total
                String updateBillSql = "UPDATE bills SET total = ? WHERE id = ?";
                pstmt = conn.prepareStatement(updateBillSql);
                pstmt.setDouble(1, totalAmount);
                pstmt.setInt(2, billId);
                pstmt.executeUpdate();
                
                conn.commit();
                
                // Redirect to view bill
                response.sendRedirect("view-bill?id=" + billId);
                
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error creating bill: " + e.getMessage());
            doGet(request, response);
        }
    }

    private List<Map<String, Object>> getAllCustomers(Connection conn) throws SQLException {
        List<Map<String, Object>> customers = new ArrayList<>();
        
        String sql = "SELECT id, name, phone FROM customers ORDER BY name";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Map<String, Object> customer = new HashMap<>();
            customer.put("id", rs.getInt("id"));
            customer.put("name", rs.getString("name"));
            customer.put("telephone", rs.getString("phone"));
            customers.add(customer);
        }
        
        return customers;
    }

    private List<Map<String, Object>> getAllItems(Connection conn) throws SQLException {
        List<Map<String, Object>> items = new ArrayList<>();
        
        String sql = "SELECT id, name, price, qty, category FROM items WHERE qty > 0 ORDER BY name";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Map<String, Object> item = new HashMap<>();
            item.put("id", rs.getInt("id"));
            item.put("name", rs.getString("name"));
            item.put("price", rs.getDouble("price"));
            item.put("qty", rs.getInt("qty"));
            item.put("category", rs.getString("category"));
            items.add(item);
        }
        
        return items;
    }
}
