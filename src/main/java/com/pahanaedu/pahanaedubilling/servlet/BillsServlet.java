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


public class BillsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            deleteBill(request, response);
        } else {
            listBills(request, response);
        }
    }

    private void listBills(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try (Connection conn = DBConnection.getConnection()) {
            
            // Get search and filter parameters
            String search = request.getParameter("search");
            String status = request.getParameter("status");
            String dateFrom = request.getParameter("dateFrom");
            String dateTo = request.getParameter("dateTo");
            
            // Build SQL query with filters
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT b.id, b.total, b.bill_date, b.status, c.name as customer_name ");
            sql.append("FROM bills b ");
            sql.append("JOIN customers c ON b.customer_id = c.id ");
            sql.append("WHERE 1=1 ");
            
            List<Object> params = new ArrayList<>();
            
            if (search != null && !search.trim().isEmpty()) {
                sql.append("AND (c.name LIKE ? OR b.id LIKE ?) ");
                params.add("%" + search.trim() + "%");
                params.add("%" + search.trim() + "%");
            }
            
            if (status != null && !status.trim().isEmpty()) {
                sql.append("AND b.status = ? ");
                params.add(status.trim());
            }
            
            if (dateFrom != null && !dateFrom.trim().isEmpty()) {
                sql.append("AND DATE(b.bill_date) >= ? ");
                params.add(dateFrom.trim());
            }
            
            if (dateTo != null && !dateTo.trim().isEmpty()) {
                sql.append("AND DATE(b.bill_date) <= ? ");
                params.add(dateTo.trim());
            }
            
            sql.append("ORDER BY b.bill_date DESC");
            
            // Execute query
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
            request.setAttribute("search", search);
            request.setAttribute("status", status);
            request.setAttribute("dateFrom", dateFrom);
            request.setAttribute("dateTo", dateTo);
            
            request.getRequestDispatcher("bills.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }

    private void deleteBill(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String billId = request.getParameter("id");
        
        if (billId == null || billId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Bill ID is required");
            return;
        }
        
        try (Connection conn = DBConnection.getConnection()) {
            
            // Delete bill items first (due to foreign key constraint)
            String deleteBillItemsSql = "DELETE FROM bill_items WHERE bill_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(deleteBillItemsSql);
            pstmt.setInt(1, Integer.parseInt(billId));
            pstmt.executeUpdate();
            
            // Delete bill
            String deleteBillSql = "DELETE FROM bills WHERE id = ?";
            pstmt = conn.prepareStatement(deleteBillSql);
            pstmt.setInt(1, Integer.parseInt(billId));
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                response.getWriter().write("{\"success\": true, \"message\": \"Bill deleted successfully\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Bill not found\"}");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"Database error occurred\"}");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
