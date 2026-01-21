package com.uniclubs.model;

import java.sql.Timestamp;

public class Notifications {
    private int id;
    private String type;     // 'club' or 'activity'
    private String clubName; // The name of the club responsible
    private String message;  // The specific change details
    private String timeAgo;  // e.g., "2 hours ago"
    private Timestamp createdAt;
    // Getters and Setters
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    
    public String getClubName() { return clubName; }
    public void setClubName(String clubName) { this.clubName = clubName; }
    
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    
    public String getTimeAgo() { return timeAgo; }
    public void setTimeAgo(String timeAgo) { this.timeAgo = timeAgo; }
    
    public Timestamp getCreatedAt() {
    return createdAt;
}

public void setCreatedAt(Timestamp createdAt) {
    this.createdAt = createdAt;
}
}