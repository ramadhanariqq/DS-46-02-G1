package Servlet;

import classes.JDBC;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MovieReviewServlet")
public class MovieReviewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        JDBC db = new JDBC();

        try {
            // Fetch movie details
            String movieQuery = "SELECT * FROM movies WHERE id = ?";
            PreparedStatement movieStmt = db.conn.prepareStatement(movieQuery);
            movieStmt.setInt(1, movieId);
            ResultSet movieRs = movieStmt.executeQuery();
            if (movieRs.next()) {
                request.setAttribute("movieTitle", movieRs.getString("title"));
                request.setAttribute("movieGenre", movieRs.getString("genre"));
                request.setAttribute("movieDuration", movieRs.getInt("duration"));
                request.setAttribute("moviePoster", movieRs.getString("poster_url"));
                request.setAttribute("movieSynopsis", movieRs.getString("synopsis"));
            }

            // Fetch reviews for the movie
            String reviewQuery = "SELECT u.username, r.review, r.rating, r.created_at FROM reviews r JOIN users u ON r.user_id = u.id WHERE r.movie_id = ? ORDER BY r.created_at DESC";
            PreparedStatement reviewStmt = db.conn.prepareStatement(reviewQuery);
            reviewStmt.setInt(1, movieId);
            ResultSet reviewRs = reviewStmt.executeQuery();
            request.setAttribute("reviews", reviewRs);

        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
        } finally {
            db.disconnect();
        }

        request.getRequestDispatcher("movieReview.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        int userId = (Integer) request.getSession().getAttribute("userId");
        String review = request.getParameter("review");
        int rating = Integer.parseInt(request.getParameter("rating"));
        JDBC db = new JDBC();

        try {
            // Insert review into the database
            String reviewQuery = "INSERT INTO reviews (movie_id, user_id, review, rating) VALUES (?, ?, ?, ?)";
            PreparedStatement reviewStmt = db.conn.prepareStatement(reviewQuery);
            reviewStmt.setInt(1, movieId);
            reviewStmt.setInt(2, userId);
            reviewStmt.setString(3, review);
            reviewStmt.setInt(4, rating);
            reviewStmt.executeUpdate();
        } catch (SQLException e) {
            request.setAttribute("error", e.getMessage());
        } finally {
            db.disconnect();
        }

        doGet(request, response);
    }
}
