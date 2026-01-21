package com.uniclubs.servlet;

import com.uniclubs.dao.UserDAO;
import com.uniclubs.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.MultipartConfig; // Required for file uploads
import javax.servlet.http.Part; // Required to handle the image file
import java.io.File; // Required to save the file to your folder

@WebServlet("/UserServlet")
@MultipartConfig(maxFileSize = 16177215)
public class UserServlet extends HttpServlet {

    private UserDAO dao = new UserDAO();

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String action = request.getParameter("action");

    
    if (action == null) {
        action = "signup";
    }

if ("signup".equals(action)) {

    String role = request.getParameter("role");

    User user = new User();

    if ("student".equals(role)) {

        int user_id = Integer.parseInt(request.getParameter("student_id"));
        String name = request.getParameter("student_name");
        String email = request.getParameter("student_email");
        String phone = request.getParameter("student_phone");
       String password = request.getParameter("student_password");

  String faculty = request.getParameter("student_faculty");




      

        user.setUserId(user_id);
        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(password);
        user.setFaculty(faculty);
        user.setRole("student");

    } else if ("staff".equals(role)) {

        int user_id = Integer.parseInt(request.getParameter("staff_id"));
        String name = request.getParameter("staff_name");
        String email = request.getParameter("staff_email");
 String password = request.getParameter("staff_password");



        user.setUserId(user_id);
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole("staff");
         user.setPhone("");      // staff has no phone
    user.setFaculty("");
       
    }

    // BASIC VALIDATION
if (user.getName() == null || user.getName().isEmpty()) {
    response.sendRedirect("signup.jsp?msg=name_error");
    return;
}

if (user.getEmail() == null || user.getEmail().isEmpty()) {
    response.sendRedirect("signup.jsp?msg=email_error");
    return;
}

if (user.getPassword() == null || user.getPassword().length() < 6) {
    response.sendRedirect("signup.jsp?msg=password_error");
    return;
}
// ===== VALIDATION =====

// Validate User ID (10 digits)
String userIdStr = String.valueOf(user.getUserId());
if (!userIdStr.matches("\\d{10}")) {
    response.sendRedirect("signup.jsp?msg=id_error");
    return;
}

// Validate Name (letters and spaces only)
if (!user.getName().matches("[a-zA-Z ]+")) {
    response.sendRedirect("signup.jsp?msg=name_format_error");
    return;
}

// REGISTER USER
if (dao.registerUser(user)) {
    response.sendRedirect("index.jsp?msg=signup_success");
} else {
    response.sendRedirect("signup.jsp?msg=duplicate");
}


} else if ("index".equals(action)) {

    int user_id = Integer.parseInt(request.getParameter("user_id"));
    String password = request.getParameter("password");
    String role = request.getParameter("role");

    User user = dao.checkLogin(user_id, password);

    if (user != null) {
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        response.sendRedirect("homepage.jsp");
    } else {
        response.sendRedirect("index.jsp?msg=invalid");
    }


} else if ("updateProfile".equals(action)) {
    try {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        Part filePart = request.getPart("profilePic");
        String fileName = (filePart != null) ? filePart.getSubmittedFileName() : null;
        
        // Start with the existing picture path (so it doesn't turn null)
        String savePath = currentUser.getProfilePic(); 

        if (fileName != null && !fileName.isEmpty()) {
            // 1. Setup the physical location
            String folderPath = "C:/my_uploads/profile_picture/";
            String uniqueFileName = currentUser.getUserId() + "_" + fileName;
            
            File uploadDir = new File(folderPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            File destinationFile = new File(uploadDir, uniqueFileName);

            // 2. MANUAL STREAM (This fixes the GlassFish 'Double Path' error)
            try (java.io.InputStream is = filePart.getInputStream();
                 java.io.FileOutputStream os = new java.io.FileOutputStream(destinationFile)) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = is.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }
            }
            
            // 3. Set the path for the Database (Matches GlassFish bridge)
            savePath = "profile_picture/" + uniqueFileName;
        }

        // --- 2. MAP FORM DATA TO OBJECT ---
        User updatedUser = new User();
        // ID is grabbed from the hidden field
        updatedUser.setUserId(Integer.parseInt(request.getParameter("user_id")));
        updatedUser.setName(request.getParameter("name"));
        updatedUser.setEmail(request.getParameter("email"));
        updatedUser.setPhone(request.getParameter("phone"));
        updatedUser.setProfilePic(savePath); // Save the path to the database

        // --- 3. SECURE DATA (LOCKED FIELDS) ---
        // We pull these from the Session (currentUser) to ensure they CANNOT be edited
        updatedUser.setRole(currentUser.getRole());       // Locked
        updatedUser.setFaculty(currentUser.getFaculty()); // Locked
        updatedUser.setPassword(currentUser.getPassword()); // Locked

        // --- 4. DATABASE & SESSION UPDATE ---
        if (dao.updateUser(updatedUser)) {
            // This line refreshes the session so your Sidebar shows the new info immediately
            session.setAttribute("user", updatedUser);
            response.sendRedirect("myProfile.jsp?status=success");
        } else {
            response.sendRedirect("myProfile.jsp?status=error");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("myProfile.jsp?status=error");
    }
}
}
}


