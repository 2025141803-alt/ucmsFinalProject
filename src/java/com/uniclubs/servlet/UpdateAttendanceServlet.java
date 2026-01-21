package com.uniclubs.servlet;

import com.uniclubs.dao.ActivityDAO; // Using the DAO that has recordAttendance
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/updateAttendance")
public class UpdateAttendanceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    
        String activityIdStr = request.getParameter("activityId");
        String studentIdStr = request.getParameter("studentId");
        String status = request.getParameter("status");

        if (activityIdStr != null && !activityIdStr.isEmpty() && studentIdStr != null && !studentIdStr.isEmpty()) {
            int actId = Integer.parseInt(activityIdStr);
            int stuId = Integer.parseInt(studentIdStr);
            
            ActivityDAO dao = new ActivityDAO();

            // 1. Check if status is PRESENT to decide on points
            double pointsToAdd = 0.0;
            if ("PRESENT".equalsIgnoreCase(status)) {
                pointsToAdd = 5.0; // Award 5 points only for being present
            }

            // 2. Update your DAO call to pass the points
            // Note: You will need to update the parameters in your DAO method as well
            boolean success = dao.recordAttendance(stuId, actId, status, pointsToAdd);
            
            response.sendRedirect("staffDashboard?msg=success");
        } else {
            response.sendRedirect("staffDashboard?error=MissingData");
        }
    }
}