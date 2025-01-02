package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Genre {
    private int genreId;
    private String name;
    private String description;

    public int getGenreId() {
        return genreId;
    }

    public void setGenreId(int genreId) {
        this.genreId = genreId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Genre> getAllGenres(Connection conn) {
        List<Genre> genres = new ArrayList<>();
        String query = "SELECT * FROM genres";

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Genre genre = new Genre();
                genre.setGenreId(rs.getInt("genre_id"));
                genre.setName(rs.getString("name"));
                genre.setDescription(rs.getString("description"));
                genres.add(genre);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return genres;
    }
}
