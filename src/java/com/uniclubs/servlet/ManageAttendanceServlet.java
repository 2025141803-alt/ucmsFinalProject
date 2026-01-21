package com.uniclubs.servlet;

import com.uniclubs.dao.DashboardStaffDAO;
import com.uniclubs.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/manageAttendance")
public class ManageAttendanceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get the Activity ID from the URL (e.g., manageAttendance?activityId=5)
        String idParam = request.getParameter("activityId");
        
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("staffDashboard.jsp");
            return;
        }

        int activityId = Integer.parseInt(idParam);
        DashboardStaffDAO dao = new DashboardStaffDAO();
        
        // 2. Fetch the list of students who joined this specific activity
        // Note: You must have the getAttendeesByActivity method in your DAO
        List<User> attendeeList = dao.getAttendeesByActivity(activityId);
        
        // 3. Pass the data to the JSP
        request.setAttribute("attendees", attendeeList);
        request.setAttribute("activityId", activityId);
        request.getRequestDispatcher("manageAttendance.jsp").forward(request, response);
    }
}