package com.chat;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/GetMessagesServlet")
public class GetMessagesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        String username = (String) session.getAttribute("username");
        String otherUser = request.getParameter("otherUser");

        PrintWriter out = response.getWriter();

        if (username == null || otherUser == null
                || otherUser.trim().isEmpty()) {

            out.print("[]");
            return;
        }

        String sql = "SELECT sender, receiver, message, sent_time "
                + "FROM messages "
                + "WHERE (sender = ? AND receiver = ?) "
                + "OR (sender = ? AND receiver = ?) "
                + "ORDER BY sent_time ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, otherUser);

            ps.setString(3, otherUser);
            ps.setString(4, username);

            ResultSet rs = ps.executeQuery();

            StringBuilder json = new StringBuilder();

            json.append("[");

            boolean first = true;

            while (rs.next()) {

                if (!first) {
                    json.append(",");
                }

                json.append("{");

                json.append("\"sender\":\"")
                    .append(escapeJson(rs.getString("sender")))
                    .append("\",");

                json.append("\"receiver\":\"")
                    .append(escapeJson(rs.getString("receiver")))
                    .append("\",");

                json.append("\"message\":\"")
                    .append(escapeJson(rs.getString("message")))
                    .append("\",");

                json.append("\"sent_time\":\"")
                    .append(escapeJson(rs.getString("sent_time")))
                    .append("\"");

                json.append("}");

                first = false;
            }

            json.append("]");

            out.print(json.toString());

        } catch (Exception e) {

            e.printStackTrace();

            response.setStatus(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR
            );

            out.print("[]");
        }
    }

    private String escapeJson(String value) {

        if (value == null) {
            return "";
        }

        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }
}