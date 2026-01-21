package com.uniclubs.servlet;

import com.uniclubs.dao.DashboardDAO;
import com.uniclubs.model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        DashboardDAO dao = new DashboardDAO();

        int totalClubs = dao.getTotalClubs();
        int registeredClubs = dao.getRegisteredClubs(user.getUserId());

        request.setAttribute("totalClubs", totalClubs);
        request.setAttribute("registeredClubs", registeredClubs);

        request.getRequestDispatcher("homepage.jsp").forward(request, response);
    }
}
