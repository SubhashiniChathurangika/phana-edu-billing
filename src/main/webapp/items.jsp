<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Items - Pahana Edu Billing System</title>
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
            display: grid;
            grid-template-columns: 2fr 1fr 1fr auto;
            gap: 1rem;
            align-items: end;
        }

        .form-group {
            display: flex;
            flex-direction: column;
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

        .items-table {
            width: 100%;
            border-collapse: collapse;
        }

        .items-table th {
            background: #f8f9fa;
            padding: 12px;
            text-align: left;
            font-weight: 600;
            color: #333;
            border-bottom: 2px solid #dee2e6;
        }

        .items-table td {
            padding: 12px;
            border-bottom: 1px solid #dee2e6;
        }

        .items-table tr:hover {
            background: #f8f9fa;
        }

        .text-right {
            text-align: right;
        }

        .text-center {
            text-align: center;
        }

        .stock-status {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .stock-high {
            background: #d4edda;
            color: #155724;
        }

        .stock-medium {
            background: #fff3cd;
            color: #856404;
        }

        .stock-low {
            background: #f8d7da;
            color: #721c24;
        }

        .stock-out {
            background: #f8d7da;
            color: #721c24;
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
                grid-template-columns: 1fr;
            }
            
            .page-header {
                flex-direction: column;
                gap: 1rem;
                align-items: stretch;
            }
            
            .items-table {
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
            <h1 class="page-title">Inventory Items</h1>
            <a href="items?action=add" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add Item
            </a>
        </div>

        <c:if test="${not empty param.success}">
            <div class="success-message">
                <i class="fas fa-check-circle"></i>
                ${param.success}
            </div>
        </c:if>

        <div class="search-section">
            <form action="items" method="get" class="search-form">
                <div class="form-group">
                    <label for="search">Search Items</label>
                    <input type="text" id="search" name="search" class="form-control" 
                           placeholder="Search by name or description..." value="${search}">
                </div>
                <div class="form-group">
                    <label for="category">Category</label>
                    <select id="category" name="category" class="form-control">
                        <option value="">All Categories</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat}" ${cat == selectedCategory ? 'selected' : ''}>${cat}</option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-search"></i> Search
                </button>
                <c:if test="${not empty search || not empty selectedCategory}">
                    <a href="items" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Clear
                    </a>
                </c:if>
            </form>
        </div>

        <div class="table-container">
            <c:choose>
                <c:when test="${empty items}">
                    <div class="empty-state">
                        <i class="fas fa-box"></i>
                        <h3>No items found</h3>
                        <p>${not empty search || not empty selectedCategory ? 'Try adjusting your search criteria.' : 'Get started by adding your first inventory item.'}</p>
                        <c:if test="${empty search && empty selectedCategory}">
                            <a href="items?action=add" class="btn btn-primary">
                                <i class="fas fa-plus"></i> Add Item
                            </a>
                        </c:if>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="items-table">
                        <thead>
                            <tr>
                                <th>Item Name</th>
                                <th>Category</th>
                                <th class="text-right">Price</th>
                                <th>Description</th>
                                <th>Created Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${items}">
                                <tr>
                                    <td>
                                        <strong>${item.name}</strong>
                                    </td>
                                    <td>${item.category}</td>
                                    <td class="text-right">Rs. <fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></td>
                                    <td>${item.description}</td>
                                    <td>
                                        <fmt:formatDate value="${item.createdAt}" pattern="dd/MM/yyyy"/>
                                    </td>
                                    <td>
                                        <div style="display: flex; gap: 0.5rem;">
                                            <a href="items?action=edit&id=${item.id}" 
                                               class="btn btn-secondary btn-sm" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button onclick="deleteItem(${item.id}, '${item.name}')" 
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
        function deleteItem(itemId, itemName) {
            if (confirm('Are you sure you want to delete item "' + itemName + '"? This action cannot be undone.')) {
                fetch('items?action=delete&id=' + itemId, {
                    method: 'GET'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('Item deleted successfully');
                        location.reload();
                    } else {
                        alert('Error: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while deleting the item');
                });
            }
        }
    </script>
</body>
</html>
