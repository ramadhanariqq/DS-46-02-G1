package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/watchlist")
public class WatchlistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        int movieId = Integer.parseInt(request.getParameter("movie_id"));
        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/movies_db", "root", "");

            if ("add".equals(action)) {
                // Add movie to watchlist
                String checkQuery = "SELECT * FROM user_watch_history WHERE user_id = ? AND movie_id = ?";
                pstmt = conn.prepareStatement(checkQuery);
                pstmt.setInt(1, userId);
                pstmt.setInt(2, movieId);

                if (pstmt.executeQuery().next()) {
                    session.setAttribute("message", "This movie is already in your watchlist.");
                } else {
                    String insertQuery = "INSERT INTO user_watch_history (user_id, movie_id, watched_at) VALUES (?, ?, NOW())";
                    pstmt = conn.prepareStatement(insertQuery);
                    pstmt.setInt(1, userId);
                    pstmt.setInt(2, movieId);
                    pstmt.executeUpdate();
                    session.setAttribute("message", "The movie has been added to your watchlist.");
                }
            } else if ("remove".equals(action)) {
                // Remove movie from watchlist
                String deleteQuery = "DELETE FROM user_watch_history WHERE user_id = ? AND movie_id = ?";
                pstmt = conn.prepareStatement(deleteQuery);
                pstmt.setInt(1, userId);
                pstmt.setInt(2, movieId);
                pstmt.executeUpdate();
                session.setAttribute("message", "The movie has been removed from your watchlist.");
            }
        } catch (Exception e) {
            session.setAttribute("message", "Error: " + e.getMessage());
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception ignore) {}
        }

        // Redirect back to the appropriate page
        response.sendRedirect("watch_history.jsp");
    }
}
