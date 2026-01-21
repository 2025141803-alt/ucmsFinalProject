package com.uniclubs.servlet;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/getImage")
public class ImageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    String fileName = request.getParameter("name");
    System.out.println("SERVLET START: Received name = " + fileName);

    if (fileName == null || fileName.isEmpty()) {
        System.out.println("ERROR: Filename is empty!");
        return;
    }

    String baseDir = "C:/my_uploads/";
    File file = new File(baseDir, fileName);
    
    // This tells us the EXACT path the computer is looking at
    System.out.println("LOOKING FOR FILE AT: " + file.getAbsolutePath());

    if (file.exists()) {
        System.out.println("SUCCESS: File found!");
        String contentType = getServletContext().getMimeType(file.getName());
        response.setContentType(contentType != null ? contentType : "image/jpeg");
        
        try (FileInputStream in = new FileInputStream(file); 
             OutputStream out = response.getOutputStream()) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    } else {
        System.out.println("ERROR: File does NOT exist on the C: drive!");
    }
}
        }