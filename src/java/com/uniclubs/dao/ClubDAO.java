package com.uniclubs.dao;

import com.uniclubs.model.Club;
import com.uniclubs.model.Activity;
import com.uniclubs.dao.DBConnection; // Ensure this matches your package structure
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClubDAO {

    // 1. CREATE a new club
    public void createClub(Club club) throws SQLException {
        String sql = "INSERT INTO CLUBS (CLUB_NAME, TAGLINE, TYPE, DATE_REGISTERED, CONTACT_NUMBER, EMAIL, LOCATION, LOGO_PATH) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, club.getClubName());
            ps.setString(2, club.getTagline());
            ps.setString(3, club.getType());
            ps.setDate(4, Date.valueOf(club.getDateRegistered())); 
            ps.setString(5, club.getContactNumber());
            ps.setString(6, club.getEmail());
            ps.setString(7, club.getLocation());
            ps.setString(8, club.getLogoPath());

            ps.executeUpdate();
        }
    }

    // 2. DELETE a club by ID
    public void deleteClub(int id) throws SQLException {
        String sql = "DELETE FROM CLUBS WHERE CLUB_ID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // 3. GET a single club by ID
    public Club getClubById(int id) throws SQLException {
        String sql = "SELECT * FROM CLUBS WHERE CLUB_ID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Club c = new Club();
                    c.setClubId(rs.getInt("CLUB_ID"));
                    c.setClubName(rs.getString("CLUB_NAME"));
                    c.setTagline(rs.getString("TAGLINE"));
                    c.setType(rs.getString("TYPE"));
                    c.setDateRegistered(rs.getDate("DATE_REGISTERED").toString());
                    c.setContactNumber(rs.getString("CONTACT_NUMBER"));
                    c.setEmail(rs.getString("EMAIL"));
                    c.setLocation(rs.getString("LOCATION"));
                    c.setLogoPath(rs.getString("LOGO_PATH"));
                    return c;
                }
            }
        }
        return null;
    }

    // 4. UPDATE club details
    public boolean updateClub(Club club) throws SQLException {
        String sql = "UPDATE CLUBS SET CLUB_NAME = ?, TAGLINE = ?, TYPE = ?, "
                   + "CONTACT_NUMBER = ?, EMAIL = ?, LOCATION = ?, "
                   + "DATE_REGISTERED = ?, LOGO_PATH = ? "
                   + "WHERE CLUB_ID = ?";
                   
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, club.getClubName());
            ps.setString(2, club.getTagline());
            ps.setString(3, club.getType());
            ps.setString(4, club.getContactNumber());
            ps.setString(5, club.getEmail());
            ps.setString(6, club.getLocation());
            ps.setDate(7, Date.valueOf(club.getDateRegistered())); 
            ps.setString(8, club.getLogoPath());
            ps.setInt(9, club.getClubId());
            
            return ps.executeUpdate() > 0;
        }
    }

    // 5. GET ALL clubs (for Administration list)
    public List<Club> getAllClubs() throws SQLException {
        List<Club> clubs = new ArrayList<>();
        String sql = "SELECT c.*, (SELECT COUNT(*) FROM membership m WHERE m.club_id = c.club_id) AS membership_count FROM CLUBS c";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Club c = new Club();
                c.setClubId(rs.getInt("CLUB_ID"));
                c.setClubName(rs.getString("CLUB_NAME"));
                c.setTagline(rs.getString("TAGLINE"));
                c.setType(rs.getString("TYPE"));
                c.setDateRegistered(rs.getDate("DATE_REGISTERED").toString());
                c.setContactNumber(rs.getString("CONTACT_NUMBER"));
                c.setEmail(rs.getString("EMAIL"));
                c.setLocation(rs.getString("LOCATION"));
                c.setLogoPath(rs.getString("LOGO_PATH"));
                c.setMembershipCount(rs.getInt("membership_count"));
                clubs.add(c);
            }
        }
        return clubs;
    }

    // 6. COUNT ALL clubs (for Student Dashboard)
    public int getTotalClubsCount() throws SQLException {
        int count = 0;
        String sql = "SELECT COUNT(*) AS total FROM CLUBS";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) count = rs.getInt("total");
        }
        return count;
    }

    // 7. COUNT JOINED clubs (for Student Dashboard)
    public int getRegisteredCount(int userId) throws SQLException {
    int count = 0;
    // We add a JOIN here so we only count memberships that have valid club data
    String sql = "SELECT COUNT(*) AS total FROM membership m " +
                 "JOIN clubs c ON m.club_id = c.club_id " +
                 "WHERE m.student_id = ?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, userId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) count = rs.getInt("total");
        }
    }
    return count;
}

    // 8. GET REGISTERED CLUBS LIST (for the Dashboard cards)
    public List<Club> getStudentJoinedClubs(int studentId) throws SQLException {
        List<Club> list = new ArrayList<>();
        String sql = "SELECT c.club_id, c.club_name, c.logo_path, " +
                     "(SELECT COUNT(*) FROM membership WHERE club_id = c.club_id) as member_count " +
                     "FROM clubs c " +
                     "JOIN membership m ON c.club_id = m.club_id " +
                     "WHERE m.student_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Club c = new Club();
                    c.setClubId(rs.getInt("club_id"));
                    c.setClubName(rs.getString("club_name"));
                    c.setLogoPath(rs.getString("logo_path"));
                    c.setMembershipCount(rs.getInt("member_count"));
                    list.add(c);
                }
            }
        }
        return list;
    }

    // 9. GET UPCOMING ACTIVITIES (Real Data for Dashboard sidebar)
    public List<Activity> getUpcomingActivities(int studentId) throws SQLException {
    List<Activity> list = new ArrayList<>();
    // Joins activities to clubs, then to memberships to filter by the specific student
    String sql = "SELECT a.name, a.date, c.club_name " +
                 "FROM activities a " +
                 "JOIN clubs c ON a.club_name = c.club_name " +
                 "JOIN membership m ON c.club_id = m.club_id " +
                 "WHERE m.student_id = ? AND a.date >= CURRENT_DATE " +
                 "ORDER BY a.date ASC";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setInt(1, studentId);
        
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Activity a = new Activity();
                a.setName(rs.getString("name"));
                a.setDate(rs.getString("date"));
                a.setClubName(rs.getString("club_name"));
                list.add(a);
            }
        }
    }
    return list;
}
}