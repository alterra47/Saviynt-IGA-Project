package com.savinyt.project.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 1. Fetch the current session (if it exists)
        HttpSession session = request.getSession(false);

        // 2. If a session exists, destroy it
        if (session != null) {
            session.invalidate();
        }

        // 3. Redirect back to the login page
        response.sendRedirect("index.jsp");
    }
}