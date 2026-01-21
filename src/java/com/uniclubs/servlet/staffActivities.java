package com.uniclubs.servlet;

import com.uniclubs.dao.ActivityDAO;
import com.uniclubs.model.Activity;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/manageActivities")
public class staffActivities extends HttpServlet {

    private ActivityDAO activityDAO;

    @Override
    public void init() {
        activityDAO = new ActivityDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Initialize activities safely
        List<Activity> activities = activityDAO.getAllActivities();

        try {
            // Use the correct DAO variable name
            activities = activityDAO.getAllActivities();
            if (activities == null) {
                activities = new ArrayList<>();
            }
        } catch (Exception e) {
            e.printStackTrace();
            // fallback to empty list if error occurs
            activities = new ArrayList<>();
        }

        // Set attribute for JSP
        request.setAttribute("activities", activities);

        // Forward to JSP safely
        request.getRequestDispatcher("/manageActivities.jsp").forward(request, response);
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String name = request.getParameter("name");
    String date = request.getParameter("date");
    String time = request.getParameter("time");
    String venue = request.getParameter("venue");
    String clubName = request.getParameter("clubName");
    String createdBy = "Staff"; 

    Activity activity = new Activity(name, date, time, venue, clubName, createdBy);
    activityDAO.addActivity(activity);

    // --- ADD THIS NOTIFICATION LOGIC HERE ---
    com.uniclubs.dao.NotificationsDAO notifDAO = new com.uniclubs.dao.NotificationsDAO();
    String msg = clubName + " added a new activity: " + name + " at " + venue;
    notifDAO.addNotification("activity", clubName, msg);
    // ----------------------------------------

    response.sendRedirect(request.getContextPath() + "/manageActivities");
}
}
