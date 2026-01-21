package com.uniclubs.servlet;

import com.uniclubs.dao.ActivityDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.uniclubs.dao.NotificationsDAO;

@WebServlet("/DeleteActivityServlet")
public class DeleteActivityServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get the ID from the URL (...?id=5)
        String idStr = request.getParameter("id");
        
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                
                // 2. Call the DAO to delete
                ActivityDAO dao = new ActivityDAO();
                dao.deleteActivity(id);
                
                NotificationsDAO notifDAO = new NotificationsDAO();
                String msg = "Activity (ID: " + id + ") has been cancelled and removed.";
                notifDAO.addNotification("activity", "System", msg);
                
                System.out.println("Deleted activity ID: " + id);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        // 3. Redirect back to the manage page to see the updated list
        response.sendRedirect(request.getContextPath() + "/manageActivities");
    }
}