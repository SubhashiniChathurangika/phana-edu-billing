<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Settings - Pahana Edu Billing System</title>
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
            max-width: 1200px;
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
        .settings-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        .settings-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .section-title {
            font-size: 1.5em;
            font-weight: 600;
            margin-bottom: 25px;
            color: #333;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s ease;
        }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
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
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        .btn-danger:hover {
            background: #c82333;
            transform: translateY(-2px);
        }
        .alert {
            padding: 15px;
            border-radius: 8px;
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
        .user-list {
            list-style: none;
            margin-top: 20px;
        }
        .user-item {
            padding: 15px;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .user-info {
            display: flex;
            flex-direction: column;
        }
        .user-name {
            font-weight: 600;
            color: #333;
        }
        .user-role {
            color: #666;
            font-size: 0.9em;
        }
        .user-actions {
            display: flex;
            gap: 10px;
        }
        .btn-small {
            padding: 8px 15px;
            font-size: 0.9em;
        }
        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 34px;
        }
        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 34px;
        }
        .slider:before {
            position: absolute;
            content: "";
            height: 26px;
            width: 26px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }
        input:checked + .slider {
            background-color: #667eea;
        }
        input:checked + .slider:before {
            transform: translateX(26px);
        }
        .setting-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #e9ecef;
        }
        .setting-item:last-child {
            border-bottom: none;
        }
        .setting-info h4 {
            margin-bottom: 5px;
            color: #333;
        }
        .setting-info p {
            color: #666;
            font-size: 0.9em;
        }
        .backup-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
        }
        .backup-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .backup-date {
            color: #666;
            font-size: 0.9em;
        }
        @media (max-width: 768px) {
            .settings-grid {
                grid-template-columns: 1fr;
            }
            .user-actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-cog"></i> System Settings</h1>
            <p>Manage system configuration and user accounts</p>
        </div>
        
        <div class="settings-grid">
            <!-- User Management Section -->
            <div class="settings-section">
                <div class="section-title">
                    <i class="fas fa-users"></i> User Management
                </div>
                
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
                
                <form action="settings" method="post">
                    <input type="hidden" name="action" value="addUser">
                    
                    <div class="form-group">
                        <label for="username">Username <span style="color: #dc3545;">*</span></label>
                        <input type="text" id="username" name="username" required 
                               placeholder="Enter username">
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Password <span style="color: #dc3545;">*</span></label>
                        <input type="password" id="password" name="password" required 
                               placeholder="Enter password">
                    </div>
                    
                    <div class="form-group">
                        <label for="role">Role</label>
                        <select id="role" name="role">
                            <option value="STAFF">Staff</option>
                            <option value="ADMIN">Admin</option>
                        </select>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-user-plus"></i> Add User
                    </button>
                </form>
                
                <ul class="user-list">
                    <c:forEach var="user" items="${users}">
                        <li class="user-item">
                            <div class="user-info">
                                <div class="user-name">${user.username}</div>
                                <div class="user-role">${user.role}</div>
                            </div>
                            <div class="user-actions">
                                <button class="btn btn-secondary btn-small" onclick="editUser(${user.id})">
                                    <i class="fas fa-edit"></i> Edit
                                </button>
                                <button class="btn btn-danger btn-small" onclick="deleteUser(${user.id})">
                                    <i class="fas fa-trash"></i> Delete
                                </button>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            
            <!-- System Settings Section -->
            <div class="settings-section">
                <div class="section-title">
                    <i class="fas fa-cogs"></i> System Configuration
                </div>
                
                <form action="settings" method="post">
                    <input type="hidden" name="action" value="updateSettings">
                    
                    <div class="setting-item">
                        <div class="setting-info">
                            <h4>Email Notifications</h4>
                            <p>Send email notifications for low stock alerts</p>
                        </div>
                        <label class="toggle-switch">
                            <input type="checkbox" name="emailNotifications" 
                                   ${settings.emailNotifications ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>
                    
                    <div class="setting-item">
                        <div class="setting-info">
                            <h4>Auto Backup</h4>
                            <p>Automatically backup database daily</p>
                        </div>
                        <label class="toggle-switch">
                            <input type="checkbox" name="autoBackup" 
                                   ${settings.autoBackup ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>
                    
                    <div class="setting-item">
                        <div class="setting-info">
                            <h4>Stock Alerts</h4>
                            <p>Show low stock warnings</p>
                        </div>
                        <label class="toggle-switch">
                            <input type="checkbox" name="stockAlerts" 
                                   ${settings.stockAlerts ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>
                    
                    <div class="form-group">
                        <label for="lowStockThreshold">Low Stock Threshold</label>
                        <input type="number" id="lowStockThreshold" name="lowStockThreshold" 
                               value="${settings.lowStockThreshold}" min="1">
                    </div>
                    
                    <div class="form-group">
                        <label for="companyName">Company Name</label>
                        <input type="text" id="companyName" name="companyName" 
                               value="${settings.companyName}" placeholder="Enter company name">
                    </div>
                    
                    <div class="form-group">
                        <label for="companyAddress">Company Address</label>
                        <textarea id="companyAddress" name="companyAddress" rows="3" 
                                  placeholder="Enter company address">${settings.companyAddress}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="companyPhone">Company Phone</label>
                        <input type="tel" id="companyPhone" name="companyPhone" 
                               value="${settings.companyPhone}" placeholder="Enter company phone">
                    </div>
                    
                    <div class="form-group">
                        <label for="companyEmail">Company Email</label>
                        <input type="email" id="companyEmail" name="companyEmail" 
                               value="${settings.companyEmail}" placeholder="Enter company email">
                    </div>
                    
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Save Settings
                    </button>
                </form>
                
                <div class="backup-section">
                    <div class="backup-info">
                        <div>
                            <h4>Database Backup</h4>
                            <p>Last backup: <span class="backup-date">${lastBackupDate}</span></p>
                        </div>
                        <button class="btn btn-secondary" onclick="createBackup()">
                            <i class="fas fa-download"></i> Create Backup
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Edit user function
        function editUser(userId) {
            // This would typically open a modal or redirect to edit page
            alert('Edit user functionality would be implemented here for user ID: ' + userId);
        }
        
        // Delete user function
        function deleteUser(userId) {
            if (confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'settings';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'deleteUser';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'userId';
                idInput.value = userId;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // Create backup function
        function createBackup() {
            if (confirm('Create a new database backup? This may take a few moments.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'settings';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'createBackup';
                
                form.appendChild(actionInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // Form validation
        document.querySelectorAll('form').forEach(form => {
            form.addEventListener('submit', function(e) {
                const requiredFields = form.querySelectorAll('[required]');
                let isValid = true;
                
                requiredFields.forEach(field => {
                    if (!field.value.trim()) {
                        isValid = false;
                        field.style.borderColor = '#dc3545';
                    } else {
                        field.style.borderColor = '#e1e5e9';
                    }
                });
                
                if (!isValid) {
                    e.preventDefault();
                    alert('Please fill in all required fields marked with *');
                }
            });
        });
    </script>
</body>
</html>
