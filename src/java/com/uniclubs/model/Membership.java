package com.uniclubs.model;

public class Membership {

    private int membershipId;
    private int studentId;
    private int clubId;
    private String joinDate;
    private String role;
    private String clubName;
private String logoPath;
private String studentName;
private String activityName;
private int activityId;// Added for Staff Dashboard// e.g. Member, Committee

    // JavaBean empty constructor
    public Membership() {}

    // Optional constructor
    public Membership(int membershipId, int studentId, int clubId, String joinDate, String role) {
        this.membershipId = membershipId;
        this.studentId = studentId;
        this.clubId = clubId;
        this.joinDate = joinDate;
        this.role = role;
    }

    public int getMembershipId() {
        return membershipId;
    }

    public void setMembershipId(int membershipId) {
        this.membershipId = membershipId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getActivityName() {
        return activityName;
    }
    public void setActivityName(String activityName) {
        this.activityName = activityName;
    }
    
    public int getClubId() {
        return clubId;
    }

    public void setClubId(int clubId) {
        this.clubId = clubId;
    }

    public String getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(String joinDate) {
        this.joinDate = joinDate;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
public String getStudentName() { return studentName; }
public void setStudentName(String studentName) { this.studentName = studentName; }
    public String getClubName() { return clubName; }
public void setClubName(String clubName) { this.clubName = clubName; }
public String getLogoPath() { return logoPath; }
public void setLogoPath(String logoPath) { this.logoPath = logoPath; }

public int getActivityId() {
    return activityId;
}
public void setActivityId(int activityId) {
    this.activityId = activityId;
}
    @Override
    public String toString() {
        return "Membership{" +
                "membershipId=" + membershipId +
                ", studentId=" + studentId +
                ", clubId=" + clubId +
                ", role='" + role + '\'' +
                '}';
    }
}
