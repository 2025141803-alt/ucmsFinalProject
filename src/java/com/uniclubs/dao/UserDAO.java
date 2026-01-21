package com.uniclubs.dao;

import com.uniclubs.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    // LOGIN
    public User checkLogin(int user_id, String password) {

        User user = null;

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE user_id = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, user_id);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
user.setUserId(rs.getInt("user_id"));
user.setName(rs.getString("name"));
user.setEmail(rs.getString("email"));
user.setPhone(rs.getString("phone"));
user.setPassword(rs.getString("password"));
user.setFaculty(rs.getString("faculty"));
user.setRole(rs.getString("role"));   
user.setProfilePic(rs.getString("profile_pic"));


           
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    // SIGN UP
public boolean registerUser(User user) {
    boolean success = false;
    try {
        Connection conn = DBConnection.getConnection();
        System.out.println("Connected to DB");

        String sql = "INSERT INTO users (user_id, name, email, phone, password, faculty, role, profile_pic) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, user.getUserId());
ps.setString(2, user.getName());
ps.setString(3, user.getEmail());
ps.setString(4, user.getPhone());
ps.setString(5, user.getPassword());
ps.setString(6, user.getFaculty());
ps.setString(7, user.getRole());   
ps.setString(8, "my_uploads/profile_picture/default.png");



        int rows = ps.executeUpdate();
        System.out.println("Rows affected: " + rows);

        success = rows > 0;

        ps.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace(); // check console
    }
    return success;
}

public boolean updateUser(User user) {
    boolean success = false;
    try {
        Connection conn = DBConnection.getConnection();
        // 1. ADD profile_pic=? TO THE SQL STRING
        String sql = "UPDATE users SET name=?, email=?, phone=?, faculty=?, profile_pic=? WHERE user_id=?";
        
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, user.getName());
        ps.setString(2, user.getEmail());
        ps.setString(3, user.getPhone());
        ps.setString(4, user.getFaculty());
        
        // 2. ADD THIS LINE FOR THE PICTURE PATH
        ps.setString(5, user.getProfilePic()); 
        
        // 3. UPDATE THE INDEX FOR USER_ID TO 6
        ps.setInt(6, user.getUserId());

        success = ps.executeUpdate() > 0;
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return success;
}
}
