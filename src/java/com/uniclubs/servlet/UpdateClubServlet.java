package com.uniclubs.servlet;

import com.uniclubs.dao.ClubDAO;
import com.uniclubs.model.Club;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/UpdateClubServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class UpdateClubServlet extends HttpServlet {

   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    ClubDAO dao = new ClubDAO();
    
    try {
        // 1. Safe ID Extraction
        String idStr = request.getParameter("clubId");
        if (idStr == null || idStr.isEmpty()) {
            throw new ServletException("Club ID is missing from the request.");
        }
        int id = Integer.parseInt(idStr);

        // 2. Fetch Existing Data (to keep the old logo if no new one is uploaded)
        Club existingClub = dao.getClubById(id);
        if (existingClub == null) {
            throw new ServletException("Club not found in database.");
        }
        String logoPath = existingClub.getLogoPath(); 

        // 3. Handle Logo Upload Logic
        Part filePart = request.getPart("logo");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            String uploadPath = "C:/my_uploads/club_logos";
            
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs(); // Using mkdirs() for safety

            File fileToSave = new File(uploadDir, fileName);
            
            try (java.io.InputStream input = filePart.getInputStream()) {
        java.nio.file.Files.copy(input, fileToSave.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
    }
            logoPath = "club_logos/" + fileName; 
        }

        // 4. Update the Club object
        Club club = new Club();
        club.setClubId(id);
        club.setClubName(request.getParameter("clubName"));
        club.setTagline(request.getParameter("tagline"));
        club.setType(request.getParameter("type"));
        club.setContactNumber(request.getParameter("contactNumber"));
        club.setEmail(request.getParameter("email"));
        club.setLocation(request.getParameter("location"));
        club.setDateRegistered(request.getParameter("dateRegistered"));
        club.setLogoPath(logoPath);

        // 5. Database Update
        boolean success = dao.updateClub(club);

        if (success) {
            // FIX: Always include the Context Path in redirects
            response.sendRedirect(request.getContextPath() + "/manageClub"); 
        } else {
            response.getWriter().println("Update failed: No changes saved in DB.");
        }

    } catch (Exception e) {
        e.printStackTrace(); // This prints the error to the GlassFish log (red text)
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server Error: " + e.getMessage());
    }
}
}