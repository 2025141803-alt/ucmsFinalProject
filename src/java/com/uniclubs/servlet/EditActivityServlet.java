package com.uniclubs.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.uniclubs.model.Activity; // Fixes Activity red line
import com.uniclubs.dao.ActivityDAO;
import com.uniclubs.dao.NotificationsDAO;// Fixes ActivityDAO red line

@WebServlet("/EditActivityServlet")
public class EditActivityServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        ActivityDAO dao = new ActivityDAO();
        
        // You need a method in DAO to get a SINGLE activity by ID
        Activity activity = dao.getActivityById(id);
        
        request.setAttribute("activity", activity);
        request.getRequestDispatcher("/editActivity.jsp").forward(request, response);
    }
}