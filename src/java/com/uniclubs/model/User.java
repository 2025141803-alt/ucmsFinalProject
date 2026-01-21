package com.uniclubs.model;

import java.sql.Timestamp;

public class User {

    private int userId;          // DB auto-generated
    private String name;
    private String email;
    private String phone;
    private String password;
    private String faculty;
    private String role;
    private Timestamp createdAt;
    private String profilePic;

    // Empty constructor (REQUIRED)
    public User() {}

    // Constructor for SIGN UP
    public User(int userID, String name, String email, String phone,
                String password, String faculty, String role ) {
        this.userId = userID;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.faculty = faculty;
        this.role = role;
        
      
    }

    // Getters & Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFaculty() { return faculty; }
    public void setFaculty(String faculty) { this.faculty = faculty; }

    public String getRole() {
    return role;
}

public void setRole(String role) {
    this.role = role;
}
public String getProfilePic() {
        return profilePic;
    }
public void setProfilePic(String profilePic) {
        this.profilePic = profilePic;
    }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    private String joinDate;
    public String getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(String joinDate) {
        this.joinDate = joinDate;
    }
// }
}


