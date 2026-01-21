package com.uniclubs.servlet;

import com.uniclubs.dao.DashboardStaffDAO;
import com.uniclubs.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/editMember")
public class EditMemberServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int studentId = Integer.parseInt(request.getParameter("id"));
            DashboardStaffDAO dao = new DashboardStaffDAO();
            User student = dao.getStudentDetails(studentId);

            if (student != null) {
                request.setAttribute("student", student);
                // This forwards to a NEW JSP that contains a <form>
                request.getRequestDispatcher("editMemberForm.jsp").forward(request, response);
            } else {
                response.sendRedirect("staffDashboard?error=notfound");
            }
        } catch (Exception e) {
            response.sendRedirect("staffDashboard");
        }
    }
}