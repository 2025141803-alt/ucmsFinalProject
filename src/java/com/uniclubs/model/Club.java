package com.uniclubs.model;

public class Club {

    private int clubId;
    private String clubName;
    private String tagline;
    private String type;
    private String dateRegistered; // store as String (yyyy-MM-dd) for simplicity
    private String contactNumber;
    private String email;
    private String location;
    private String logoPath;
    private int membershipCount;

    // Getters and Setters
    public int getClubId() { return clubId; }
    public void setClubId(int clubId) { this.clubId = clubId; }

    public String getClubName() { return clubName; }
    public void setClubName(String clubName) { this.clubName = clubName; }

    public String getTagline() { return tagline; }
    public void setTagline(String tagline) { this.tagline = tagline; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getDateRegistered() { return dateRegistered; }
    public void setDateRegistered(String dateRegistered) { this.dateRegistered = dateRegistered; }

    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getLogoPath() { return logoPath; }
    public void setLogoPath(String logoPath) { this.logoPath = logoPath; }
    public int getMembershipCount() { 
    return membershipCount; 
}

public void setMembershipCount(int membershipCount) { 
    this.membershipCount = membershipCount; 
}
}
