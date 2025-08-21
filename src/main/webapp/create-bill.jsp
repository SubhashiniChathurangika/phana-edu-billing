<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Bill - Pahana Edu Billing System</title>
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
            max-width: 1000px;
            margin: 0 auto;
            padding: 2rem;
        }

        .page-header {
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .page-subtitle {
            color: #666;
            font-size: 1rem;
        }

        .form-container {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .form-section {
            margin-bottom: 2rem;
        }

        .section-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #f1f3f4;
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
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

        .items-section {
            margin-top: 2rem;
        }

        .item-row {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr auto;
            gap: 1rem;
            align-items: end;
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 8px;
            margin-bottom: 1rem;
        }

        .item-row:last-child {
            margin-bottom: 0;
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

        .form-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #e1e5e9;
        }

        .error-message {
            background: #fee;
            color: #c33;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 1rem;
            border-left: 4px solid #c33;
        }

        .total-section {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin-top: 2rem;
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

        @media (max-width: 768px) {
            .item-row {
                grid-template-columns: 1fr;
                gap: 0.5rem;
            }
            
            .form-actions {
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
            <h1 class="page-title">Create New Bill</h1>
            <p class="page-subtitle">Generate a new bill for your customer</p>
        </div>

        <div class="form-container">
            <c:if test="${not empty errorMessage}">
                <div class="error-message">
                    <i class="fas fa-exclamation-triangle"></i>
                    ${errorMessage}
                </div>
            </c:if>

            <form action="create-bill" method="post" id="createBillForm">
                <div class="form-section">
                    <h2 class="section-title">Customer Information</h2>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="customerId">Select Customer *</label>
                            <select id="customerId" name="customerId" class="form-control" required>
                                <option value="">Choose a customer...</option>
                                <c:forEach var="customer" items="${customers}">
                                    <option value="${customer.id}">${customer.name} - ${customer.telephone}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <h2 class="section-title">Bill Items</h2>
                    <div id="itemsContainer">
                        <div class="item-row">
                            <div class="form-group">
                                <label>Item *</label>
                                <select name="itemId" class="form-control item-select" required>
                                    <option value="">Select item...</option>
                                    <c:forEach var="item" items="${items}">
                                        <option value="${item.id}" data-price="${item.price}">${item.name} - Rs. ${item.price}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Quantity *</label>
                                <input type="number" name="quantity" class="form-control quantity-input" min="1" value="1" required>
                            </div>
                            <div class="form-group">
                                <label>Unit Price</label>
                                <input type="number" class="form-control unit-price" readonly>
                            </div>
                            <div class="form-group">
                                <label>Line Total</label>
                                <input type="number" class="form-control line-total" readonly>
                            </div>
                            <div class="form-group">
                                <button type="button" class="btn btn-danger btn-sm remove-item">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    <button type="button" class="btn btn-secondary" id="addItemBtn">
                        <i class="fas fa-plus"></i> Add Item
                    </button>
                </div>

                <div class="total-section">
                    <div class="total-row">
                        <span>Subtotal:</span>
                        <span id="subtotal">Rs. 0.00</span>
                    </div>
                    <div class="total-row">
                        <span>Total:</span>
                        <span id="total">Rs. 0.00</span>
                    </div>
                </div>

                <div class="form-actions">
                    <a href="bills" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Cancel
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Create Bill
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Add item functionality
        document.getElementById('addItemBtn').addEventListener('click', function() {
            const container = document.getElementById('itemsContainer');
            const itemRow = container.querySelector('.item-row').cloneNode(true);
            
            // Clear values
            itemRow.querySelector('.item-select').value = '';
            itemRow.querySelector('.quantity-input').value = '1';
            itemRow.querySelector('.unit-price').value = '';
            itemRow.querySelector('.line-total').value = '';
            
            container.appendChild(itemRow);
            attachEventListeners(itemRow);
        });

        // Remove item functionality
        document.addEventListener('click', function(e) {
            if (e.target.classList.contains('remove-item')) {
                const itemRows = document.querySelectorAll('.item-row');
                if (itemRows.length > 1) {
                    e.target.closest('.item-row').remove();
                    calculateTotal();
                }
            }
        });

        // Calculate line totals and update totals
        function attachEventListeners(itemRow) {
            const itemSelect = itemRow.querySelector('.item-select');
            const quantityInput = itemRow.querySelector('.quantity-input');
            const unitPriceInput = itemRow.querySelector('.unit-price');
            const lineTotalInput = itemRow.querySelector('.line-total');

            itemSelect.addEventListener('change', function() {
                const selectedOption = this.options[this.selectedIndex];
                const price = selectedOption.getAttribute('data-price') || 0;
                unitPriceInput.value = price;
                calculateLineTotal(itemRow);
            });

            quantityInput.addEventListener('input', function() {
                calculateLineTotal(itemRow);
            });
        }

        function calculateLineTotal(itemRow) {
            const quantity = parseFloat(itemRow.querySelector('.quantity-input').value) || 0;
            const unitPrice = parseFloat(itemRow.querySelector('.unit-price').value) || 0;
            const lineTotal = quantity * unitPrice;
            itemRow.querySelector('.line-total').value = lineTotal.toFixed(2);
            calculateTotal();
        }

        function calculateTotal() {
            let total = 0;
            document.querySelectorAll('.line-total').forEach(input => {
                total += parseFloat(input.value) || 0;
            });
            
            document.getElementById('subtotal').textContent = 'Rs. ' + total.toFixed(2);
            document.getElementById('total').textContent = 'Rs. ' + total.toFixed(2);
        }

        // Attach event listeners to initial item row
        document.querySelectorAll('.item-row').forEach(attachEventListeners);

        // Form validation
        document.getElementById('createBillForm').addEventListener('submit', function(e) {
            const customerId = document.getElementById('customerId').value;
            const itemRows = document.querySelectorAll('.item-row');
            let hasValidItems = false;

            itemRows.forEach(row => {
                const itemId = row.querySelector('.item-select').value;
                const quantity = row.querySelector('.quantity-input').value;
                if (itemId && quantity > 0) {
                    hasValidItems = true;
                }
            });

            if (!customerId) {
                e.preventDefault();
                alert('Please select a customer');
                return;
            }

            if (!hasValidItems) {
                e.preventDefault();
                alert('Please add at least one item to the bill');
                return;
            }
        });
    </script>
</body>
</html>
