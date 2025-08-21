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


public class EditBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String billId = request.getParameter("id");
        
        if (billId == null || billId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Bill ID is required");
            return;
        }
        
        try (Connection conn = DBConnection.getConnection()) {
            
            // Get bill details
            Map<String, Object> billDetails = getBillDetails(conn, Integer.parseInt(billId));
            if (billDetails == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Bill not found");
                return;
            }
            
            // Get bill items
            List<Map<String, Object>> billItems = getBillItems(conn, Integer.parseInt(billId));
            
            // Get all customers for dropdown
            List<Map<String, Object>> customers = getAllCustomers(conn);
            
            // Get all items for dropdown
            List<Map<String, Object>> items = getAllItems(conn);
            
            request.setAttribute("bill", billDetails);
            request.setAttribute("billItems", billItems);
            request.setAttribute("customers", customers);
            request.setAttribute("items", items);
            
            request.getRequestDispatcher("edit-bill.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String billId = request.getParameter("billId");
        String customerId = request.getParameter("customerId");
        String status = request.getParameter("status");
        
        if (billId == null || billId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Bill ID is required");
            return;
        }
        
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            
            try {
                // Update bill status
                String updateBillSql = "UPDATE bills SET status = ? WHERE id = ?";
                PreparedStatement pstmt = conn.prepareStatement(updateBillSql);
                pstmt.setString(1, status);
                pstmt.setInt(2, Integer.parseInt(billId));
                pstmt.executeUpdate();
                
                conn.commit();
                
                response.sendRedirect("view-bill?id=" + billId + "&success=Bill updated successfully");
                
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error updating bill: " + e.getMessage());
            doGet(request, response);
        }
    }

    private Map<String, Object> getBillDetails(Connection conn, int billId) throws SQLException {
        String sql = "SELECT b.id, b.total, b.bill_date, b.status, " +
                    "c.id as customer_id, c.name as customer_name, c.address, c.phone, c.email " +
                    "FROM bills b " +
                    "JOIN customers c ON b.customer_id = c.id " +
                    "WHERE b.id = ?";
        
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, billId);
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            Map<String, Object> bill = new HashMap<>();
            bill.put("id", rs.getInt("id"));
            bill.put("total", rs.getDouble("total"));
            bill.put("billDate", rs.getTimestamp("bill_date"));
            bill.put("status", rs.getString("status"));
            bill.put("customerId", rs.getInt("customer_id"));
            bill.put("customerName", rs.getString("customer_name"));
            bill.put("customerAddress", rs.getString("address"));
            bill.put("customerTelephone", rs.getString("phone"));
            bill.put("customerEmail", rs.getString("email"));
            return bill;
        }
        
        return null;
    }

    private List<Map<String, Object>> getBillItems(Connection conn, int billId) throws SQLException {
        List<Map<String, Object>> items = new ArrayList<>();
        
        String sql = "SELECT bi.item_id, bi.quantity, bi.unit_price, bi.line_total, " +
                    "i.name as item_name, i.category " +
                    "FROM bill_items bi " +
                    "JOIN items i ON bi.item_id = i.id " +
                    "WHERE bi.bill_id = ? " +
                    "ORDER BY bi.bill_item_id";
        
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, billId);
        ResultSet rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Map<String, Object> item = new HashMap<>();
            item.put("itemId", rs.getInt("item_id"));
            item.put("quantity", rs.getInt("quantity"));
            item.put("unitPrice", rs.getDouble("unit_price"));
            item.put("lineTotal", rs.getDouble("line_total"));
            item.put("itemName", rs.getString("item_name"));
            item.put("category", rs.getString("category"));
            items.add(item);
        }
        
        return items;
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
        
        String sql = "SELECT id, name, price, category FROM items ORDER BY name";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Map<String, Object> item = new HashMap<>();
            item.put("id", rs.getInt("id"));
            item.put("name", rs.getString("name"));
            item.put("price", rs.getDouble("price"));
            item.put("category", rs.getString("category"));
            items.add(item);
        }
        
        return items;
    }
}
