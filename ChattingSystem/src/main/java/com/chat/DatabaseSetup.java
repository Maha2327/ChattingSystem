package com.chat;

import java.sql.Connection;
import java.sql.Statement;

public class DatabaseSetup {

    public static void main(String[] args) {

        String sql = "CREATE TABLE IF NOT EXISTS messages ("
                + "id INT PRIMARY KEY AUTO_INCREMENT,"
                + "sender VARCHAR(100) NOT NULL,"
                + "receiver VARCHAR(100) NOT NULL,"
                + "message TEXT NOT NULL,"
                + "sent_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
                + ")";

        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement()) {

            stmt.executeUpdate(sql);

            System.out.println("Messages table created successfully!");

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}