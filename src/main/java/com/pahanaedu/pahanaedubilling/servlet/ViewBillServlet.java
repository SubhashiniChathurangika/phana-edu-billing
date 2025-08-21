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


public class ViewBillServlet extends HttpServlet {
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
            

            
            request.setAttribute("bill", billDetails);
            request.setAttribute("billItems", billItems);
            
            request.getRequestDispatcher("view-bill.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }

    private Map<String, Object> getBillDetails(Connection conn, int billId) throws SQLException {
        String sql = "SELECT b.id, b.total, b.bill_date, b.status, " +
                    "c.name as customer_name, c.address, c.phone, c.email, " +
                    "u.username as created_by_user " +
                    "FROM bills b " +
                    "JOIN customers c ON b.customer_id = c.id " +
                    "LEFT JOIN users u ON b.created_by = u.id " +
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
            bill.put("customerName", rs.getString("customer_name"));
            bill.put("customerAddress", rs.getString("address"));
            bill.put("customerTelephone", rs.getString("phone"));
            bill.put("customerEmail", rs.getString("email"));
            bill.put("createdBy", rs.getString("created_by_user"));
            return bill;
        }
        
        return null;
    }

    private List<Map<String, Object>> getBillItems(Connection conn, int billId) throws SQLException {
        List<Map<String, Object>> items = new ArrayList<>();
        
        String sql = "SELECT bi.quantity, bi.unit_price, bi.line_total, " +
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
            item.put("quantity", rs.getInt("quantity"));
            item.put("unitPrice", rs.getDouble("unit_price"));
            item.put("lineTotal", rs.getDouble("line_total"));
            item.put("itemName", rs.getString("item_name"));
            item.put("category", rs.getString("category"));
            items.add(item);
        }
        
        return items;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
