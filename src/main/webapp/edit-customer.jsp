<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Customer - Pahana Edu Billing System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        .header p {
            opacity: 0.9;
            font-size: 1.1em;
        }
        .form-container {
            padding: 40px;
        }
        .form-group {
            margin-bottom: 25px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
            font-size: 1.1em;
        }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 15px;
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            font-size: 1em;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }
        .form-group input:focus, .form-group textarea:focus, .form-group select:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 10px;
            font-size: 1.1em;
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
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        .btn-danger:hover {
            background: #c82333;
            transform: translateY(-2px);
        }
        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
        }
        .alert {
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .required {
            color: #dc3545;
        }
        .customer-info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            border-left: 4px solid #667eea;
        }
        .customer-info h3 {
            color: #667eea;
            margin-bottom: 15px;
        }
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        .info-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .info-item i {
            color: #667eea;
            width: 20px;
        }
        @media (max-width: 768px) {
            .form-row, .info-grid {
                grid-template-columns: 1fr;
            }
            .form-actions {
                flex-direction: column;
            }
            .container {
                margin: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-user-edit"></i> Edit Customer</h1>
            <p>Update customer information in the system</p>
        </div>
        
        <div class="form-container">
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${successMessage}
                </div>
            </c:if>
            
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                </div>
            </c:if>
            
            <c:if test="${not empty customer}">
                <div class="customer-info">
                    <h3><i class="fas fa-info-circle"></i> Customer Information</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <i class="fas fa-user"></i>
                            <span><strong>ID:</strong> ${customer.id}</span>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-calendar"></i>
                            <span><strong>Created:</strong> ${customer.createdAt}</span>
                        </div>
                    </div>
                </div>
            </c:if>
            
            <form action="customers" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${customer.id}">
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="name">Full Name <span class="required">*</span></label>
                        <input type="text" id="name" name="name" required 
                               placeholder="Enter customer's full name"
                               value="${customer.name}">
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email Address <span class="required">*</span></label>
                        <input type="email" id="email" name="email" required 
                               placeholder="Enter email address"
                               value="${customer.email}">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="phone">Phone Number <span class="required">*</span></label>
                        <input type="tel" id="phone" name="phone" required 
                               placeholder="Enter phone number"
                               value="${customer.phone}">
                    </div>
                    
                    <div class="form-group">
                        <label for="customerType">Customer Type</label>
                        <select id="customerType" name="customerType">
                            <option value="INDIVIDUAL" ${customer.customerType == 'INDIVIDUAL' ? 'selected' : ''}>Individual</option>
                            <option value="BUSINESS" ${customer.customerType == 'BUSINESS' ? 'selected' : ''}>Business</option>
                            <option value="STUDENT" ${customer.customerType == 'STUDENT' ? 'selected' : ''}>Student</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="address">Address</label>
                    <textarea id="address" name="address" rows="3" 
                              placeholder="Enter complete address">${customer.address}</textarea>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="city">City</label>
                        <input type="text" id="city" name="city" 
                               placeholder="Enter city"
                               value="${customer.city}">
                    </div>
                    
                    <div class="form-group">
                        <label for="postalCode">Postal Code</label>
                        <input type="text" id="postalCode" name="postalCode" 
                               placeholder="Enter postal code"
                               value="${customer.postalCode}">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="notes">Notes</label>
                    <textarea id="notes" name="notes" rows="3" 
                              placeholder="Any additional notes about the customer">${customer.notes}</textarea>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Update Customer
                    </button>
                                    <a href="customers" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Customers
                </a>
                    <button type="button" class="btn btn-danger" onclick="deleteCustomer()">
                        <i class="fas fa-trash"></i> Delete Customer
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const name = document.getElementById('name').value.trim();
            const email = document.getElementById('email').value.trim();
            const phone = document.getElementById('phone').value.trim();
            
            if (!name || !email || !phone) {
                e.preventDefault();
                alert('Please fill in all required fields marked with *');
                return false;
            }
            
            // Email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Please enter a valid email address');
                return false;
            }
            
            // Phone validation (basic)
            const phoneRegex = /^[\+]?[0-9\s\-\(\)]{10,}$/;
            if (!phoneRegex.test(phone)) {
                e.preventDefault();
                alert('Please enter a valid phone number');
                return false;
            }
        });
        
        // Delete customer function
        function deleteCustomer() {
            if (confirm('Are you sure you want to delete this customer? This action cannot be undone.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'customers';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = '${customer.id}';
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
