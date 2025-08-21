<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Bill - Pahana Edu Billing System</title>
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
            max-width: 800px;
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

        .btn-success {
            background: #28a745;
            color: white;
        }

        .btn-success:hover {
            background: #218838;
        }

        .invoice-container {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .invoice-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f1f3f4;
        }

        .company-info {
            flex: 1;
        }

        .company-name {
            font-size: 1.5rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .company-details {
            color: #666;
            line-height: 1.6;
        }

        .invoice-details {
            text-align: right;
        }

        .invoice-number {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .invoice-date {
            color: #666;
            margin-bottom: 0.5rem;
        }

        .invoice-status {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-paid {
            background: #d4edda;
            color: #155724;
        }

        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }

        .customer-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
            padding: 1.5rem;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .customer-info h3, .bill-info h3 {
            font-size: 1.1rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 1rem;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }

        .info-label {
            font-weight: 600;
            color: #666;
        }

        .info-value {
            color: #333;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
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

        .total-section {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
        }

        .total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.5rem;
        }

        .total-row:last-child {
            margin-bottom: 0;
            font-weight: 700;
            font-size: 1.2rem;
            color: #333;
            border-top: 1px solid #dee2e6;
            padding-top: 1rem;
        }

        .actions-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 2rem;
            border-top: 1px solid #e1e5e9;
        }

        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 1rem;
            border-left: 4px solid #dc3545;
        }

        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 1rem;
            border-left: 4px solid #28a745;
        }

        @media (max-width: 768px) {
            .customer-section {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            
            .invoice-header {
                flex-direction: column;
                gap: 1rem;
            }
            
            .invoice-details {
                text-align: left;
            }
            
            .actions-section {
                flex-direction: column;
                gap: 1rem;
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
            <h1 class="page-title">Edit Bill #${bill.id}</h1>
            <div>
                <a href="view-bill?id=${bill.id}" class="btn btn-secondary">
                    <i class="fas fa-eye"></i> View Bill
                </a>
            </div>
        </div>

        <div class="invoice-container">
            <c:if test="${not empty errorMessage}">
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i>
                    ${errorMessage}
                </div>
            </c:if>

            <form action="edit-bill" method="post">
                <input type="hidden" name="billId" value="${bill.id}">
                
                <div class="invoice-header">
                    <div class="company-info">
                        <div class="company-name">Pahana Edu Billing System</div>
                        <div class="company-details">
                            123 Education Street<br>
                            Colombo, Sri Lanka<br>
                            Phone: +94 11 234 5678<br>
                            Email: info@pahanaedu.com
                        </div>
                    </div>
                    <div class="invoice-details">
                        <div class="invoice-number">Bill #${bill.id}</div>
                        <div class="invoice-date">
                            <fmt:formatDate value="${bill.billDate}" pattern="MMMM dd, yyyy"/>
                        </div>
                        <div class="form-group">
                            <label for="status">Status</label>
                            <select id="status" name="status" class="form-control">
                                <option value="PENDING" ${bill.status == 'PENDING' ? 'selected' : ''}>Pending</option>
                                <option value="PAID" ${bill.status == 'PAID' ? 'selected' : ''}>Paid</option>
                                <option value="CANCELLED" ${bill.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="customer-section">
                    <div class="customer-info">
                        <h3>Customer Information</h3>
                        <div class="info-row">
                            <span class="info-label">Name:</span>
                            <span class="info-value">${bill.customerName}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Address:</span>
                            <span class="info-value">${bill.customerAddress}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Phone:</span>
                            <span class="info-value">${bill.customerTelephone}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Email:</span>
                            <span class="info-value">${bill.customerEmail}</span>
                        </div>
                    </div>
                    <div class="bill-info">
                        <h3>Bill Information</h3>
                        <div class="info-row">
                            <span class="info-label">Bill Date:</span>
                            <span class="info-value">
                                <fmt:formatDate value="${bill.billDate}" pattern="dd/MM/yyyy"/>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Total Amount:</span>
                            <span class="info-value">Rs. <fmt:formatNumber value="${bill.total}" pattern="#,##0.00"/></span>
                        </div>
                    </div>
                </div>

                <table class="items-table">
                    <thead>
                        <tr>
                            <th>Item</th>
                            <th class="text-center">Category</th>
                            <th class="text-center">Quantity</th>
                            <th class="text-right">Unit Price</th>
                            <th class="text-right">Line Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${billItems}">
                            <tr>
                                <td>${item.itemName}</td>
                                <td class="text-center">${item.category}</td>
                                <td class="text-center">${item.quantity}</td>
                                <td class="text-right">Rs. <fmt:formatNumber value="${item.unitPrice}" pattern="#,##0.00"/></td>
                                <td class="text-right">Rs. <fmt:formatNumber value="${item.lineTotal}" pattern="#,##0.00"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div class="total-section">
                    <div class="total-row">
                        <span>Subtotal:</span>
                        <span>Rs. <fmt:formatNumber value="${bill.total}" pattern="#,##0.00"/></span>
                    </div>
                    <div class="total-row">
                        <span>Total:</span>
                        <span>Rs. <fmt:formatNumber value="${bill.total}" pattern="#,##0.00"/></span>
                    </div>
                </div>

                <div class="actions-section">
                    <a href="bills" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back to Bills
                    </a>
                    <div>
                        <a href="view-bill?id=${bill.id}" class="btn btn-secondary">
                            <i class="fas fa-eye"></i> View Bill
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Update Bill
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
