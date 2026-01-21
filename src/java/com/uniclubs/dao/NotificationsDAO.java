package com.uniclubs.dao;

import com.uniclubs.model.Notifications;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationsDAO {

    // 1. USE YOUR EXISTING CONNECTION LOGIC
    private Connection getConnection() throws Exception {
        // Since your ClubDAO uses DBConnection.getConnection(), use it here too!
        return DBConnection.getConnection(); 
    }

    public List<Notifications> getAllNotifications() {
        List<Notifications> list = new ArrayList<>();
        // In Derby, table names are usually case-sensitive or uppercase by default
        String query = "SELECT TYPE, CLUB_NAME, MESSAGE, CREATED_AT FROM NOTIFICATIONS ORDER BY CREATED_AT DESC";
        
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Notifications n = new Notifications();
                n.setType(rs.getString("TYPE"));
                n.setClubName(rs.getString("CLUB_NAME"));
                n.setMessage(rs.getString("MESSAGE"));
                Timestamp ts = rs.getTimestamp("CREATED_AT"); 
    n.setCreatedAt(ts);
                list.add(n);
            }
        } catch (Exception e) { 
            System.out.println("Error fetching notifications: " + e.getMessage());
            e.printStackTrace(); 
        }
        return list;
    }

    public void addNotification(String type, String clubName, String message) {
        // 2. CHANGE 'NOW()' TO 'CURRENT_TIMESTAMP' FOR DERBY
        String query = "INSERT INTO NOTIFICATIONS (TYPE, CLUB_NAME, MESSAGE, CREATED_AT) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
        
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, type);
            ps.setString(2, clubName);
            ps.setString(3, message);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error adding notification: " + e.getMessage());
            e.printStackTrace();
        }
    }
}