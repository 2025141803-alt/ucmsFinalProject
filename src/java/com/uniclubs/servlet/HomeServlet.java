package com.uniclubs.servlet;

import com.uniclubs.dao.ClubDAO;
import com.uniclubs.dao.ActivityDAO; // Need to import this
import com.uniclubs.model.User;
import com.uniclubs.model.Club;     // Need to import your model
import com.uniclubs.model.Activity; // Need to import your model
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List; // Need to import List

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    // 1. Check session
    HttpSession session = request.getSession();
    User currentUser = (User) session.getAttribute("user");
    
    if (currentUser == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Initialize DAOs
    ClubDAO clubDao = new ClubDAO();
    ActivityDAO activityDao = new ActivityDAO(); 
    
    int userId = currentUser.getUserId();
    
    try {
        // --- ADD THIS PART FOR POINTS ---
        // Fetch the total points from the ATTENDANCE table
        double totalPoints = activityDao.getStudentTotalPoints(userId);
        request.setAttribute("userPoints", totalPoints);
        // ---------------------------------

        // 2. Fetch "Clubs to Join" (Total count)
        int totalClubs = clubDao.getTotalClubsCount();
        
        // 3. Fetch "Registered Clubs" count
        int registeredCount = clubDao.getRegisteredCount(userId);

        // 4. Fetch joined clubs list
        List<Club> registeredClubsList = clubDao.getStudentJoinedClubs(userId);

        // 5. Fetch activities
        List<Activity> activitiesList = activityDao.getUpcomingActivities(userId);

        // 6. Set attributes
        request.setAttribute("totalClubs", totalClubs);
        request.setAttribute("registeredClubs", registeredCount);
        request.setAttribute("registeredClubsList", registeredClubsList);
        request.setAttribute("activitiesList", activitiesList);

        // 7. Forward to homepage
        request.getRequestDispatcher("/homepage.jsp").forward(request, response);
        
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error.");
    }
}
}