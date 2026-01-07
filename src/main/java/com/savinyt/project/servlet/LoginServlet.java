package com.savinyt.project.servlet;
import com.savinyt.project.dao.RequestDAO;
import com.savinyt.project.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        RequestDAO dao = new RequestDAO();
        User user = dao.login(request.getParameter("username"), request.getParameter("password"));

        if (user != null) {
            request.getSession().setAttribute("currentUser", user);
            if ("MANAGER".equals(user.getRole())) {
                response.sendRedirect("manager_dashboard.jsp");
            } else {
                response.sendRedirect("employee_dashboard.jsp");
            }
        } else {
            response.sendRedirect("index.jsp?error=InvalidCreds");
        }
    }
}