package com.uniclubs.dao;

import com.uniclubs.model.Membership;
import com.uniclubs.dao.DBConnection; // Ensure this matches your DB connection class
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MembershipDAO {

    // 1. Get all memberships for a specific student (with Club Details)
  public List<Membership> getStudentMemberships(int studentId) {
    List<Membership> list = new ArrayList<>();
    // Adjusted to common Derby naming (CLUB_NAME instead of CLUBNAME)
    String sql = "SELECT M.*, C.CLUB_NAME, C.LOGO_PATH FROM MEMBERSHIP M " +
                 "JOIN CLUBS C ON M.CLUB_ID = C.CLUB_ID " +
                 "WHERE M.STUDENT_ID = ?";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, studentId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Membership m = new Membership();
            
            m.setMembershipId(rs.getInt("MEMBERSHIP_ID"));
            m.setStudentId(rs.getInt("STUDENT_ID"));
            m.setClubId(rs.getInt("CLUB_ID"));
            m.setJoinDate(rs.getString("JOIN_DATE"));
            m.setRole(rs.getString("ROLE"));
            
            // Match these to your CLUBS table columns!
            m.setClubName(rs.getString("CLUB_NAME")); 
            m.setLogoPath(rs.getString("LOGO_PATH"));
            
            list.add(m);
        }
    } catch (SQLException e) {
        System.out.println("SQL ERROR: " + e.getMessage());
        e.printStackTrace();
    }
    return list;
}

    // 2. Add new membership (Join Club)
    public boolean joinClub(int studentId, int clubId) {
        // First check if already a member
        if (isAlreadyMember(studentId, clubId)) return false;

        String sql = "INSERT INTO membership (student_id, club_id, join_date, role) VALUES (?, ?, CURRENT_DATE, 'Member')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.setInt(2, clubId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // 3. Remove membership (Leave Club)
    // Inside MembershipDAO.java
public boolean leaveClub(int studentId, int clubId) {
    // Matches your screenshot: TABLE = MEMBERSHIP, COLUMNS = STUDENT_ID, CLUB_ID
    String sql = "DELETE FROM MEMBERSHIP WHERE STUDENT_ID = ? AND CLUB_ID = ?";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setInt(1, studentId);
        ps.setInt(2, clubId);
        
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
        
    } catch (SQLException e) {
        System.out.println("DELETE ERROR: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
}

    // Helper: Check for duplicates
    public boolean isAlreadyMember(int studentId, int clubId) {
    String sql = "SELECT 1 FROM MEMBERSHIP WHERE STUDENT_ID = ? AND CLUB_ID = ?";
    try (java.sql.Connection conn = com.uniclubs.dao.DBConnection.getConnection();
         java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, studentId);
        ps.setInt(2, clubId);
        try (java.sql.ResultSet rs = ps.executeQuery()) {
            return rs.next(); // Returns true if a record exists
        }
    } catch (java.sql.SQLException e) {
        e.printStackTrace();
        return false;
    }
}
}