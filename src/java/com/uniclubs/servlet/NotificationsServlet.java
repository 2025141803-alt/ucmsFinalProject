package com.uniclubs.servlet;

import com.uniclubs.dao.NotificationsDAO;
import com.uniclubs.model.Notifications;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/manageNotifications")
public class NotificationsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        NotificationsDAO dao = new NotificationsDAO();
        List<Notifications> list = dao.getAllNotifications();
        System.out.println("DEBUG: Found " + list.size() + " notifications in DB.");
        // Pass the list to the JSP
        request.setAttribute("notifications", list);
        
        // Forward to your notification.jsp
        request.getRequestDispatcher("manageNotifications.jsp").forward(request, response);
    }
}