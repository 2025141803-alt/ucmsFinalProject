package com.uniclubs.servlet;

import com.uniclubs.dao.ClubDAO;
import com.uniclubs.model.Club;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditClubServlet") // This must match the href in your manageClubs.jsp
public class EditClubServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get the ID from the URL (e.g., EditClub?id=12)
        String idStr = request.getParameter("id");
        
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                ClubDAO dao = new ClubDAO();
                
                // 2. Fetch the club data from the Database
                Club club = dao.getClubById(id);
                
                if (club != null) {
                    // 3. Place the club object in the request to be used by the JSP
                    request.setAttribute("club", club);
                    
                    // 4. Forward the user to the edit page
                    request.getRequestDispatcher("editClub.jsp").forward(request, response);
                } else {
                    // If club doesn't exist, go back to list
                    response.sendRedirect("manageClub");
                }
                
            } catch (SQLException | NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("manageClub");
            }
        } else {
            response.sendRedirect("manageClub");
        }
    }
}