<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Item - Pahana Edu Billing System</title>
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
        .price-preview {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            margin-top: 10px;
            border-left: 4px solid #28a745;
        }
        .price-preview h4 {
            color: #28a745;
            margin-bottom: 10px;
        }
        .price-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        .price-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px 0;
            border-bottom: 1px solid #e9ecef;
        }
        .price-item:last-child {
            border-bottom: none;
            font-weight: bold;
            color: #667eea;
        }
        @media (max-width: 768px) {
            .form-row, .price-grid {
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
            <h1><i class="fas fa-box-open"></i> Add New Item</h1>
            <p>Add a new item to the inventory system</p>
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
            
            <form action="items" method="post">
                <input type="hidden" name="action" value="add">
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="name">Item Name <span class="required">*</span></label>
                        <input type="text" id="name" name="name" required 
                               placeholder="Enter item name"
                               value="${param.name}">
                    </div>
                    
                    <div class="form-group">
                        <label for="category">Category <span class="required">*</span></label>
                        <select id="category" name="category" required>
                            <option value="">Select Category</option>
                            <option value="BOOKS" ${param.category == 'BOOKS' ? 'selected' : ''}>Books</option>
                            <option value="STATIONERY" ${param.category == 'STATIONERY' ? 'selected' : ''}>Stationery</option>
                            <option value="ELECTRONICS" ${param.category == 'ELECTRONICS' ? 'selected' : ''}>Electronics</option>
                            <option value="UNIFORMS" ${param.category == 'UNIFORMS' ? 'selected' : ''}>Uniforms</option>
                            <option value="SPORTS" ${param.category == 'SPORTS' ? 'selected' : ''}>Sports Equipment</option>
                            <option value="OTHER" ${param.category == 'OTHER' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="price">Price (LKR) <span class="required">*</span></label>
                        <input type="number" id="price" name="price" required 
                               placeholder="0.00" step="0.01" min="0"
                               value="${param.price}">
                    </div>
                    
                    <div class="form-group">
                        <label for="stockQuantity">Stock Quantity <span class="required">*</span></label>
                        <input type="number" id="stockQuantity" name="stockQuantity" required 
                               placeholder="0" min="0"
                               value="${param.stockQuantity}">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="sku">SKU Code</label>
                        <input type="text" id="sku" name="sku" 
                               placeholder="Enter SKU code"
                               value="${param.sku}">
                    </div>
                    
                    <div class="form-group">
                        <label for="status">Status</label>
                        <select id="status" name="status">
                            <option value="ACTIVE" ${param.status == 'ACTIVE' ? 'selected' : ''}>Active</option>
                            <option value="INACTIVE" ${param.status == 'INACTIVE' ? 'selected' : ''}>Inactive</option>
                            <option value="DISCONTINUED" ${param.status == 'DISCONTINUED' ? 'selected' : ''}>Discontinued</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" rows="4" 
                              placeholder="Enter item description">${param.description}</textarea>
                </div>
                
                <div class="form-group">
                    <label for="supplier">Supplier</label>
                    <input type="text" id="supplier" name="supplier" 
                           placeholder="Enter supplier name"
                           value="${param.supplier}">
                </div>
                
                <div class="price-preview">
                    <h4><i class="fas fa-calculator"></i> Price Preview</h4>
                    <div class="price-grid">
                        <div class="price-item">
                            <span>Base Price:</span>
                            <span id="basePrice">LKR 0.00</span>
                        </div>
                        <div class="price-item">
                            <span>Stock Value:</span>
                            <span id="stockValue">LKR 0.00</span>
                        </div>
                    </div>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Add Item
                    </button>
                                    <a href="items" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Items
                </a>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // Form validation and price calculation
        const priceInput = document.getElementById('price');
        const stockInput = document.getElementById('stockQuantity');
        const basePriceSpan = document.getElementById('basePrice');
        const stockValueSpan = document.getElementById('stockValue');
        
        function updatePricePreview() {
            const price = parseFloat(priceInput.value) || 0;
            const stock = parseInt(stockInput.value) || 0;
            const stockValue = price * stock;
            
            basePriceSpan.textContent = `LKR ${price.toFixed(2)}`;
            stockValueSpan.textContent = `LKR ${stockValue.toFixed(2)}`;
        }
        
        priceInput.addEventListener('input', updatePricePreview);
        stockInput.addEventListener('input', updatePricePreview);
        
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const name = document.getElementById('name').value.trim();
            const category = document.getElementById('category').value;
            const price = parseFloat(document.getElementById('price').value);
            const stockQuantity = parseInt(document.getElementById('stockQuantity').value);
            
            if (!name || !category || isNaN(price) || isNaN(stockQuantity)) {
                e.preventDefault();
                alert('Please fill in all required fields marked with *');
                return false;
            }
            
            if (price < 0) {
                e.preventDefault();
                alert('Price cannot be negative');
                return false;
            }
            
            if (stockQuantity < 0) {
                e.preventDefault();
                alert('Stock quantity cannot be negative');
                return false;
            }
        });
        
        // Initialize price preview
        updatePricePreview();
    </script>
</body>
</html>
