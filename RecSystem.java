package models;

import java.util.ArrayList;
import java.util.List;

public class RecSystem implements Searchable {
    private double minRating;
    private String genre;
    private static List<Movie> movieDatabase = new ArrayList<>();

    public double getMinRating() {
        return minRating;
    }

    public void setMinRating(double minRating) {
        this.minRating = minRating;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    @Override
    public List<Movie> search(String keyword) {
        List<Movie> results = new ArrayList<>();
        for (Movie movie : movieDatabase) {
            if (movie.getTitle().toLowerCase().contains(keyword.toLowerCase())) {
                results.add(movie);
            }
        }
        return results;
    }

    public List<Movie> recommend() {
        List<Movie> recommendations = new ArrayList<>();
        for (Movie movie : movieDatabase) {
            if (movie.getGenre().equalsIgnoreCase(genre) && movie.getRating() >= minRating) {
                recommendations.add(movie);
            }
        }
        return recommendations;
    }

    public static void addMovieToDatabase(Movie movie) {
        movieDatabase.add(movie);
    }
}
