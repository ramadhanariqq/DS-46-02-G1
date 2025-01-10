package Servlet;

import classes.JDBC;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "MovieServlet", urlPatterns = {"/MovieServlet"})
public class MovieServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JDBC db = new JDBC(); // Menggunakan class JDBC
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        try {
            String query = "SELECT * FROM movies";
            ResultSet rs = db.getData(query);

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
            db.disconnect();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JDBC db = new JDBC();
        String action = request.getParameter("action");
        String message = "";

        try {
            if (action.equals("add")) {
                String title = request.getParameter("title");
                String genre = request.getParameter("genre");
                int duration = Integer.parseInt(request.getParameter("duration"));
                String posterUrl = request.getParameter("poster_url");
                String synopsis = request.getParameter("synopsis");

                String query = "INSERT INTO movies (title, genre, duration, poster_url, synopsis) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement ps = db.conn.prepareStatement(query);
                ps.setString(1, title);
                ps.setString(2, genre);
                ps.setInt(3, duration);
                ps.setString(4, posterUrl);
                ps.setString(5, synopsis);
                ps.executeUpdate();

                message = "Movie added successfully!";
            } else if (action.equals("edit")) {
                int id = Integer.parseInt(request.getParameter("id"));
                String title = request.getParameter("title");
                String genre = request.getParameter("genre");
                int duration = Integer.parseInt(request.getParameter("duration"));
                String posterUrl = request.getParameter("poster_url");
                String synopsis = request.getParameter("synopsis");

                String query = "UPDATE movies SET title = ?, genre = ?, duration = ?, poster_url = ?, synopsis = ? WHERE id = ?";
                PreparedStatement ps = db.conn.prepareStatement(query);
                ps.setString(1, title);
                ps.setString(2, genre);
                ps.setInt(3, duration);
                ps.setString(4, posterUrl);
                ps.setString(5, synopsis);
                ps.setInt(6, id);
                ps.executeUpdate();

                message = "Movie updated successfully!";
            } else if (action.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));

                String query = "DELETE FROM movies WHERE id = ?";
                PreparedStatement ps = db.conn.prepareStatement(query);
                ps.setInt(1, id);
                ps.executeUpdate();

                message = "Movie deleted successfully!";
            }
        } catch (SQLException e) {
            message = "Error: " + e.getMessage();
        } finally {
            db.disconnect();
        }

        request.setAttribute("message", message);
        request.getRequestDispatcher("movies_admin.jsp").forward(request, response);
    }
}
