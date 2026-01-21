package com.uniclubs.servlet;

import com.uniclubs.dao.UserDAO;
import com.uniclubs.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/IndexServlet")
public class IndexServlet extends HttpServlet {

    private UserDAO dao = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form inputs
        // Get form inputs
String userIdStr = request.getParameter("user_id");
int user_id;

try {
    user_id = Integer.parseInt(userIdStr);
} catch (NumberFormatException e) {
    response.sendRedirect("index.jsp?error=Invalid User ID");
    return; // stop servlet execution
}

String password = request.getParameter("password");
String role = request.getParameter("role");


        // Check login in DB
        User user = dao.checkLogin(user_id, password);

        if (user != null) {

   
    if (!user.getRole().equalsIgnoreCase(role)) {
        response.sendRedirect("index.jsp?error=Role is invalid!");
        return;
    }

  HttpSession session = request.getSession();

// Generic attributes
session.setAttribute("user_name", user.getName());
session.setAttribute("user_id", user.getUserId());
session.setAttribute("role", user.getRole());

// Only for students
if ("student".equalsIgnoreCase(user.getRole())) {
    session.setAttribute("student_faculty", user.getFaculty());
}

// Keep full object if you want
session.setAttribute("user", user);


    // Redirect based on role
    if ("student".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect("home");
} else if ("staff".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect("staffDashboard");
}
 else {
        response.sendRedirect("index.jsp");
    }
}
 else {
            
             response.sendRedirect("index.jsp?error=Wrong ID or Password");
        }
    }
}
