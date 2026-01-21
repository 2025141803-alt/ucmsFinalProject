package com.uniclubs.servlet;

import com.uniclubs.dao.DashboardStaffDAO;
import com.uniclubs.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/viewMember")
public class ViewMemberServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Security Check
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"staff".equalsIgnoreCase(admin.getRole())) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            int studentId = Integer.parseInt(request.getParameter("id"));
            DashboardStaffDAO dao = new DashboardStaffDAO();
            User student = dao.getStudentDetails(studentId);

            if (student != null) {
                request.setAttribute("student", student);
                request.getRequestDispatcher("memberDetails.jsp").forward(request, response);
            } else {
                response.sendRedirect("staffDashboard?error=notfound");
            }
        } catch (Exception e) {
            response.sendRedirect("staffDashboard");
        }
    }
}