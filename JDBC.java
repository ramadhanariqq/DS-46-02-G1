/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author umaml
 */
package classes;

import java.sql.*;

public class JDBC {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/movies_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";

    public Connection conn;
    public Statement stmt;
    public boolean isConnected;
    public String message;

    public JDBC() {
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            stmt = conn.createStatement();
            isConnected = true;
            message = "Connected to the database successfully.";
        } catch (ClassNotFoundException | SQLException e) {
            isConnected = false;
            message = "Error connecting to the database: " + e.getMessage();
        }
    }

    public int runQuery(String query) {
        try {
            return stmt.executeUpdate(query);
        } catch (SQLException e) {
            System.out.println("Error executing query: " + e.getMessage());
            return -1;
        }
    }

    public ResultSet getData(String query) {
        try {
            return stmt.executeQuery(query);
        } catch (SQLException e) {
            System.out.println("Error fetching data: " + e.getMessage());
            return null;
        }
    }

    public void disconnect() {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
            message = "Disconnected from the database.";
        } catch (SQLException e) {
            message = "Error disconnecting from the database: " + e.getMessage();
        }
    }
}
