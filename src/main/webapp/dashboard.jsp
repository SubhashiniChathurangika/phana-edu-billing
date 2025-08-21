<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Pahana Edu Billing System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
            color: #333;
        }

        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .navbar-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }

        .logo {
            display: flex;
            align-items: center;
            font-size: 1.5rem;
            font-weight: bold;
        }

        .logo i {
            margin-right: 10px;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            transition: background 0.3s;
        }

        .nav-links a:hover {
            background: rgba(255,255,255,0.2);
        }

        .nav-links a.active {
            background: rgba(255,255,255,0.3);
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .logout-btn {
            background: rgba(255,255,255,0.2);
            border: none;
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .logout-btn:hover {
            background: rgba(255,255,255,0.3);
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .page-header {
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .page-subtitle {
            color: #666;
            font-size: 1.1rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            border-left: 4px solid;
        }

        .stat-card.primary {
            border-left-color: #667eea;
        }

        .stat-card.success {
            border-left-color: #28a745;
        }

        .stat-card.warning {
            border-left-color: #ffc107;
        }

        .stat-card.danger {
            border-left-color: #dc3545;
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .stat-title {
            font-size: 0.9rem;
            font-weight: 600;
            color: #666;
            text-transform: uppercase;
        }

        .stat-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .stat-icon.primary {
            background: #667eea;
        }

        .stat-icon.success {
            background: #28a745;
        }

        .stat-icon.warning {
            background: #ffc107;
        }

        .stat-icon.danger {
            background: #dc3545;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .stat-change {
            font-size: 0.8rem;
            color: #666;
        }

        .content-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
        }

        .recent-bills {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .section-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
        }

        .view-all-btn {
            background: #667eea;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background 0.3s;
            text-decoration: none;
        }

        .view-all-btn:hover {
            background: #5a6fd8;
        }

        .bill-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid #eee;
        }

        .bill-item:last-child {
            border-bottom: none;
        }

        .bill-info h4 {
            font-size: 1rem;
            margin-bottom: 0.25rem;
        }

        .bill-info p {
            color: #666;
            font-size: 0.9rem;
        }

        .bill-amount {
            font-weight: 600;
            color: #333;
        }

        .bill-status {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .status-paid { background: #d4edda; color: #155724; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-cancelled { background: #f8d7da; color: #721c24; }

        .quick-actions {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .action-btn {
            display: flex;
            align-items: center;
            gap: 1rem;
            width: 100%;
            padding: 1rem;
            margin-bottom: 1rem;
            background: #f8f9fa;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            color: #333;
        }

        .action-btn:hover {
            background: #667eea;
            color: white;
            border-color: #667eea;
            transform: translateY(-2px);
        }

        .action-btn i {
            font-size: 1.2rem;
            width: 20px;
        }

        .action-text h4 {
            font-size: 1rem;
            margin-bottom: 0.25rem;
        }

        .action-text p {
            font-size: 0.8rem;
            color: #666;
        }

        .action-btn:hover .action-text p {
            color: rgba(255,255,255,0.8);
        }

        .no-bills {
            text-align: center;
            padding: 2rem;
            color: #666;
            font-style: italic;
        }

        @media (max-width: 768px) {
            .content-grid {
                grid-template-columns: 1fr;
            }
            
            .stats-grid {
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            }
            
            .navbar-content {
                flex-direction: column;
                gap: 1rem;
            }
            
            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="navbar-content">
            <div class="logo">
                <i class="fas fa-graduation-cap"></i>
                Pahana Edu Billing
            </div>
            <div class="nav-links">
                <a href="dashboard" class="active">Dashboard</a>
                <a href="bills">Bills</a>
                <a href="customers">Customers</a>
                <a href="items">Items</a>
                <a href="reports">Reports</a>
                <a href="logout">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="page-header">
            <h1 class="page-title">Dashboard</h1>
            <p class="page-subtitle">Welcome to Pahana Edu Billing Management System</p>
        </div>

        <div class="stats-grid">
            <div class="stat-card primary">
                <div class="stat-header">
                    <span class="stat-title">Total Bills</span>
                    <div class="stat-icon primary">
                        <i class="fas fa-receipt"></i>
                    </div>
                </div>
                <div class="stat-value">${stats.totalBills}</div>
                <div class="stat-change">+${stats.billsGrowth}% from last month</div>
            </div>

            <div class="stat-card success">
                <div class="stat-header">
                    <span class="stat-title">Total Revenue</span>
                    <div class="stat-icon success">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                </div>
                <div class="stat-value">Rs. <fmt:formatNumber value="${stats.totalRevenue}" pattern="#,##0"/></div>
                <div class="stat-change">+${stats.revenueGrowth}% from last month</div>
            </div>

            <div class="stat-card warning">
                <div class="stat-header">
                    <span class="stat-title">Pending Bills</span>
                    <div class="stat-icon warning">
                        <i class="fas fa-clock"></i>
                    </div>
                </div>
                <div class="stat-value">${stats.pendingBills}</div>
                <div class="stat-change">${stats.pendingChange} from last week</div>
            </div>

            <div class="stat-card danger">
                <div class="stat-header">
                    <span class="stat-title">Total Customers</span>
                    <div class="stat-icon danger">
                        <i class="fas fa-users"></i>
                    </div>
                </div>
                <div class="stat-value">${stats.totalCustomers}</div>
                <div class="stat-change">+${stats.customersGrowth} new this month</div>
            </div>
        </div>

        <div class="content-grid">
            <div class="recent-bills">
                <div class="section-header">
                    <h2 class="section-title">Recent Bills</h2>
                    <a href="bills" class="view-all-btn">View All</a>
                </div>
                
                <c:choose>
                    <c:when test="${not empty recentBills}">
                        <c:forEach var="bill" items="${recentBills}">
                            <div class="bill-item">
                                <div class="bill-info">
                                    <h4>Bill #${bill.id} - ${bill.customerName}</h4>
                                    <p><fmt:formatDate value="${bill.billDate}" pattern="MMM dd, yyyy"/> • ${bill.itemCount} items</p>
                                </div>
                                <div class="bill-amount">Rs. <fmt:formatNumber value="${bill.total}" pattern="#,##0"/></div>
                                <span class="bill-status status-${bill.status.toLowerCase()}">${bill.status}</span>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="no-bills">
                            <i class="fas fa-inbox"></i>
                            <br>No recent bills found
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="quick-actions">
                <h2 class="section-title">Quick Actions</h2>
                
                <a href="create-bill" class="action-btn">
                    <i class="fas fa-plus-circle"></i>
                    <div class="action-text">
                        <h4>Create New Bill</h4>
                        <p>Generate a new bill for customer</p>
                    </div>
                </a>

                <a href="customers" class="action-btn">
                    <i class="fas fa-user-plus"></i>
                    <div class="action-text">
                        <h4>Add Customer</h4>
                        <p>Register a new customer</p>
                    </div>
                </a>

                <a href="items" class="action-btn">
                    <i class="fas fa-box"></i>
                    <div class="action-text">
                        <h4>Manage Items</h4>
                        <p>Add or edit inventory items</p>
                    </div>
                </a>

                <a href="reports" class="action-btn">
                    <i class="fas fa-chart-bar"></i>
                    <div class="action-text">
                        <h4>View Reports</h4>
                        <p>Generate billing reports</p>
                    </div>
                </a>

                <a href="settings" class="action-btn">
                    <i class="fas fa-cog"></i>
                    <div class="action-text">
                        <h4>Settings</h4>
                        <p>System configuration</p>
                    </div>
                </a>
            </div>
        </div>
    </div>
</body>
</html>
