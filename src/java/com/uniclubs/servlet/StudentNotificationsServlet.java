package com.uniclubs.servlet;

import com.uniclubs.dao.NotificationsDAO;
import com.uniclubs.model.Notifications;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/studentNotifications")
public class StudentNotificationsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get data from the same DAO the staff uses
        com.uniclubs.dao.NotificationsDAO dao = new com.uniclubs.dao.NotificationsDAO();
        List<com.uniclubs.model.Notifications> list = dao.getAllNotifications();
        
        // 2. Set attribute (must match the name "notifications" in your JSP)
        request.setAttribute("notifications", list);
        
        // 3. Forward to the student version of the JSP
        request.getRequestDispatcher("studentNotifications.jsp").forward(request, response);
    }
}