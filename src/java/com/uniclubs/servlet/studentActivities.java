package com.uniclubs.servlet;
import com.uniclubs.model.User;

import com.uniclubs.dao.ActivityDAO;
import com.uniclubs.model.Activity;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.WebServlet;

import java.util.ArrayList;
import java.util.List;

import java.io.IOException;
import java.util.List;

@WebServlet("/studentActivities")
public class studentActivities extends HttpServlet {

    private ActivityDAO activityDAO;

    @Override
    public void init() {
        activityDAO = new ActivityDAO();
    }

   @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    HttpSession session = request.getSession(false);
    User user = (session != null) ? (User) session.getAttribute("user") : null;
    
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Use the variable initialized in init() or create one fresh
    List<Activity> activities = activityDAO.getAllActivities(); 

    
    request.setAttribute("activities", activities);
    
    request.getRequestDispatcher("activities.jsp").forward(request, response);
}
}