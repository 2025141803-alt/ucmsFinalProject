package com.uniclubs.servlet;

import java.io.IOException;
import java.sql.Timestamp; 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.uniclubs.model.Activity;
import com.uniclubs.dao.ActivityDAO;

@WebServlet("/UpdateActivityServlet")
public class UpdateActivityServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get the ID from the parameter (stored as 'id')
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String venue = request.getParameter("venue");
        String clubName = request.getParameter("clubName");

        Timestamp updatedAt = new Timestamp(System.currentTimeMillis());
        Activity activity = new Activity(id, name, date, time, venue, clubName, "Staff", updatedAt);
        
        ActivityDAO dao = new ActivityDAO();
        dao.updateActivity(activity);

        // 2. Notification Logic
        com.uniclubs.dao.NotificationsDAO notifDAO = new com.uniclubs.dao.NotificationsDAO();
        String msg = clubName + " updated the activity '" + name + "'. New Venue: " + venue + " at " + time;
        notifDAO.addNotification("activity", clubName, msg);
        
        // 3. FIX: Use 'id' instead of 'activityId' for the redirect
        response.sendRedirect("manageAttendance?activityId=" + id);
    }
}