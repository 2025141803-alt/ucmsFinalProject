package com.uniclubs.servlet;

import com.uniclubs.dao.ClubDAO;
import com.uniclubs.dao.MembershipDAO; // Added Import
import com.uniclubs.model.Club;
import com.uniclubs.model.User; // Added Import
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // Added Import

@WebServlet("/viewClubDetail")
public class ViewClubDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("clubId");
        String contextPath = request.getContextPath();
        
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(contextPath + "/manageClub");
            return;
        }

        try {
            int clubId = Integer.parseInt(idStr);
            ClubDAO dao = new ClubDAO();
            Club club = dao.getClubById(clubId);

            if (club != null) {
                request.setAttribute("club", club);

                // --- START MEMBERSHIP CHECK ---
                HttpSession session = request.getSession();
                User user = (User) session.getAttribute("user");

                if (user != null) {
                    MembershipDAO memDao = new MembershipDAO();
                    // This calls your DAO to see if the record exists in the MEMBERSHIP table
                    boolean isMember = memDao.isAlreadyMember(user.getUserId(), clubId);
                    request.setAttribute("isMember", isMember);
                }
                // --- END MEMBERSHIP CHECK ---

                request.getRequestDispatcher("/viewClubDetail.jsp").forward(request, response);
            } else {
                response.sendRedirect(contextPath + "/manageClub?error=NotFound");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(contextPath + "/manageClub?error=InvalidID");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "DB Error");
        }
    }
}