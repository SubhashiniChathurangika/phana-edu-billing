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


public class ReportsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String reportType = request.getParameter("type");
        
        if (reportType == null) {
            reportType = "summary";
        }
        
        try (Connection conn = DBConnection.getConnection()) {
            
            switch (reportType) {
                case "summary":
                    generateSummaryReport(request, response, conn);
                    break;
                case "bills":
                    generateBillsReport(request, response, conn);
                    break;
                case "customers":
                    generateCustomersReport(request, response, conn);
                    break;
                case "items":
                    generateItemsReport(request, response, conn);
                    break;
                default:
                    generateSummaryReport(request, response, conn);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }

    private void generateSummaryReport(HttpServletRequest request, HttpServletResponse response, Connection conn) 
            throws SQLException, ServletException, IOException {
        
        Map<String, Object> summary = new HashMap<>();
        
        // Total revenue
        String totalRevenueSql = "SELECT SUM(total) as total FROM bills WHERE status = 'PAID'";
        try (PreparedStatement pstmt = conn.prepareStatement(totalRevenueSql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                summary.put("totalRevenue", rs.getDouble("total"));
            }
        }
        
        // Total bills
        String totalBillsSql = "SELECT COUNT(*) as total FROM bills";
        try (PreparedStatement pstmt = conn.prepareStatement(totalBillsSql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                summary.put("totalBills", rs.getInt("total"));
            }
        }
        
        // Paid bills
        String paidBillsSql = "SELECT COUNT(*) as total FROM bills WHERE status = 'PAID'";
        try (PreparedStatement pstmt = conn.prepareStatement(paidBillsSql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                summary.put("paidBills", rs.getInt("total"));
            }
        }
        
        // Pending bills
        String pendingBillsSql = "SELECT COUNT(*) as total FROM bills WHERE status = 'PENDING'";
        try (PreparedStatement pstmt = conn.prepareStatement(pendingBillsSql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                summary.put("pendingBills", rs.getInt("total"));
            }
        }
        
        // Total customers
        String totalCustomersSql = "SELECT COUNT(*) as total FROM customers";
        try (PreparedStatement pstmt = conn.prepareStatement(totalCustomersSql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                summary.put("totalCustomers", rs.getInt("total"));
            }
        }
        
        // Top selling items
        List<Map<String, Object>> topItems = getTopSellingItems(conn);
        summary.put("topItems", topItems);
        
        // Recent bills
        List<Map<String, Object>> recentBills = getRecentBills(conn);
        summary.put("recentBills", recentBills);
        
        request.setAttribute("summary", summary);
        request.setAttribute("reportType", "summary");
        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }

    private void generateBillsReport(HttpServletRequest request, HttpServletResponse response, Connection conn) 
            throws SQLException, ServletException, IOException {
        
        String dateFrom = request.getParameter("dateFrom");
        String dateTo = request.getParameter("dateTo");
        String status = request.getParameter("status");
        
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT b.id, b.total, b.bill_date, b.status, c.name as customer_name ");
        sql.append("FROM bills b ");
        sql.append("JOIN customers c ON b.customer_id = c.id ");
        sql.append("WHERE 1=1 ");
        
        List<Object> params = new ArrayList<>();
        
        if (dateFrom != null && !dateFrom.trim().isEmpty()) {
            sql.append("AND DATE(b.bill_date) >= ? ");
            params.add(dateFrom.trim());
        }
        
        if (dateTo != null && !dateTo.trim().isEmpty()) {
            sql.append("AND DATE(b.bill_date) <= ? ");
            params.add(dateTo.trim());
        }
        
        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND b.status = ? ");
            params.add(status.trim());
        }
        
        sql.append("ORDER BY b.bill_date DESC");
        
        PreparedStatement pstmt = conn.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); i++) {
            pstmt.setObject(i + 1, params.get(i));
        }
        
        ResultSet rs = pstmt.executeQuery();
        List<Map<String, Object>> bills = new ArrayList<>();
        
        while (rs.next()) {
            Map<String, Object> bill = new HashMap<>();
            bill.put("id", rs.getInt("id"));
            bill.put("total", rs.getDouble("total"));
            bill.put("billDate", rs.getTimestamp("bill_date"));
            bill.put("status", rs.getString("status"));
            bill.put("customerName", rs.getString("customer_name"));
            bills.add(bill);
        }
        
        request.setAttribute("bills", bills);
        request.setAttribute("reportType", "bills");
        request.setAttribute("dateFrom", dateFrom);
        request.setAttribute("dateTo", dateTo);
        request.setAttribute("status", status);
        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }

    private void generateCustomersReport(HttpServletRequest request, HttpServletResponse response, Connection conn) 
            throws SQLException, ServletException, IOException {
        
                    String sql = "SELECT c.id, c.name, c.email, c.phone, " +
                    "COUNT(b.id) as total_bills, " +
                    "SUM(CASE WHEN b.status = 'PAID' THEN b.total ELSE 0 END) as total_paid " +
                    "FROM customers c " +
                    "LEFT JOIN bills b ON c.id = b.customer_id " +
                    "GROUP BY c.id, c.name, c.email, c.phone " +
                    "ORDER BY total_paid DESC";
        
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        List<Map<String, Object>> customers = new ArrayList<>();
        
        while (rs.next()) {
            Map<String, Object> customer = new HashMap<>();
            customer.put("id", rs.getInt("id"));
            customer.put("name", rs.getString("name"));
            customer.put("email", rs.getString("email"));
                            customer.put("telephone", rs.getString("phone"));
            customer.put("totalBills", rs.getInt("total_bills"));
            customer.put("totalPaid", rs.getDouble("total_paid"));
            customers.add(customer);
        }
        
        request.setAttribute("customers", customers);
        request.setAttribute("reportType", "customers");
        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }

    private void generateItemsReport(HttpServletRequest request, HttpServletResponse response, Connection conn) 
            throws SQLException, ServletException, IOException {
        
        String sql = "SELECT i.id, i.name, i.category, i.price, i.qty, " +
                    "SUM(bi.quantity) as total_sold, " +
                    "SUM(bi.line_total) as total_revenue " +
                    "FROM items i " +
                    "LEFT JOIN bill_items bi ON i.id = bi.item_id " +
                    "LEFT JOIN bills b ON bi.bill_id = b.id AND b.status = 'PAID' " +
                    "GROUP BY i.id, i.name, i.category, i.price, i.qty " +
                    "ORDER BY total_revenue DESC";
        
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        List<Map<String, Object>> items = new ArrayList<>();
        
        while (rs.next()) {
            Map<String, Object> item = new HashMap<>();
            item.put("id", rs.getInt("id"));
            item.put("name", rs.getString("name"));
            item.put("category", rs.getString("category"));
            item.put("price", rs.getDouble("price"));
            item.put("qty", rs.getInt("qty"));
            item.put("totalSold", rs.getInt("total_sold"));
            item.put("totalRevenue", rs.getDouble("total_revenue"));
            items.add(item);
        }
        
        request.setAttribute("items", items);
        request.setAttribute("reportType", "items");
        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }

    private List<Map<String, Object>> getTopSellingItems(Connection conn) throws SQLException {
        List<Map<String, Object>> items = new ArrayList<>();
        
        String sql = "SELECT i.name, SUM(bi.quantity) as total_sold, SUM(bi.line_total) as total_revenue " +
                    "FROM items i " +
                    "JOIN bill_items bi ON i.id = bi.item_id " +
                    "JOIN bills b ON bi.bill_id = b.id AND b.status = 'PAID' " +
                    "GROUP BY i.id, i.name " +
                    "ORDER BY total_revenue DESC " +
                    "LIMIT 5";
        
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Map<String, Object> item = new HashMap<>();
            item.put("name", rs.getString("name"));
            item.put("totalSold", rs.getInt("total_sold"));
            item.put("totalRevenue", rs.getDouble("total_revenue"));
            items.add(item);
        }
        
        return items;
    }

    private List<Map<String, Object>> getRecentBills(Connection conn) throws SQLException {
        List<Map<String, Object>> bills = new ArrayList<>();
        
        String sql = "SELECT b.id, b.total, b.bill_date, b.status, c.name as customer_name " +
                    "FROM bills b " +
                    "JOIN customers c ON b.customer_id = c.id " +
                    "ORDER BY b.bill_date DESC " +
                    "LIMIT 10";
        
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Map<String, Object> bill = new HashMap<>();
            bill.put("id", rs.getInt("id"));
            bill.put("total", rs.getDouble("total"));
            bill.put("billDate", rs.getTimestamp("bill_date"));
            bill.put("status", rs.getString("status"));
            bill.put("customerName", rs.getString("customer_name"));
            bills.add(bill);
        }
        
        return bills;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
