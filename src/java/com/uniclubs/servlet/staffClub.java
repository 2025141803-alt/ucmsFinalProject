package com.uniclubs.servlet;

import com.uniclubs.dao.ClubDAO;
import com.uniclubs.model.Club;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.InputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/manageClub")
@MultipartConfig(
        fileSizeThreshold = 1024*1024,  // 1MB
        maxFileSize = 5*1024*1024,      // 5MB
        maxRequestSize = 10*1024*1024   // 10MB
)
public class staffClub extends HttpServlet {

    private static final String UPLOAD_DIR = "club_logos";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ClubDAO dao = new ClubDAO();
       try {
        // This was likely red because it wasn't inside a try-catch
        List<Club> clubList = dao.getAllClubs(); 
        request.setAttribute("clubList", clubList);
        request.getRequestDispatcher("/manageClub.jsp").forward(request, response);
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
    }
}

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    // 1) Read form inputs
    String clubName = request.getParameter("clubName");
    String tagline = request.getParameter("tagline");
    String type = request.getParameter("type");
    String dateRegistered = request.getParameter("dateRegistered");
    String contactNumber = request.getParameter("contactNumber");
    String email = request.getParameter("email");
    String location = request.getParameter("location");

    // 2) Handle file upload physical saving
    Part logoPart = request.getPart("logo");
    String fileName = System.currentTimeMillis() + "_" + logoPart.getSubmittedFileName();
    String uploadPath = "C:/my_uploads/club_logos";

    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdirs();

    try (InputStream input = logoPart.getInputStream()) {
        Files.copy(input, new File(uploadDir, fileName).toPath());
    }

    // 3) Create ONE Club object and set values
    Club club = new Club(); 
    club.setClubName(clubName);
    club.setTagline(tagline);
    club.setType(type);
    club.setDateRegistered(dateRegistered);
    club.setContactNumber(contactNumber);
    club.setEmail(email);
    club.setLocation(location);
    
    // Set the path with the folder prefix for the DB
    String logoPath = "club_logos/" + fileName; 
    club.setLogoPath(logoPath);

    // 4) Save to DB
    ClubDAO dao = new ClubDAO();
    try {
        dao.createClub(club);
        
        // Optional: Notifications
        com.uniclubs.dao.NotificationsDAO notifDAO = new com.uniclubs.dao.NotificationsDAO();
        String msg = "New Club Added: " + clubName;
        notifDAO.addNotification("club", clubName, msg);
        
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        return;
    }

    // 5) Redirect back to manage page
    response.sendRedirect(request.getContextPath() + "/manageClub");
}
}
