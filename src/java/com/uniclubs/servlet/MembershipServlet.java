package com.uniclubs.servlet;

import com.uniclubs.dao.MembershipDAO;
import com.uniclubs.model.Membership;
import com.uniclubs.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/MembershipServlet")
public class MembershipServlet extends HttpServlet {
    private MembershipDAO dao = new MembershipDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String action = request.getParameter("action");
        String clubIdStr = request.getParameter("clubId");
        
        if (clubIdStr == null || action == null) {
            response.sendRedirect("viewAllClubs");
            return;
        }

        int clubId = Integer.parseInt(clubIdStr);
        int studentId = user.getUserId();

        // --- JOIN LOGIC ---
        if ("join".equals(action)) {
            if (dao.isAlreadyMember(studentId, clubId)) {
                response.sendRedirect("viewClubDetail?clubId=" + clubId + "&error=already_member");
            } else {
                // IMPORTANT: You need to call your join method here
                if (dao.joinClub(studentId, clubId)) { 
                    refreshSession(session, studentId);
                    response.sendRedirect("MembershipServlet?status=joined");
                } else {
                    response.sendRedirect("viewClubDetail?clubId=" + clubId + "&error=failed");
                }
            }
        } 
        // --- LEAVE LOGIC (This was incorrectly inside the JOIN block before) ---
        else if ("leave".equals(action)) {
            if (dao.leaveClub(studentId, clubId)) {
                refreshSession(session, studentId);
                response.sendRedirect("MembershipServlet?status=left");
            } else {
                response.sendRedirect("MembershipServlet?error=not_found");
            }
        }
    }

    private void refreshSession(HttpSession session, int studentId) {
    List<Membership> updatedList = dao.getStudentMemberships(studentId);
    
    // DEBUG: Add this to see if the database is actually returning clubs
    System.out.println("DEBUG MEMBERSHIP: Student " + studentId + " has " + updatedList.size() + " clubs.");
    
    session.setAttribute("membershipList", updatedList);
}

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        List<Membership> updatedList = dao.getStudentMemberships(user.getUserId());
        session.setAttribute("membershipList", updatedList);
        request.getRequestDispatcher("membership.jsp").forward(request, response);
    }
}