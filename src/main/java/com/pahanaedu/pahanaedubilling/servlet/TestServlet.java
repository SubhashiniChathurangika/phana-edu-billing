package com.pahanaedu.pahanaedubilling.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pahanaedu.pahanaedubilling.util.DBConnection;

@WebServlet("/test")
public class TestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        
        try (Connection conn = DBConnection.getConnection()) {
            
            // Test 1: Check if bills table exists and has data
            String sql1 = "SELECT COUNT(*) as count FROM bills";
            PreparedStatement pstmt1 = conn.prepareStatement(sql1);
            ResultSet rs1 = pstmt1.executeQuery();
            
            int billCount = 0;
            if (rs1.next()) {
                billCount = rs1.getInt("count");
            }
            
            // Test 2: Get first bill details
            String sql2 = "SELECT b.id, b.total, b.bill_date, b.status, c.name as customer_name " +
                         "FROM bills b " +
                         "JOIN customers c ON b.customer_id = c.id " +
                         "LIMIT 1";
            PreparedStatement pstmt2 = conn.prepareStatement(sql2);
            ResultSet rs2 = pstmt2.executeQuery();
            
            StringBuilder result = new StringBuilder();
            result.append("<html><head><title>Database Test</title></head><body>");
            result.append("<h1>Database Connection Test</h1>");
            result.append("<p><strong>Database Connection:</strong> SUCCESS</p>");
            result.append("<p><strong>Total Bills in Database:</strong> ").append(billCount).append("</p>");
            
            if (rs2.next()) {
                result.append("<h2>First Bill Details:</h2>");
                result.append("<p><strong>Bill ID:</strong> ").append(rs2.getInt("id")).append("</p>");
                result.append("<p><strong>Customer:</strong> ").append(rs2.getString("customer_name")).append("</p>");
                result.append("<p><strong>Total:</strong> ").append(rs2.getDouble("total")).append("</p>");
                result.append("<p><strong>Status:</strong> ").append(rs2.getString("status")).append("</p>");
                result.append("<p><strong>Date:</strong> ").append(rs2.getTimestamp("bill_date")).append("</p>");
            } else {
                result.append("<p><strong>No bills found in database</strong></p>");
            }
            
            // Test 3: Check bill_items table
            String sql3 = "SELECT COUNT(*) as count FROM bill_items";
            PreparedStatement pstmt3 = conn.prepareStatement(sql3);
            ResultSet rs3 = pstmt3.executeQuery();
            
            int itemCount = 0;
            if (rs3.next()) {
                itemCount = rs3.getInt("count");
            }
            
            result.append("<p><strong>Total Bill Items in Database:</strong> ").append(itemCount).append("</p>");
            
            result.append("</body></html>");
            
            response.getWriter().write(result.toString());
            
        } catch (SQLException e) {
            response.getWriter().write("<html><body><h1>Database Error</h1><p>" + e.getMessage() + "</p></body></html>");
            e.printStackTrace();
        }
    }
}
