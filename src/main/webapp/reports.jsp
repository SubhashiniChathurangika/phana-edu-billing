<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports - Pahana Edu Billing System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 1400px;
            margin: 0 auto;
        }
        .header {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            text-align: center;
        }
        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .header p {
            color: #666;
            font-size: 1.1em;
        }
        .filters {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .filter-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            align-items: end;
        }
        .filter-group {
            display: flex;
            flex-direction: column;
        }
        .filter-group label {
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }
        .filter-group input, .filter-group select {
            padding: 12px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s ease;
        }
        .filter-group input:focus, .filter-group select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .stat-icon {
            font-size: 2.5em;
            margin-bottom: 15px;
        }
        .stat-value {
            font-size: 2em;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .stat-label {
            color: #666;
            font-size: 1.1em;
        }
        .revenue { color: #28a745; }
        .orders { color: #007bff; }
        .customers { color: #ffc107; }
        .items { color: #dc3545; }
        .charts-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }
        .chart-container {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .chart-title {
            font-size: 1.3em;
            font-weight: 600;
            margin-bottom: 20px;
            color: #333;
            text-align: center;
        }
        .reports-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        .report-section {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .report-title {
            font-size: 1.3em;
            font-weight: 600;
            margin-bottom: 20px;
            color: #333;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .report-list {
            list-style: none;
        }
        .report-item {
            padding: 15px;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .report-item:last-child {
            border-bottom: none;
        }
        .report-item:hover {
            background: #f8f9fa;
            border-radius: 8px;
        }
        .report-name {
            font-weight: 500;
            color: #333;
        }
        .report-value {
            font-weight: bold;
            color: #667eea;
        }
        .export-buttons {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-top: 20px;
        }
        .btn-export {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-size: 0.9em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-pdf {
            background: #dc3545;
            color: white;
        }
        .btn-excel {
            background: #28a745;
            color: white;
        }
        .btn-pdf:hover, .btn-excel:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        @media (max-width: 768px) {
            .charts-grid, .reports-grid {
                grid-template-columns: 1fr;
            }
            .filter-row {
                grid-template-columns: 1fr;
            }
            .export-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-chart-line"></i> Reports & Analytics</h1>
            <p>Comprehensive insights into your billing system performance</p>
        </div>
        
        <div class="filters">
            <form action="reports" method="get">
                <div class="filter-row">
                    <div class="filter-group">
                        <label for="reportType">Report Type</label>
                        <select id="reportType" name="reportType">
                            <option value="sales" ${param.reportType == 'sales' ? 'selected' : ''}>Sales Report</option>
                            <option value="inventory" ${param.reportType == 'inventory' ? 'selected' : ''}>Inventory Report</option>
                            <option value="customers" ${param.reportType == 'customers' ? 'selected' : ''}>Customer Report</option>
                            <option value="revenue" ${param.reportType == 'revenue' ? 'selected' : ''}>Revenue Report</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label for="startDate">Start Date</label>
                        <input type="date" id="startDate" name="startDate" 
                               value="${param.startDate}">
                    </div>
                    
                    <div class="filter-group">
                        <label for="endDate">End Date</label>
                        <input type="date" id="endDate" name="endDate" 
                               value="${param.endDate}">
                    </div>
                    
                    <div class="filter-group">
                        <label for="category">Category</label>
                        <select id="category" name="category">
                            <option value="">All Categories</option>
                            <option value="BOOKS" ${param.category == 'BOOKS' ? 'selected' : ''}>Books</option>
                            <option value="STATIONERY" ${param.category == 'STATIONERY' ? 'selected' : ''}>Stationery</option>
                            <option value="ELECTRONICS" ${param.category == 'ELECTRONICS' ? 'selected' : ''}>Electronics</option>
                            <option value="UNIFORMS" ${param.category == 'UNIFORMS' ? 'selected' : ''}>Uniforms</option>
                            <option value="SPORTS" ${param.category == 'SPORTS' ? 'selected' : ''}>Sports Equipment</option>
                            <option value="OTHER" ${param.category == 'OTHER' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-search"></i> Generate Report
                        </button>
                    </div>
                </div>
            </form>
        </div>
        
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon revenue">
                    <i class="fas fa-dollar-sign"></i>
                </div>
                <div class="stat-value revenue">LKR ${totalRevenue}</div>
                <div class="stat-label">Total Revenue</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon orders">
                    <i class="fas fa-receipt"></i>
                </div>
                <div class="stat-value orders">${totalBills}</div>
                <div class="stat-label">Total Bills</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon customers">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-value customers">${totalCustomers}</div>
                <div class="stat-label">Total Customers</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon items">
                    <i class="fas fa-box"></i>
                </div>
                <div class="stat-value items">${totalItems}</div>
                <div class="stat-label">Total Items</div>
            </div>
        </div>
        
        <div class="charts-grid">
            <div class="chart-container">
                <div class="chart-title">Revenue Trend</div>
                <canvas id="revenueChart" width="400" height="200"></canvas>
            </div>
            
            <div class="chart-container">
                <div class="chart-title">Sales by Category</div>
                <canvas id="categoryChart" width="400" height="200"></canvas>
            </div>
        </div>
        
        <div class="reports-grid">
            <div class="report-section">
                <div class="report-title">
                    <i class="fas fa-chart-bar"></i> Top Selling Items
                </div>
                <ul class="report-list">
                    <c:forEach var="item" items="${topItems}">
                        <li class="report-item">
                            <span class="report-name">${item.name}</span>
                            <span class="report-value">${item.quantity} sold</span>
                        </li>
                    </c:forEach>
                </ul>
                <div class="export-buttons">
                    <a href="reports?action=export&type=topItems&format=pdf" class="btn-export btn-pdf">
                        <i class="fas fa-file-pdf"></i> Export PDF
                    </a>
                    <a href="reports?action=export&type=topItems&format=excel" class="btn-export btn-excel">
                        <i class="fas fa-file-excel"></i> Export Excel
                    </a>
                </div>
            </div>
            
            <div class="report-section">
                <div class="report-title">
                    <i class="fas fa-user-friends"></i> Top Customers
                </div>
                <ul class="report-list">
                    <c:forEach var="customer" items="${topCustomers}">
                        <li class="report-item">
                            <span class="report-name">${customer.name}</span>
                            <span class="report-value">LKR ${customer.totalSpent}</span>
                        </li>
                    </c:forEach>
                </ul>
                <div class="export-buttons">
                    <a href="reports?action=export&type=topCustomers&format=pdf" class="btn-export btn-pdf">
                        <i class="fas fa-file-pdf"></i> Export PDF
                    </a>
                    <a href="reports?action=export&type=topCustomers&format=excel" class="btn-export btn-excel">
                        <i class="fas fa-file-excel"></i> Export Excel
                    </a>
                </div>
            </div>
        </div>
        
        <div class="reports-grid">
            <div class="report-section">
                <div class="report-title">
                    <i class="fas fa-exclamation-triangle"></i> Low Stock Alerts
                </div>
                <ul class="report-list">
                    <c:forEach var="item" items="${lowStockItems}">
                        <li class="report-item">
                            <span class="report-name">${item.name}</span>
                            <span class="report-value">${item.stockQuantity} left</span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            
            <div class="report-section">
                <div class="report-title">
                    <i class="fas fa-calendar-alt"></i> Recent Activity
                </div>
                <ul class="report-list">
                    <c:forEach var="activity" items="${recentActivity}">
                        <li class="report-item">
                            <span class="report-name">${activity.description}</span>
                            <span class="report-value">${activity.date}</span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
    
    <script>
        // Revenue Trend Chart
        const revenueCtx = document.getElementById('revenueChart').getContext('2d');
        new Chart(revenueCtx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [{
                    label: 'Revenue (LKR)',
                    data: [12000, 19000, 15000, 25000, 22000, 30000],
                    borderColor: '#667eea',
                    backgroundColor: 'rgba(102, 126, 234, 0.1)',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return 'LKR ' + value.toLocaleString();
                            }
                        }
                    }
                }
            }
        });
        
        // Category Sales Chart
        const categoryCtx = document.getElementById('categoryChart').getContext('2d');
        new Chart(categoryCtx, {
            type: 'doughnut',
            data: {
                labels: ['Books', 'Stationery', 'Electronics', 'Uniforms', 'Sports', 'Other'],
                datasets: [{
                    data: [30, 25, 20, 15, 8, 2],
                    backgroundColor: [
                        '#667eea',
                        '#764ba2',
                        '#f093fb',
                        '#f5576c',
                        '#4facfe',
                        '#00f2fe'
                    ],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
        
        // Set default dates
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date();
            const lastMonth = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
            
            if (!document.getElementById('startDate').value) {
                document.getElementById('startDate').value = lastMonth.toISOString().split('T')[0];
            }
            if (!document.getElementById('endDate').value) {
                document.getElementById('endDate').value = today.toISOString().split('T')[0];
            }
        });
    </script>
</body>
</html>
