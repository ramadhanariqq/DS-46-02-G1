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
@WebServlet(name = "MovieServlet", urlPatterns = {"/MovieServlet"})
public class MovieServlet extends HttpServlet {
  @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JDBC db = new JDBC(); // Menggunakan class JDBC
        PrintWriter out = response.getWriter();

        response.setContentType("text/html");

        try {
            // Query data film dari database
            String query = "SELECT * FROM movies";
            ResultSet rs = db.getData(query);

            // Tampilkan data film
            out.println("<html><body>");
            out.println("<h1>Movie List</h1>");
            out.println("<ul>");
            while (rs.next()) {
                out.println("<li>" + rs.getString("title") + " (" + rs.getString("genre") + ")</li>");
            }
            out.println("</ul>");
            out.println("</body></html>");

        } catch (SQLException e) {
            out.println("Error: " + e.getMessage());
        } finally {
            db.disconnect(); // Tutup koneksi database
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

}
