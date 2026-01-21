package com.uniclubs.dao;

import com.uniclubs.dao.DBConnection;
import com.uniclubs.model.Membership;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.uniclubs.model.User;
import java.util.List;
import java.util.ArrayList;
import com.uniclubs.model.Activity; // Make sure this matches your package structure

public class DashboardStaffDAO {
    // Counts for the 3 boxes
    public int getCount(String tableName) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM " + tableName.toUpperCase();
        try (Connection conn = com.uniclubs.dao.DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return count;
    }

    // List for the table (Joining USERS and CLUBS)
    public List<Membership> getAllMembershipsForStaff() {
    List<Membership> list = new ArrayList<>();
    // CHANGE: Added m.STUDENT_ID to the SELECT
    String sql = "SELECT m.MEMBERSHIP_ID, m.STUDENT_ID, u.NAME as STUDENT_NAME, c.CLUB_NAME, m.JOIN_DATE, m.ROLE " +
                 "FROM MEMBERSHIP m " +
                 "JOIN USERS u ON m.STUDENT_ID = u.USER_ID " +
                 "JOIN CLUBS c ON m.CLUB_ID = c.CLUB_ID";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        while (rs.next()) {
            Membership m = new Membership();
            m.setMembershipId(rs.getInt("MEMBERSHIP_ID"));
            
            // ADD THIS LINE: This allows the "View" button to work!
            m.setStudentId(rs.getInt("STUDENT_ID")); 
            
            m.setStudentName(rs.getString("STUDENT_NAME"));
            m.setClubName(rs.getString("CLUB_NAME"));
            m.setJoinDate(rs.getString("JOIN_DATE"));
            m.setRole(rs.getString("ROLE")); 
            list.add(m);
        }
    } catch (SQLException e) { e.printStackTrace(); }
    return list;
}


    // 3. Delete a membership record (Action for the Delete button)
    public boolean deleteMembership(int membershipId) {
        String sql = "DELETE FROM MEMBERSHIP WHERE MEMBERSHIP_ID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, membershipId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        
    }
    
    public User getStudentDetails(int studentId) {
    User user = null;
    String sql = "SELECT u.*, m.JOIN_DATE FROM USERS u " +
                 "JOIN MEMBERSHIP m ON u.USER_ID = m.STUDENT_ID " +
                 "WHERE u.USER_ID = ?";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setInt(1, studentId);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            user = new User();
            user.setUserId(rs.getInt("USER_ID"));
            user.setName(rs.getString("NAME"));
            user.setEmail(rs.getString("EMAIL"));
            user.setFaculty(rs.getString("FACULTY"));
            user.setRole(rs.getString("ROLE"));
            user.setJoinDate(rs.getString("JOIN_DATE")); 
            user.setPhone(rs.getString("PHONE"));
            
            // 1. Get the filename from the DB
            String picFromDB = rs.getString("PROFILE_PIC");
            
            // 2. DEBUG: This will print in your NetBeans 'Output' window
            System.out.println("DEBUG: Profile Pic filename from DB is: " + picFromDB);
            
            // 3. Set it to the user object
            user.setProfilePic(picFromDB); 
        }
    } catch (Exception e) { 
        e.printStackTrace(); 
    }
    return user;
    }
    
    // Method to update student details from the Edit form
public boolean updateStudentDetails(int userId, String email, String phone, String faculty) {
    boolean success = false;
    // We update the USERS table based on the USER_ID
    String sql = "UPDATE USERS SET EMAIL = ?, PHONE = ?, FACULTY = ? WHERE USER_ID = ?";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, email);
        ps.setString(2, phone);
        ps.setString(3, faculty);
        ps.setInt(4, userId);

        int rowsAffected = ps.executeUpdate();
        success = (rowsAffected > 0);
        
        System.out.println("DEBUG: Update for User ID " + userId + (success ? " successful" : " failed"));

    } catch (SQLException e) {
        e.printStackTrace();
    }
    return success;
}

// --- ACTIVITY JOINING & ATTENDANCE FEATURES ---

