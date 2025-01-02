/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import classes.JDBC;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Asus
 */
@WebServlet(name = "UserServlet", urlPatterns = {"/UserServlet"})
public class UserServlet extends HttpServlet {
  @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JDBC db = new JDBC(); // Gunakan class JDBC untuk koneksi database
        PrintWriter out = response.getWriter();

        response.setContentType("text/html");

        try {
            // Query data pengguna dari database
            String query = "SELECT * FROM users";
            ResultSet rs = db.getData(query);

            // Tampilkan data pengguna
            out.println("<html><body>");
            out.println("<h1>User List</h1>");
            out.println("<ul>");
            while (rs.next()) {
                out.println("<li>Username: " + rs.getString("username") + " | Role: " + rs.getString("role") + "</li>");
            }
            out.println("</ul>");
            out.println("</body></html>");

        } catch (SQLException e) {
            out.println("Error: " + e.getMessage());
        } finally {
            db.disconnect(); // Tutup koneksi database
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JDBC db = new JDBC();
        PrintWriter out = response.getWriter();

        response.setContentType("text/html");

        // Ambil parameter dari form (misalnya form HTML)
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        // Query untuk menambahkan user ke database
        String query = "INSERT INTO users (username, password, role) VALUES ('" + username + "', '" + password + "', '" + role + "')";
        int rows = db.runQuery(query);
        if (rows > 0) {
            out.println("<p>User added successfully!</p>");
        } else {
            out.println("<p>Failed to add user.</p>");
        }
        db.disconnect();
    }
}
