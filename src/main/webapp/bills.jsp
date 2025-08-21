<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bills - Pahana Edu Billing System</title>
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

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: #333;
        }

        .create-btn {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: transform 0.3s, box-shadow 0.3s;
            text-decoration: none;
        }

        .create-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(102, 126, 234, 0.3);
        }

        .filters {
            background: white;
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
        }

        .filter-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            align-items: end;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
        }

        .filter-group label {
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #333;
        }

        .filter-input {
            padding: 10px 12px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .filter-input:focus {
            outline: none;
            border-color: #667eea;
        }

        .filter-btn {
            background: #667eea;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: background 0.3s;
        }

        .filter-btn:hover {
            background: #5a6fd8;
        }

        .bills-table {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            overflow: hidden;
        }

        .table-header {
            background: #f8f9fa;
            padding: 1rem 1.5rem;
            border-bottom: 1px solid #e1e5e9;
        }

        .table-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th {
            background: #f8f9fa;
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            color: #333;
            border-bottom: 1px solid #e1e5e9;
        }

        .table td {
            padding: 1rem;
            border-bottom: 1px solid #f1f3f4;
        }

        .table tr:hover {
            background: #f8f9fa;
        }

        .bill-id {
            font-weight: 600;
            color: #667eea;
        }

        .customer-name {
            font-weight: 500;
        }

        .bill-amount {
            font-weight: 600;
            color: #333;
        }

        .bill-date {
            color: #666;
            font-size: 0.9rem;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-paid {
            background: #d4edda;
            color: #155724;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.8rem;
            font-weight: 500;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .btn-view {
            background: #667eea;
            color: white;
        }

        .btn-view:hover {
            background: #5a6fd8;
        }

        .btn-edit {
            background: #ffc107;
            color: #333;
        }

        .btn-edit:hover {
            background: #e0a800;
        }

        .btn-delete {
            background: #dc3545;
            color: white;
        }

        .btn-delete:hover {
            background: #c82333;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
            margin-top: 2rem;
        }

        .page-btn {
            padding: 8px 12px;
            border: 1px solid #e1e5e9;
            background: white;
            color: #333;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .page-btn:hover {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }

        .page-btn.active {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }

        .page-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .no-data {
            text-align: center;
            padding: 3rem;
            color: #666;
            font-style: italic;
        }

        @media (max-width: 768px) {
            .navbar-content {
                flex-direction: column;
                gap: 1rem;
            }
            
            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .page-header {
                flex-direction: column;
                gap: 1rem;
                align-items: stretch;
            }
            
            .filter-row {
                grid-template-columns: 1fr;
            }
            
            .table {
                font-size: 0.9rem;
            }
            
            .table th,
            .table td {
                padding: 0.75rem 0.5rem;
            }
            
            .action-buttons {
                flex-direction: column;
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
                <a href="dashboard">Dashboard</a>
                <a href="bills" class="active">Bills</a>
                <a href="customers">Customers</a>
                <a href="items">Items</a>
                <a href="reports">Reports</a>
                <a href="logout">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="page-header">
            <h1 class="page-title">Bills Management</h1>
            <a href="create-bill" class="create-btn">
                <i class="fas fa-plus"></i>
                Create New Bill
            </a>
        </div>

        <form method="GET" action="bills">
            <div class="filters">
                <div class="filter-row">
                    <div class="filter-group">
                        <label for="search">Search</label>
                        <input type="text" id="search" name="search" class="filter-input" 
                               placeholder="Search by customer name or bill ID" 
                               value="${search != null ? search : ''}">
                    </div>
                    <div class="filter-group">
                        <label for="status">Status</label>
                        <select id="status" name="status" class="filter-input">
                            <option value="">All Status</option>
                            <option value="PAID" ${status == 'PAID' ? 'selected' : ''}>Paid</option>
                            <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>Pending</option>
                            <option value="CANCELLED" ${status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label for="dateFrom">Date From</label>
                        <input type="date" id="dateFrom" name="dateFrom" class="filter-input" 
                               value="${dateFrom != null ? dateFrom : ''}">
                    </div>
                    <div class="filter-group">
                        <label for="dateTo">Date To</label>
                        <input type="date" id="dateTo" name="dateTo" class="filter-input" 
                               value="${dateTo != null ? dateTo : ''}">
                    </div>
                    <div class="filter-group">
                        <button type="submit" class="filter-btn">
                            <i class="fas fa-search"></i> Filter
                        </button>
                    </div>
                </div>
            </div>
        </form>

        <div class="bills-table">
            <div class="table-header">
                <h2 class="table-title">All Bills</h2>
            </div>
            <table class="table">
                <thead>
                    <tr>
                        <th>Bill ID</th>
                        <th>Customer</th>
                        <th>Date</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty bills}">
                            <c:forEach var="bill" items="${bills}">
                                <tr>
                                    <td class="bill-id">#${bill.id}</td>
                                    <td class="customer-name">${bill.customerName}</td>
                                    <td class="bill-date">
                                        <fmt:formatDate value="${bill.billDate}" pattern="MMM dd, yyyy"/>
                                    </td>
                                    <td class="bill-amount">Rs. <fmt:formatNumber value="${bill.total}" pattern="#,##0.00"/></td>
                                    <td>
                                        <span class="status-badge status-${bill.status.toLowerCase()}">${bill.status}</span>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="view-bill?id=${bill.id}" class="btn btn-view">
                                                <i class="fas fa-eye"></i> View
                                            </a>
                                            <a href="edit-bill?id=${bill.id}" class="btn btn-edit">
                                                <i class="fas fa-edit"></i> Edit
                                            </a>
                                            <button class="btn btn-delete" onclick="deleteBill(${bill.id})">
                                                <i class="fas fa-trash"></i> Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" class="no-data">
                                    <i class="fas fa-inbox"></i>
                                    <br>No bills found
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <div class="pagination">
            <button class="page-btn" disabled>
                <i class="fas fa-chevron-left"></i>
            </button>
            <button class="page-btn active">1</button>
            <button class="page-btn">2</button>
            <button class="page-btn">3</button>
            <button class="page-btn">
                <i class="fas fa-chevron-right"></i>
            </button>
        </div>
    </div>

    <script>
        // Delete confirmation
        function deleteBill(billId) {
            if (confirm('Are you sure you want to delete this bill?')) {
                // Create a form to submit the delete request
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'bills';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = billId;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Auto-submit form when filters change
        document.getElementById('search').addEventListener('input', function() {
            if (this.value.length === 0 || this.value.length > 2) {
                this.form.submit();
            }
        });

        document.getElementById('status').addEventListener('change', function() {
            this.form.submit();
        });

        document.getElementById('dateFrom').addEventListener('change', function() {
            this.form.submit();
        });

        document.getElementById('dateTo').addEventListener('change', function() {
            this.form.submit();
        });
    </script>
</body>
</html>
