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
import java.util.*;

public class RecommendationEngine {

    private Connection conn;

    public RecommendationEngine(Connection conn) {
        this.conn = conn;
    }

    public List<Map<String, String>> getRecommendations(int userId) throws SQLException {
        List<Map<String, String>> recommendations = new ArrayList<>();

        // SQL query to fetch recommendations
        String query = """
            SELECT DISTINCT m.id, m.title, m.genre, m.poster_url, m.duration, m.synopsis
            FROM movies m
            WHERE m.id NOT IN (
                SELECT movie_id FROM user_watch_history WHERE user_id = ?
            )
            ORDER BY RAND()
            LIMIT 5
        """;

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, String> movie = new HashMap<>();
                movie.put("id", String.valueOf(rs.getInt("id")));
                movie.put("title", rs.getString("title"));
                movie.put("genre", rs.getString("genre"));
                movie.put("poster_url", rs.getString("poster_url"));
                movie.put("duration", String.valueOf(rs.getInt("duration")));
                movie.put("synopsis", rs.getString("synopsis"));
                recommendations.add(movie);
            }
        }

        return recommendations;
    }
}