// 1. For Student: Join an activity
public boolean registerForActivity(int studentId, int activityId) {
    // 1. Check if the student already joined
    String checkSql = "SELECT COUNT(*) FROM ACTIVITY_REGISTRATION WHERE ACTIVITY_ID = ? AND STUDENT_ID = ?";
    String insertSql = "INSERT INTO ACTIVITY_REGISTRATION (ACTIVITY_ID, STUDENT_ID, STATUS) VALUES (?, ?, 'PENDING')";
    
    try (Connection conn = DBConnection.getConnection()) {
        
        // First check for existing registration
        try (PreparedStatement psCheck = conn.prepareStatement(checkSql)) {
            psCheck.setInt(1, activityId);
            psCheck.setInt(2, studentId);
            ResultSet rs = psCheck.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return false; // Student already registered
            }
        }

        // If not registered, proceed with insertion
        try (PreparedStatement psInsert = conn.prepareStatement(insertSql)) {
            psInsert.setInt(1, activityId);
            psInsert.setInt(2, studentId);
            return psInsert.executeUpdate() > 0;
        }
        
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

// 2. For Staff: Retrieve all students who joined a specific activity
public List<User> getAttendeesByActivity(int activityId) {
    List<User> attendees = new ArrayList<>();
    // Replace USERS with your actual student table name if different
    String sql = "SELECT u.USER_ID, u.NAME, r.STATUS " +
                 "FROM ACTIVITY_REGISTRATION r " +
                 "JOIN USERS u ON r.STUDENT_ID = u.USER_ID " +
                 "WHERE r.ACTIVITY_ID = ?";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setInt(1, activityId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            User user = new User();
            user.setUserId(rs.getInt("USER_ID"));
            user.setName(rs.getString("NAME"));
            // We can temporarily store the status in a field or handle it in the JSP
            user.setRole(rs.getString("STATUS")); 
            attendees.add(user);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return attendees;
}

// 3. For Staff: Mark a student as PRESENT or ABSENT
public boolean updateAttendanceStatus(int activityId, int studentId, String status) {
    String sql = "UPDATE ACTIVITY_REGISTRATION SET STATUS = ? WHERE ACTIVITY_ID = ? AND STUDENT_ID = ?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, status);
        ps.setInt(2, activityId);
        ps.setInt(3, studentId);
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

// 4. For Student: View their own activity history (My Joined Activities)
public List<Membership> getStudentJoinedActivities(int studentId) {
    List<Membership> list = new ArrayList<>();
    
    // 1. We MUST add r.ACTIVITY_ID to the SELECT list
    // 2. We join on ACTIVITY_ID (not ID) to match your database
   // We change a.ACTIVITY_ID to a.ID
String sql = "SELECT r.ACTIVITY_ID, a.NAME, a.DATE, r.STATUS " + 
             "FROM ACTIVITY_REGISTRATION r " +
             "JOIN ACTIVITIES a ON r.ACTIVITY_ID = a.ID " + 
             "WHERE r.STUDENT_ID = ?";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setInt(1, studentId);
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            Membership m = new Membership();
            
            // This line works only because ACTIVITY_ID is now in the SQL string above
            m.setActivityId(rs.getInt("ACTIVITY_ID")); 
            
            m.setActivityName(rs.getString("NAME")); 
            m.setJoinDate(rs.getString("DATE"));
            m.setRole(rs.getString("STATUS")); 
            
            list.add(m);
        }
    } catch (Exception e) { 
        // This will show you exactly what's wrong in the NetBeans/GlassFish console
        e.printStackTrace(); 
    }
    return list;
}

public List<Activity> getAllActivities() {
    List<Activity> list = new ArrayList<>();
    String sql = "SELECT * FROM ACTIVITIES ORDER BY ACTIVITY_DATE DESC";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        while (rs.next()) {
            Activity a = new Activity();
            a.setId(rs.getInt("ACTIVITY_ID"));
            a.setName(rs.getString("ACTIVITY_NAME"));
            a.setDate(rs.getString("ACTIVITY_DATE"));
            a.setVenue(rs.getString("VENUE"));
            list.add(a);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}
}