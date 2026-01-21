package com.uniclubs.servlet;

import com.uniclubs.dao.ClubDAO;
import com.uniclubs.dao.NotificationsDAO;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/DeleteClubServlet")
public class DeleteClubServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ClubDAO dao = new ClubDAO();
        
        try {
            dao.deleteClub(id);
            
            // Notification Logic
            NotificationsDAO notifDAO = new NotificationsDAO();
            notifDAO.addNotification("club", "Staff", "A club (ID: " + id + ") has been removed from the system.");
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/manageClub");
    }
}