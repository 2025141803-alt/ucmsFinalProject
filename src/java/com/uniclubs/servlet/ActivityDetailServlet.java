package com.uniclubs.servlet;

import com.uniclubs.dao.ActivityDAO;
import com.uniclubs.model.Activity;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/ActivityDetailServlet")
public class ActivityDetailServlet extends HttpServlet {

    private ActivityDAO activityDAO;

    @Override
    public void init() {
        activityDAO = new ActivityDAO();
    }

   @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    String idStr = request.getParameter("id");
    HttpSession session = request.getSession();
    com.uniclubs.model.User user = (com.uniclubs.model.User) session.getAttribute("user");

    try {
        if (idStr != null && !idStr.isEmpty()) {
            int activityId = Integer.parseInt(idStr);
            Activity activity = activityDAO.getActivityById(activityId);
            
            if (activity != null) {
                // --- NEW LOGIC START ---
                // 1. Check if the user is a student and if they already joined
               boolean isJoined = false;
if (user != null && "student".equals(user.getRole())) {
    isJoined = activityDAO.isUserRegistered(user.getUserId(), activityId);
}
// ADD THIS LINE
System.out.println("DEBUG Servlet: isJoined value being sent to JSP is: " + isJoined);

request.setAttribute("isJoined", isJoined);
                
                // 2. Set the result as an attribute for the JSP
                request.setAttribute("activity", activity);
                request.setAttribute("isJoined", isJoined); 
                // --- NEW LOGIC END ---
                
                request.getRequestDispatcher("activityDetails.jsp").forward(request, response);
            } else {
                response.sendRedirect("studentActivities");
            }
        } else {
            response.sendRedirect("studentActivities");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("studentActivities");
    }
}
    }
