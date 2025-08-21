<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Item - Pahana Edu Billing System</title>
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
        .item-info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            border-left: 4px solid #667eea;
        }
        .item-info h3 {
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
        .stock-warning {
            background: #fff3cd;
            color: #856404;
            padding: 10px;
            border-radius: 5px;
            margin-top: 10px;
            border-left: 4px solid #ffc107;
        }
        @media (max-width: 768px) {
            .form-row, .info-grid, .price-grid {
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
            <h1><i class="fas fa-edit"></i> Edit Item</h1>
            <p>Update item information in the inventory system</p>
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
            
            <c:if test="${not empty item}">
                <div class="item-info">
                    <h3><i class="fas fa-info-circle"></i> Item Information</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <i class="fas fa-hashtag"></i>
                            <span><strong>ID:</strong> ${item.id}</span>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-calendar"></i>
                            <span><strong>Created:</strong> ${item.createdAt}</span>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-box"></i>
                            <span><strong>SKU:</strong> ${item.sku}</span>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-tag"></i>
                            <span><strong>Category:</strong> ${item.category}</span>
                        </div>
                    </div>
                </div>
            </c:if>
            
            <form action="items" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${item.id}">
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="name">Item Name <span class="required">*</span></label>
                        <input type="text" id="name" name="name" required 
                               placeholder="Enter item name"
                               value="${item.name}">
                    </div>
                    
                    <div class="form-group">
                        <label for="category">Category <span class="required">*</span></label>
                        <select id="category" name="category" required>
                            <option value="">Select Category</option>
                            <option value="BOOKS" ${item.category == 'BOOKS' ? 'selected' : ''}>Books</option>
                            <option value="STATIONERY" ${item.category == 'STATIONERY' ? 'selected' : ''}>Stationery</option>
                            <option value="ELECTRONICS" ${item.category == 'ELECTRONICS' ? 'selected' : ''}>Electronics</option>
                            <option value="UNIFORMS" ${item.category == 'UNIFORMS' ? 'selected' : ''}>Uniforms</option>
                            <option value="SPORTS" ${item.category == 'SPORTS' ? 'selected' : ''}>Sports Equipment</option>
                            <option value="OTHER" ${item.category == 'OTHER' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="price">Price (LKR) <span class="required">*</span></label>
                        <input type="number" id="price" name="price" required 
                               placeholder="0.00" step="0.01" min="0"
                               value="${item.price}">
                    </div>
                    
                    <div class="form-group">
                        <label for="stockQuantity">Stock Quantity <span class="required">*</span></label>
                        <input type="number" id="stockQuantity" name="stockQuantity" required 
                               placeholder="0" min="0"
                               value="${item.stockQuantity}">
                        <c:if test="${item.stockQuantity <= 10}">
                            <div class="stock-warning">
                                <i class="fas fa-exclamation-triangle"></i> Low stock alert! Current stock is ${item.stockQuantity} units.
                            </div>
                        </c:if>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="sku">SKU Code</label>
                        <input type="text" id="sku" name="sku" 
                               placeholder="Enter SKU code"
                               value="${item.sku}">
                    </div>
                    
                    <div class="form-group">
                        <label for="status">Status</label>
                        <select id="status" name="status">
                            <option value="ACTIVE" ${item.status == 'ACTIVE' ? 'selected' : ''}>Active</option>
                            <option value="INACTIVE" ${item.status == 'INACTIVE' ? 'selected' : ''}>Inactive</option>
                            <option value="DISCONTINUED" ${item.status == 'DISCONTINUED' ? 'selected' : ''}>Discontinued</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" rows="4" 
                              placeholder="Enter item description">${item.description}</textarea>
                </div>
                
                <div class="form-group">
                    <label for="supplier">Supplier</label>
                    <input type="text" id="supplier" name="supplier" 
                           placeholder="Enter supplier name"
                           value="${item.supplier}">
                </div>
                
                <div class="price-preview">
                    <h4><i class="fas fa-calculator"></i> Price Preview</h4>
                    <div class="price-grid">
                        <div class="price-item">
                            <span>Base Price:</span>
                            <span id="basePrice">LKR ${item.price}</span>
                        </div>
                        <div class="price-item">
                            <span>Stock Value:</span>
                            <span id="stockValue">LKR ${item.price * item.stockQuantity}</span>
                        </div>
                    </div>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Update Item
                    </button>
                                    <a href="items" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Items
                </a>
                    <button type="button" class="btn btn-danger" onclick="deleteItem()">
                        <i class="fas fa-trash"></i> Delete Item
                    </button>
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
        
        // Delete item function
        function deleteItem() {
            if (confirm('Are you sure you want to delete this item? This action cannot be undone.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'items';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = '${item.id}';
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // Initialize price preview
        updatePricePreview();
    </script>
</body>
</html>
