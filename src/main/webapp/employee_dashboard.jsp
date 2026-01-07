<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.savinyt.project.model.User" %>

<%
    // Session Check Logic
    User user = (User) session.getAttribute("currentUser");
    if(user == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard | Saviynt IGA</title>
    <style>
        /* Base Reset */
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background-color: #f0f2f5; color: #333; }

        /* Navbar */
        .navbar {
            background-color: #0056b3;
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .navbar h2 { font-size: 1.2rem; font-weight: 500; }
        .logout-btn {
            background-color: rgba(255, 255, 255, 0.15);
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 4px;
            font-size: 0.9rem;
            transition: background-color 0.2s;
            border: 1px solid rgba(255,255,255,0.2);
        }
        .logout-btn:hover { background-color: #d32f2f; border-color: #d32f2f; }

        /* Layout */
        .container { max-width: 800px; margin: 3rem auto; padding: 0 1rem; }

        /* Card */
        .card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            padding: 2rem;
        }
        .card-header { margin-bottom: 1.5rem; border-bottom: 1px solid #eee; padding-bottom: 1rem; }
        .card-header h3 { color: #1a1a1a; font-size: 1.4rem; }
        .card-header p { color: #666; margin-top: 0.5rem; font-size: 0.95rem; }

        /* Form */
        .form-group { margin-bottom: 1.5rem; }
        label { display: block; margin-bottom: 0.5rem; font-weight: 500; color: #444; }
        select {
            width: 100%; padding: 0.75rem; border: 1px solid #ddd;
            border-radius: 4px; font-size: 1rem; background-color: #fff; cursor: pointer;
        }
        select:focus { outline: none; border-color: #0056b3; box-shadow: 0 0 0 3px rgba(0, 86, 179, 0.1); }

        input[type="submit"] {
            background-color: #0056b3; color: white; border: none;
            padding: 0.8rem 1.5rem; font-size: 1rem; border-radius: 4px;
            cursor: pointer; font-weight: 600; transition: background-color 0.2s;
        }
        input[type="submit"]:hover { background-color: #004494; }
    </style>
</head>
<body>

    <div class="navbar">
        <div class="user-info">Welcome, <strong><%= user.getUsername() %></strong></div>
        <a href="logout" class="logout-btn">Logout</a>
    </div>

    <div class="container">
        <div class="card">
            <div class="card-header">
                <h3>Request New Access</h3>
                <p>Select a corporate resource to request access permissions.</p>
            </div>

            <form action="action" method="post">
                <input type="hidden" name="action" value="request_access">

                <div class="form-group">
                    <label for="resourceSelect">Available Resources</label>
                    <select name="resourceId" id="resourceSelect">
                        <option value="1">Financial Data (High Risk)</option>
                        <option value="2">Employee Handbook (Low Risk)</option>
                        <option value="3">IT Admin Tools (Restricted)</option>
                    </select>
                </div>

                <div class="form-group">
                    <input type="submit" value="Submit Request">
                </div>
            </form>
        </div>
    </div>

    <%
        String status = request.getParameter("status");
        if("success".equals(status)) {
    %>
        <script>
            // This runs automatically when the page loads with ?status=success
            setTimeout(function() {
                alert("✅ Success!\n\nYour access request has been submitted to your Manager.");

                // Optional: This removes the '?status=success' from the URL bar
                // so if they refresh the page, the alert doesn't pop up again.
                window.history.replaceState({}, document.title, window.location.pathname);
            }, 100);
        </script>
    <% } %>

</body>
</html>