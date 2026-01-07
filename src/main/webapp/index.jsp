<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Saviynt IGA | Login</title>
    <style>
        /* Reset and Base Styles */
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }

        body {
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }

        /* Card Container */
        .login-card {
            background: white;
            padding: 2.5rem;
            width: 100%;
            max-width: 400px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        /* Logo/Header Area */
        .login-header {
            margin-bottom: 2rem;
        }

        .login-header h2 {
            color: #1a1a1a;
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }

        .login-header p {
            color: #666;
            font-size: 0.9rem;
        }

        /* Form Elements */
        .form-group {
            margin-bottom: 1.2rem;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            color: #444;
            font-size: 0.9rem;
            font-weight: 500;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
            transition: border-color 0.2s;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #0056b3;
            box-shadow: 0 0 0 3px rgba(0, 86, 179, 0.1);
        }

        /* Button Styling */
        input[type="submit"] {
            width: 100%;
            padding: 0.75rem;
            background-color: #0056b3;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
            margin-top: 1rem;
        }

        input[type="submit"]:hover {
            background-color: #004494;
        }

        /* Error Message Box */
        .error-message {
            background-color: #fde8e8;
            color: #c53030;
            padding: 0.75rem;
            border-radius: 4px;
            border: 1px solid #fbd5d5;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            display: none; /* Hidden by default */
        }

        .footer {
            margin-top: 2rem;
            font-size: 0.8rem;
            color: #888;
        }
    </style>
</head>
<body>

    <div class="login-card">
        <div class="login-header">
            <h2>Identity Governance</h2>
            <p>Secure Access Portal</p>
        </div>

        <% if (request.getParameter("error") != null) { %>
            <div class="error-message" style="display: block;">
                Invalid Username or Password.
            </div>
        <% } %>

        <form action="login" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Enter your ID" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>

            <input type="submit" value="Sign In">
        </form>

        <div class="footer">
            &copy; 2024 Saviynt Access Control. Restricted System.
        </div>
    </div>

</body>
</html>