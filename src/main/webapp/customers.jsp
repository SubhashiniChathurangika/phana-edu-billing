<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customers - Pahana Edu Billing System</title>
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

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .page-header {
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: #333;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        .btn-danger {
            background: #dc3545;
            color: white;
        }

        .btn-danger:hover {
            background: #c82333;
        }

        .btn-sm {
            padding: 8px 16px;
            font-size: 12px;
        }

        .search-section {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .search-form {
            display: flex;
            gap: 1rem;
            align-items: end;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .form-group label {
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #333;
        }

        .form-control {
            padding: 12px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
        }

        .table-container {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            overflow-x: auto;
        }

        .customers-table {
            width: 100%;
            border-collapse: collapse;
        }

        .customers-table th {
            background: #f8f9fa;
            padding: 12px;
            text-align: left;
            font-weight: 600;
            color: #333;
            border-bottom: 2px solid #dee2e6;
        }

        .customers-table td {
            padding: 12px;
            border-bottom: 1px solid #dee2e6;
        }

        .customers-table tr:hover {
            background: #f8f9fa;
        }

        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-active {
            background: #d4edda;
            color: #155724;
        }

        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 1rem;
            border-left: 4px solid #28a745;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #666;
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #ccc;
        }

        @media (max-width: 768px) {
            .search-form {
                flex-direction: column;
            }
            
            .page-header {
                flex-direction: column;
                gap: 1rem;
                align-items: stretch;
            }
            
            .customers-table {
                font-size: 12px;
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
            <h1 class="page-title">Customers</h1>
            <a href="customers?action=add" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add Customer
            </a>
        </div>

        <c:if test="${not empty param.success}">
            <div class="success-message">
                <i class="fas fa-check-circle"></i>
                ${param.success}
            </div>
        </c:if>

        <div class="search-section">
            <form action="customers" method="get" class="search-form">
                <div class="form-group">
                    <label for="search">Search Customers</label>
                    <input type="text" id="search" name="search" class="form-control" 
                           placeholder="Search by name, email, or phone..." value="${search}">
                </div>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-search"></i> Search
                </button>
                <c:if test="${not empty search}">
                    <a href="customers" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Clear
                    </a>
                </c:if>
            </form>
        </div>

        <div class="table-container">
            <c:choose>
                <c:when test="${empty customers}">
                    <div class="empty-state">
                        <i class="fas fa-users"></i>
                        <h3>No customers found</h3>
                        <p>${not empty search ? 'Try adjusting your search criteria.' : 'Get started by adding your first customer.'}</p>
                        <c:if test="${empty search}">
                            <a href="customers?action=add" class="btn btn-primary">
                                <i class="fas fa-plus"></i> Add Customer
                            </a>
                        </c:if>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="customers-table">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Address</th>
                                <th>Created Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="customer" items="${customers}">
                                <tr>
                                    <td>
                                        <strong>${customer.name}</strong>
                                    </td>
                                    <td>${customer.email}</td>
                                    <td>${customer.telephone}</td>
                                    <td>${customer.address}</td>
                                    <td>
                                        <fmt:formatDate value="${customer.createdAt}" pattern="dd/MM/yyyy"/>
                                    </td>
                                    <td>
                                        <div style="display: flex; gap: 0.5rem;">
                                            <a href="customers?action=edit&id=${customer.id}" 
                                               class="btn btn-secondary btn-sm" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button onclick="deleteCustomer(${customer.id}, '${customer.name}')" 
                                                    class="btn btn-danger btn-sm" title="Delete">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        function deleteCustomer(customerId, customerName) {
            if (confirm('Are you sure you want to delete customer "' + customerName + '"? This action cannot be undone.')) {
                fetch('customers?action=delete&id=' + customerId, {
                    method: 'GET'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('Customer deleted successfully');
                        location.reload();
                    } else {
                        alert('Error: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while deleting the customer');
                });
            }
        }
    </script>
</body>
</html>
