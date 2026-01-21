package com.uniclubs.dao;

import com.uniclubs.model.Activity;
import com.uniclubs.dao.DBConnection; // Ensure this import matches your project structure
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.List;
import java.util.ArrayList;
import com.uniclubs.model.ActivityRegistration; 
import com.uniclubs.model.User;// This fixes the red text
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ActivityDAO {

    // Helper method to get connection - standardized to use your DBConnection class
    private Connection getConnection() throws SQLException {
        return DBConnection.getConnection();
    }
    
   public List<Activity> getUpcomingActivities(int userId) {
    List<Activity> list = new ArrayList<>();
    
    // Using UPPER() makes the join case-insensitive
  // We remove the date filter to see if the future activities show up
// We use TRIM and UPPER to avoid spacing/case issues
// We cast the column to DATE to ensure the comparison works
// Temporary Debug Query: Just checks if the student is a member of ANY club
String sql = "SELECT A.* FROM ACTIVITIES A " +
             "JOIN CLUBS C ON 1=1 " + // This forces a match on clubs
             "JOIN MEMBERSHIP M ON C.CLUB_ID = M.CLUB_ID " +
             "WHERE M.STUDENT_ID = ?";

    try (Connection con = getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        
        ps.setInt(1, userId);
        
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Activity a = new Activity();
                // Remember to use ALL CAPS for column names as well
                a.setId(rs.getInt("ID"));
                a.setName(rs.getString("NAME"));
                a.setDate(rs.getString("DATE"));
                a.setTime(rs.getString("TIME"));
                a.setVenue(rs.getString("VENUE"));
                a.setClubName(rs.getString("CLUB_NAME"));
                list.add(a);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}

    // CREATE activity
    public void addActivity(Activity activity) {
        String sql = "INSERT INTO activities (name, date, time, venue, club_name, created_by) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, activity.getName());
            ps.setString(2, activity.getDate());
            ps.setString(3, activity.getTime());
            ps.setString(4, activity.getVenue());
            ps.setString(5, activity.getClubName());
            ps.setString(6, activity.getCreatedBy());

            ps.executeUpdate();
            System.out.println("DEBUG: Activity added successfully");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // READ activity by ID
    public Activity getActivityById(int id) {
        Activity activity = null;
        String sql = "SELECT * FROM ACTIVITIES WHERE ID = ?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    activity = new Activity();
                    activity.setId(rs.getInt("id"));
                    activity.setName(rs.getString("name"));
                    activity.setDate(rs.getString("date"));
                    activity.setTime(rs.getString("time"));
                    activity.setVenue(rs.getString("venue"));
                    activity.setClubName(rs.getString("club_name"));
                    activity.setCreatedBy(rs.getString("created_by"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return activity;
    }
public boolean isUserRegistered(int userId, int activityId) {
    // Standardizing to the table name used in your earlier SQL logs
    String sql = "SELECT COUNT(*) FROM ACTIVITY_REGISTRATION WHERE STUDENT_ID = ? AND ACTIVITY_ID = ?";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setInt(1, userId);
        ps.setInt(2, activityId);
        
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                int count = rs.getInt(1);
                // This will show in your NetBeans Output window
                System.out.println("DEBUG DAO: Student " + userId + " - Activity " + activityId + " - Count: " + count);
                return count > 0;
            }
        }
    } catch (Exception e) { 
        e.printStackTrace();
    }
    return false; 
}
    // READ all activities
 // Inside ActivityDAO.java
public List<Activity> getAllActivities() {
    List<Activity> list = new ArrayList<>();
    // Match the table name 'ACTIVITIES' from your database
    String sql = "SELECT * FROM ACTIVITIES ORDER BY DATE DESC"; 
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        while (rs.next()) {
            Activity a = new Activity();
            // Match column names from your schema: ID, NAME, DATE, etc.
            a.setId(rs.getInt("ID")); 
            a.setName(rs.getString("NAME"));
            a.setDate(rs.getString("DATE"));
            a.setTime(rs.getString("TIME"));
            a.setVenue(rs.getString("VENUE"));
            a.setClubName(rs.getString("CLUB_NAME"));
            list.add(a);
        }
        System.out.println("DAO DEBUG: Fetched " + list.size() + " activities.");
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}
  
 public List<ActivityRegistration> getAllActivitySignups() {
    List<ActivityRegistration> list = new ArrayList<>();
    
    // Using user_id to match your database schema
    String sql = "SELECT r.ACTIVITY_ID, r.STUDENT_ID, a.NAME as ACTIVITY_NAME, u.NAME as STUDENT_NAME " +
                 "FROM ACTIVITY_REGISTRATION r " + 
                 "LEFT JOIN ACTIVITIES a ON r.ACTIVITY_ID = a.ID " +
                 "LEFT JOIN USERS u ON r.STUDENT_ID = u.user_id"; // <--- FIXED COLUMN NAME

    try (Connection conn = com.uniclubs.dao.DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        while (rs.next()) {
            ActivityRegistration reg = new ActivityRegistration();
            reg.setActivityId(rs.getInt("ACTIVITY_ID"));
            reg.setStudentId(rs.getInt("STUDENT_ID"));
            reg.setActivityName(rs.getString("ACTIVITY_NAME"));
            reg.setStudentName(rs.getString("STUDENT_NAME"));
            list.add(reg);
        }
        System.out.println("--- SUCCESS: DAO found " + list.size() + " signups ---");
    } catch (SQLException e) { 
        System.out.println("--- SQL ERROR: " + e.getMessage() + " ---");
        e.printStackTrace(); 
    }
    return list;
}

   

  // 1. Updated signature to accept 'double points' from the Servlet
public boolean recordAttendance(int studentId, int activityId, String status, double points) {
    // We use STATUS because that is the column in your registration table
    String updateRegSql = "UPDATE ACTIVITY_REGISTRATION SET STATUS = ? WHERE STUDENT_ID = ? AND ACTIVITY_ID = ?";
    String updatePointsSql = "UPDATE USERS SET points = points + ? WHERE user_id = ?";

    try (Connection conn = com.uniclubs.dao.DBConnection.getConnection()) {
        conn.setAutoCommit(false); 

        try (PreparedStatement psReg = conn.prepareStatement(updateRegSql)) {
            psReg.setString(1, status); // "PRESENT" or "ABSENT"
            psReg.setInt(2, studentId);
            psReg.setInt(3, activityId);
            psReg.executeUpdate();
        }
        
        // ... points update logic ...
        conn.commit();
        return true;
    } catch (SQLException e) { e.printStackTrace(); return false; }
}
    // DELETE activity
    public void deleteActivity(int id) {
        String sql = "DELETE FROM activities WHERE id = ?";

        try (Connection con = getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<Activity> getStudentPointHistory(int studentId) {
    List<Activity> history = new ArrayList<>();
    // Join ATTENDANCE with ACTIVITIES to get the Name
    String sql = "SELECT A.NAME, ATT.STATUS, ATT.POINTS_EARNED " +
                 "FROM ATTENDANCE ATT " +
                 "JOIN ACTIVITIES A ON ATT.ACTIVITY_ID = A.ID " +
                 "WHERE ATT.STUDENT_ID = ? AND ATT.POINTS_EARNED > 0"; // Only show records with points

    try (Connection conn = com.uniclubs.dao.DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setInt(1, studentId);
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            Activity a = new Activity();
            a.setName(rs.getString("NAME"));
            a.setStatus(rs.getString("STATUS"));
            a.setPoints(rs.getDouble("POINTS_EARNED"));
            history.add(a);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return history;
}
    
    public boolean updateAttendanceStatus(int activityId, int studentId, String status) {
    // We match the registration by both Activity and Student ID
    String sql = "UPDATE ACTIVITY_REGISTRATION SET ATTENDANCE_STATUS = ? " +
                 "WHERE ACTIVITY_ID = ? AND STUDENT_ID = ?";
    
    try (Connection conn = com.uniclubs.dao.DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setString(1, status);
        ps.setInt(2, activityId);
        ps.setInt(3, studentId);
        
        int rowsUpdated = ps.executeUpdate();
        return rowsUpdated > 0;
        
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
    
    public boolean updateAttendanceAndPoints(int studentId, int activityId, String status) {
    Connection conn = null;
    try {
        conn = com.uniclubs.dao.DBConnection.getConnection();
        conn.setAutoCommit(false); // Start transaction to ensure both updates happen together

        // 1. Insert or Update the attendance record
        String sqlAttendance = "INSERT INTO attendance (student_id, activity_id, status) VALUES (?, ?, ?) " +
                               "ON DUPLICATE KEY UPDATE status = ?";
        PreparedStatement ps1 = conn.prepareStatement(sqlAttendance);
        ps1.setInt(1, studentId);
        ps1.setInt(2, activityId);
        ps1.setString(3, status);
        ps1.setString(4, status);
        ps1.executeUpdate();

        // 2. Only award points if status is PRESENT
        if ("PRESENT".equalsIgnoreCase(status)) {
            String sqlPoints = "UPDATE users SET total_points = total_points + 5.0 WHERE userId = ?";
            PreparedStatement ps2 = conn.prepareStatement(sqlPoints);
            ps2.setInt(1, studentId);
            ps2.executeUpdate();
        }

        conn.commit(); // Save changes
        return true;
    } catch (SQLException e) {
        if (conn != null) try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
        e.printStackTrace();
        return false;
    }
}
    public List<User> getStudentsByActivity(int activityId) {
    List<User> students = new ArrayList<>();
    String sql = "SELECT u.userId, u.name FROM users u " +
                 "JOIN activity_registrations r ON u.userId = r.student_id " +
                 "WHERE r.activity_id = ?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, activityId);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userId"));
                user.setName(rs.getString("name"));
                students.add(user);
            }
        }
    } catch (SQLException e) { e.printStackTrace(); }
    return students;
}
    public void updateActivity(Activity activity) {
    String sql = "UPDATE ACTIVITIES SET NAME=?, DATE=?, TIME=?, VENUE=?, CLUB_NAME=? WHERE ID=?";

    try (Connection con = getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, activity.getName());
        ps.setString(2, activity.getDate());
        ps.setString(3, activity.getTime());
        ps.setString(4, activity.getVenue());
        ps.setString(5, activity.getClubName());
        ps.setInt(6, activity.getId());

        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
       public double getStudentTotalPoints(int studentId) {
    double totalPoints = 0.0;
    // This query sums up all points from the ATTENDANCE table for a specific student
    String sql = "SELECT SUM(POINTS_EARNED) AS TOTAL_POINTS FROM ATTENDANCE WHERE STUDENT_ID = ?";

    try (Connection conn = com.uniclubs.dao.DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setInt(1, studentId);
        
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                totalPoints = rs.getDouble("TOTAL_POINTS");
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return totalPoints;
}
    }
