package com.uniclubs.servlet;

import com.uniclubs.dao.ClubDAO;
import com.uniclubs.model.Club;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/viewAllClubs")
public class StudentClubServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ClubDAO dao = new ClubDAO();
        
        try {
            // 1. Fetch all clubs from the database using your DAO
            List<Club> clubs = dao.getAllClubs();
            
            // 2. Set the attribute using your new name "studentClub"
            request.setAttribute("studentClub", clubs);
            
            // 3. Forward the request to your JSP page
            request.getRequestDispatcher("view-all-clubs.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error retrieving clubs.");
        }
    }
}