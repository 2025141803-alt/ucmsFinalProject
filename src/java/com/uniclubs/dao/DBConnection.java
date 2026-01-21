package com.uniclubs.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBConnection {

    private static final String URL = "jdbc:derby://localhost:1527/ucmsDB";
    private static final String USER = "app";
    private static final String PASSWORD = "app";

    // Get DB connection
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    // Get user's name by user ID
public static String getUserName(int userId) {
    String userName = "";
    String sql = "SELECT NAME FROM USERS WHERE USER_ID = ?";

    try (
        Connection conn = getConnection();
        PreparedStatement ps = conn.prepareStatement(sql)
    ) {
        ps.setInt(1, userId);  

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                userName = rs.getString("NAME");
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return userName;
}

}
