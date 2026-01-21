package com.uniclubs.servlet;

import com.uniclubs.dao.DashboardStaffDAO;
import com.uniclubs.dao.ActivityDAO; // Ensure this is imported
import com.uniclubs.model.Membership;
import com.uniclubs.model.User;
import com.uniclubs.model.Activity; // Ensure this is imported
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.uniclubs.model.ActivityRegistration;

@WebServlet("/staffDashboard")
public class StaffDashboardServlet extends HttpServlet {

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        DashboardStaffDAO dao = new DashboardStaffDAO();
        // Use consistent naming: activityDao
        ActivityDAO activityDao = new ActivityDAO();

        // 1. Stats
        request.setAttribute("totalClubs", dao.getCount("CLUBS"));
        request.setAttribute("totalActivities", dao.getCount("ACTIVITIES"));
        request.setAttribute("totalNotifications", dao.getCount("NOTIFICATIONS"));

        // 2. Memberships
        request.setAttribute("membershipList", dao.getAllMembershipsForStaff());

        // 3. Activities (Fetching once)
        List<Activity> activityList = activityDao.getAllActivities();
        request.setAttribute("activityList", activityList);

        // 4. Activity Registrations (The names in your dropdown)
        List<ActivityRegistration> activitySignupList = activityDao.getAllActivitySignups();
        request.setAttribute("activitySignupList", activitySignupList);

    } catch (Exception e) {
        System.out.println("Dashboard Loading Error: " + e.getMessage());
        e.printStackTrace();
    }

    // Always forward to the JSP
    request.getRequestDispatcher("staffHPage.jsp").forward(request, response);
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        DashboardStaffDAO dao = new DashboardStaffDAO();

        if ("deleteByStaff".equals(action)) {
            String midParam = request.getParameter("membershipId");
            if (midParam != null) {
                int mid = Integer.parseInt(midParam);
                if (dao.deleteMembership(mid)) {
                    response.sendRedirect("staffDashboard?msg=deleted");
                } else {
                    response.sendRedirect("staffDashboard?error=failed");
                }
            }
        }
    }
}