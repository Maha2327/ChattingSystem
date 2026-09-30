package com.chat;

import java.sql.Connection;

public class DBTest {

    public static void main(String[] args) {

        Connection con = DBConnection.getConnection();

        if (con != null) {
            System.out.println("SUCCESS: Nimbus MySQL Connected!");
        } else {
            System.out.println("FAILED: Database Connection Failed!");
        }
    }
}