package com.uniclubs.servlet;

import com.uniclubs.dao.DashboardStaffDAO;
import com.uniclubs.model.Membership;
import com.uniclubs.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/myJoinedActivities")
public class MyJoinedActivitiesServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");

    if (user != null) {
        int studentId = user.getUserId();

        // --- PASTE IT HERE ---
        System.out.println("DEBUG: Fetching activities for Student ID: " + studentId);
        // ---------------------

        DashboardStaffDAO dao = new DashboardStaffDAO();
        List<Membership> joinedList = dao.getStudentJoinedActivities(studentId);
        
        // Another good debug line to see if the list is empty
        System.out.println("DEBUG: List size returned from DAO: " + joinedList.size());

        request.setAttribute("joinedList", joinedList);
        request.getRequestDispatcher("myJoinedActivities.jsp").forward(request, response);
    } else {
        response.sendRedirect("index.jsp");
    }}}
