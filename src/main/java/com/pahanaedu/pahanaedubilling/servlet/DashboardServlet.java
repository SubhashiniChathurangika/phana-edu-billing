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


public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try (Connection conn = DBConnection.getConnection()) {
            
            // Get dashboard statistics
            Map<String, Object> stats = getDashboardStats(conn);
            request.setAttribute("stats", stats);
            
            // Get recent bills
            List<Map<String, Object>> recentBills = getRecentBills(conn);
            request.setAttribute("recentBills", recentBills);
            
            // Forward to dashboard JSP
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }

    private Map<String, Object> getDashboardStats(Connection conn) throws SQLException {
        Map<String, Object> stats = new HashMap<>();
        
        // Total bills
        String totalBillsSql = "SELECT COUNT(*) as total FROM bills";
        try (PreparedStatement pstmt = conn.prepareStatement(totalBillsSql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                stats.put("totalBills", rs.getInt("total"));
            }
        }
        
        // Total revenue
        String totalRevenueSql = "SELECT SUM(total) as total FROM bills WHERE status = 'PAID'";
        try (PreparedStatement pstmt = conn.prepareStatement(totalRevenueSql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                stats.put("totalRevenue", rs.getDouble("total"));
            }
        }
        
        // Pending bills
        String pendingBillsSql = "SELECT COUNT(*) as total FROM bills WHERE status = 'PENDING'";
        try (PreparedStatement pstmt = conn.prepareStatement(pendingBillsSql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                stats.put("pendingBills", rs.getInt("total"));
            }
        }
        
        // Total customers
        String totalCustomersSql = "SELECT COUNT(*) as total FROM customers";
        try (PreparedStatement pstmt = conn.prepareStatement(totalCustomersSql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                stats.put("totalCustomers", rs.getInt("total"));
            }
        }
        
        return stats;
    }

    private List<Map<String, Object>> getRecentBills(Connection conn) throws SQLException {
        List<Map<String, Object>> bills = new ArrayList<>();
        
        String sql = "SELECT b.id, b.total, b.bill_date, b.status, c.name as customer_name " +
                    "FROM bills b " +
                    "JOIN customers c ON b.customer_id = c.id " +
                    "ORDER BY b.bill_date DESC " +
                    "LIMIT 5";
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> bill = new HashMap<>();
                bill.put("id", rs.getInt("id"));
                bill.put("total", rs.getDouble("total"));
                bill.put("billDate", rs.getTimestamp("bill_date"));
                bill.put("status", rs.getString("status"));
                bill.put("customerName", rs.getString("customer_name"));
                bills.add(bill);
            }
        }
        
        return bills;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
