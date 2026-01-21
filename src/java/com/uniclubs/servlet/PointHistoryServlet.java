package com.uniclubs.servlet;

import com.uniclubs.dao.ActivityDAO;
import com.uniclubs.model.Activity;
import com.uniclubs.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/viewPoints")
public class PointHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        ActivityDAO dao = new ActivityDAO();
        
        // 1. Get the Total Sum for the banner
        double total = dao.getStudentTotalPoints(user.getUserId());
        
        // 2. Get the List of activities where points were earned
        List<Activity> history = dao.getStudentPointHistory(user.getUserId());

        // 3. Set attributes for the JSP
        request.setAttribute("totalPoints", total);
        request.setAttribute("pointHistory", history);
        
        // 4. Forward to the new JSP page
        request.getRequestDispatcher("pointHistory.jsp").forward(request, response);
    }
}