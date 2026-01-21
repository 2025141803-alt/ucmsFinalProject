package com.uniclubs.servlet;

import com.uniclubs.dao.DashboardStaffDAO;
import com.uniclubs.model.Activity; // Ensure you have an Activity model
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/attendanceList")
public class AttendanceListServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        DashboardStaffDAO dao = new DashboardStaffDAO();
        
        // 1. You need a method to get all activities
        // If you don't have this in your DAO yet, see Step 2 below
        List<Activity> activityList = dao.getAllActivities();
        
        request.setAttribute("activities", activityList);
        
        // 2. Forward to a JSP that lists these activities
        request.getRequestDispatcher("attendanceActivityList.jsp").forward(request, response);
    }
}