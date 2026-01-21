package com.uniclubs.servlet;

import com.uniclubs.dao.DashboardStaffDAO;
import com.uniclubs.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/JoinActivityServlet")
public class JoinActivityServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        int activityId = Integer.parseInt(request.getParameter("activityId"));
        int studentId = user.getUserId();

        DashboardStaffDAO dao = new DashboardStaffDAO();
        // Inside your JoinActivityServlet.java
boolean success = dao.registerForActivity(studentId, activityId);

// Inside your JoinActivityServlet.java
if (success) {
    // Redirect to the joined activities page with a success flag
    response.sendRedirect("myJoinedActivities?msg=joinSuccess");
} else {
    // Redirect back to details if it failed
    response.sendRedirect("ActivityDetailServlet?id=" + activityId + "&msg=error");
}
    }
}