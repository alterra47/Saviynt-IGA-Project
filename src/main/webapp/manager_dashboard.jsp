<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.savinyt.project.model.Request" %>
<%@ page import="com.savinyt.project.model.User" %>
<%@ page import="com.savinyt.project.dao.RequestDAO" %>

<%
    // 1. Session Check
    User user = (User) session.getAttribute("currentUser");
    if(user == null || !"MANAGER".equals(user.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manager Dashboard | Saviynt IGA</title>
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
            border: 1px solid rgba(255,255,255,0.2);
            transition: background-color 0.2s;
        }

        .logout-btn:hover { background-color: #d32f2f; border-color: #d32f2f; }

        /* Container */
        .container { max-width: 1000px; margin: 3rem auto; padding: 0 1rem; }

        /* Card */
        .card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            padding: 2rem;
        }

        .card-header {
            border-bottom: 1px solid #eee;
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-header h3 { color: #1a1a1a; font-size: 1.4rem; }
        .request-count { background: #e3f2fd; color: #0d47a1; padding: 4px 10px; border-radius: 12px; font-size: 0.85rem; font-weight: bold; }

        /* Table Styling */
        .styled-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.95rem;
        }

        .styled-table thead tr {
            background-color: #f8f9fa;
            color: #444;
            text-align: left;
        }

        .styled-table th, .styled-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
        }

        .styled-table tbody tr:hover { background-color: #f9f9f9; }

        /* Status Badge */
        .status-badge {
            background-color: #fff3cd;
            color: #856404;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
            font-weight: bold;
            text-transform: uppercase;
        }

        /* Action Buttons */
        .action-form { display: flex; gap: 8px; }

        .btn {
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.85rem;
            font-weight: 600;
            transition: opacity 0.2s;
        }
        .btn:hover { opacity: 0.9; }

        .btn-approve { background-color: #28a745; color: white; }
        .btn-reject { background-color: #dc3545; color: white; }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #666;
        }

        .error-msg { color: #dc3545; background: #f8d7da; padding: 1rem; border-radius: 4px; margin-bottom: 1rem; }
    </style>
</head>
<body>

    <div class="navbar">
        <div class="user-info">Manager Portal: <strong><%= user.getUsername() %></strong></div>
        <a href="logout" class="logout-btn">Logout</a>
    </div>

    <div class="container">

        <%
            // 2. Fetch Data
            RequestDAO dao = new RequestDAO();
            List<Request> list = null;
            String errorMsg = null;

            try {
                list = dao.getPendingRequests();
                System.out.println("JSP DEBUG: List size is " + (list != null ? list.size() : "null"));
            } catch (Exception e) {
                errorMsg = e.getMessage();
                e.printStackTrace();
            }
        %>

        <div class="card">
            <div class="card-header">
                <h3>Pending Access Approvals</h3>
                <% if (list != null && !list.isEmpty()) { %>
                    <span class="request-count"><%= list.size() %> Pending</span>
                <% } %>
            </div>

            <% if (errorMsg != null) { %>
                <div class="error-msg">Error: <%= errorMsg %></div>
            <% } %>

            <% if (list != null && !list.isEmpty()) { %>
                <table class="styled-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Requester</th>
                            <th>Resource</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Request r : list) { %>
                        <tr>
                            <td>#<%= r.getRequestId() %></td>
                            <td><strong><%= r.getRequesterName() %></strong></td>
                            <td><%= r.getResourceName() %></td>
                            <td><span class="status-badge"><%= r.getStatus() %></span></td>
                            <td>
                                <form action="action" method="post" class="action-form">
                                    <input type="hidden" name="requestId" value="<%= r.getRequestId() %>">
                                    <button type="submit" name="action" value="approve" class="btn btn-approve">Approve</button>
                                    <button type="submit" name="action" value="reject" class="btn btn-reject">Reject</button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="empty-state">
                    <h3>All caught up!</h3>
                    <p>There are no pending requests requiring your approval.</p>
                </div>
            <% } %>
        </div>
    </div>

</body>
</html>