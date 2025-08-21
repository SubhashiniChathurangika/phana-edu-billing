<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Pahana Edu Billing System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 400px;
            position: relative;
            overflow: hidden;
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
        }

        .logo-section {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .logo-icon i {
            font-size: 36px;
            color: white;
        }

        .logo-title {
            font-size: 28px;
            font-weight: 700;
            color: #333;
            margin-bottom: 8px;
        }

        .logo-subtitle {
            color: #666;
            font-size: 14px;
            font-weight: 400;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
            font-size: 14px;
        }

        .input-wrapper {
            position: relative;
        }

        .input-wrapper i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            font-size: 16px;
        }

        .form-control {
            width: 100%;
            padding: 15px 15px 15px 45px;
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-control:focus + i {
            color: #667eea;
        }

        .btn-login {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .error-message {
            background: #fee;
            color: #c33;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #c33;
            font-size: 14px;
            display: flex;
            align-items: center;
        }

        .error-message i {
            margin-right: 8px;
        }

        .demo-credentials {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            margin-top: 20px;
            border: 1px solid #e1e5e9;
        }

        .demo-credentials h4 {
            color: #333;
            margin-bottom: 10px;
            font-size: 14px;
            font-weight: 600;
        }

        .demo-credentials p {
            color: #666;
            font-size: 12px;
            margin-bottom: 5px;
        }

        .demo-credentials strong {
            color: #667eea;
        }

        .footer-text {
            text-align: center;
            margin-top: 20px;
            color: #666;
            font-size: 12px;
        }

        @media (max-width: 480px) {
            .login-container {
                padding: 30px 20px;
                margin: 10px;
            }
            
            .logo-title {
                font-size: 24px;
            }
            
            .form-control {
                padding: 12px 12px 12px 40px;
            }
        }

        .loading {
            display: none;
        }

        .loading.show {
            display: inline-block;
        }

        .spinner {
            width: 16px;
            height: 16px;
            border: 2px solid #ffffff;
            border-top: 2px solid transparent;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-right: 8px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo-section">
            <div class="logo-icon">
                <i class="fas fa-graduation-cap"></i>
            </div>
            <h1 class="logo-title">Pahana Edu</h1>
            <p class="logo-subtitle">Billing Management System</p>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                <i class="fas fa-exclamation-triangle"></i>
                ${errorMessage}
            </div>
        </c:if>

        <form action="login" method="post" id="loginForm">
            <div class="form-group">
                <label for="username">Username</label>
                <div class="input-wrapper">
                    <input type="text" id="username" name="username" class="form-control" 
                           placeholder="Enter your username" required autocomplete="username">
                    <i class="fas fa-user"></i>
                </div>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-wrapper">
                    <input type="password" id="password" name="password" class="form-control" 
                           placeholder="Enter your password" required autocomplete="current-password">
                    <i class="fas fa-lock"></i>
                </div>
            </div>

            <button type="submit" class="btn-login" id="loginBtn">
                <span class="loading" id="loading">
                    <span class="spinner"></span>
                </span>
                <span id="loginText">Sign In</span>
            </button>
        </form>

        <div class="demo-credentials">
            <h4><i class="fas fa-info-circle"></i> Demo Credentials</h4>
            <p><strong>Admin:</strong> admin / admin123</p>
            <p><strong>Staff:</strong> staff1 / staff123</p>
            <p><strong>Manager:</strong> manager / manager123</p>
        </div>

        <div class="footer-text">
            <p>&copy; 2024 Pahana Edu Billing System</p>
            <p>ICBT CIS6003 S3SRI WRIT1 Project</p>
        </div>
    </div>

    <script>
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const loginBtn = document.getElementById('loginBtn');
            const loading = document.getElementById('loading');
            const loginText = document.getElementById('loginText');
            
            // Show loading state
            loading.classList.add('show');
            loginText.textContent = 'Signing In...';
            loginBtn.disabled = true;
            
            // Simulate a small delay for better UX
            setTimeout(() => {
                // Form will submit normally
            }, 500);
        });

        // Add focus effects
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.querySelector('i').style.color = '#667eea';
            });
            
            input.addEventListener('blur', function() {
                if (!this.value) {
                    this.parentElement.querySelector('i').style.color = '#999';
                }
            });
        });

        // Auto-focus on username field
        document.getElementById('username').focus();
    </script>
</body>
</html>
