package com.savinyt.project.servlet;

import com.savinyt.project.dao.RequestDAO;
import com.savinyt.project.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/action")
public class ActionServlet extends HttpServlet {
    private final RequestDAO dao = new RequestDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        String action = request.getParameter("action");

        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Logic for Employee requesting access
        if ("request_access".equals(action)) {
            int resourceId = Integer.parseInt(request.getParameter("resourceId"));
            dao.createRequest(user.getId(), resourceId); // Using User getter
            response.sendRedirect("employee_dashboard.jsp?status=success");
        }

        // Logic for Manager approving/rejecting
        else if ("approve".equals(action) || "reject".equals(action)) {
            if (!"MANAGER".equals(user.getRole())) return; // Security check

            int requestId = Integer.parseInt(request.getParameter("requestId"));
            String status = "approve".equals(action) ? "APPROVED" : "REJECTED";

            dao.updateStatus(requestId, status);
            response.sendRedirect("manager_dashboard.jsp?msg=StatusUpdated");
        }
    }
}