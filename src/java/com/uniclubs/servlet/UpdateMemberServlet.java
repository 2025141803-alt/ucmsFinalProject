package com.uniclubs.servlet;

import com.uniclubs.dao.DashboardStaffDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateMember")
public class UpdateMemberServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Retrieve data from the form fields (matching the 'name' attributes)
        String idStr = request.getParameter("userId");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String faculty = request.getParameter("faculty");

        try {
            int userId = Integer.parseInt(idStr);
            DashboardStaffDAO dao = new DashboardStaffDAO();

            // 2. Call the DAO to update the database
            boolean isUpdated = dao.updateStudentDetails(userId, email, phone, faculty);

            if (isUpdated) {
                // 3. Success: Redirect back to the VIEW page to see updated info
                response.sendRedirect("viewMember?id=" + userId + "&status=updated");
            } else {
                // Failure: Redirect back with an error message
                response.sendRedirect("viewMember?id=" + userId + "&status=error");
            }
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("staffDashboard?error=invalidId");
        }
    }
}