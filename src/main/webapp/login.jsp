<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - Pahana Edu Billing</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f2f2f2; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .login-box { background-color: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px #aaa; }
        input[type="text"], input[type="password"] { width: 100%; padding: 8px; margin: 8px 0; }
        input[type="submit"] { padding: 8px 16px; margin-top: 10px; }
        .error { color: red; }
    </style>
</head>
<body>
<div class="login-box">
    <h2>Login</h2>
    <form action="login" method="post">
        <label>Username:</label>
        <input type="text" name="username" required/>
        <label>Password:</label>
        <input type="password" name="password" required/>
        <input type="submit" value="Login"/>
    </form>
    <div class="error">
        <c:if test="${not empty errorMessage}">
            ${errorMessage}
        </c:if>
    </div>
</div>
</body>
</html>
