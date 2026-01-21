package com.uniclubs.model;
import java.sql.Timestamp;
import java.io.Serializable;


public class Activity implements Serializable {
    
    private static final long serialVersionUID = 1L;
    private int id;
    private String name;
    private String date;
    private String time;
    private String venue;
    private String clubName;
    private String createdBy;
private Timestamp createdAt;
private String status;
private double points;


    // Empty constructor
    public Activity() {}

    // Constructor without ID (for insert)
    public Activity(String name, String date, String time, String venue, String clubName, String createdBy) {
        this.name = name;
        this.date = date;
        this.time = time;
        this.venue = venue;
        this.clubName = clubName;
        this.createdBy = createdBy;
    }

    // Constructor with ID (for retrieve)
    public Activity(int id, String name, String date, String time, String venue, String clubName, String createdBy, Timestamp createdAt) {
        this.id = id;
        this.name = name;
        this.date = date;
        this.time = time;
        this.venue = venue;
        this.clubName = clubName;
            this.createdBy = createdBy;
    this.createdAt = createdAt;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getTime() { return time; }
    public void setTime(String time) { this.time = time; }

    public String getStatus() { return status; }
public void setStatus(String status) { this.status = status; }
public double getPoints() { return points; }
public void setPoints(double points) { this.points = points; }

    public String getVenue() { return venue; }
    public void setVenue(String venue) { this.venue = venue; }

    public String getClubName() { return clubName; }
    public void setClubName(String clubName) { this.clubName = clubName; }
    
    public String getCreatedBy() { return createdBy; }
public void setCreatedBy(String createdBy) { this.createdBy = createdBy; }

public Timestamp getCreatedAt() { return createdAt; }
public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

}
