package models;

import java.util.ArrayList;
import java.util.List;

public class User extends Person {
    private int userId;
    private List<Movie> watchHistory;

    public User() {
        this.watchHistory = new ArrayList<>();
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public List<Movie> getWatchHistory() {
        return watchHistory;
    }

    public void setWatchHistory(List<Movie> watchHistory) {
        this.watchHistory = watchHistory;
    }

    public void addToWatchList(Movie film) {
        if (!watchHistory.contains(film)) {
            watchHistory.add(film);
            System.out.println("Film '" + film.getTitle() + "' has been added to watch list.");
        } else {
            System.out.println("Film '" + film.getTitle() + "' is already in the watch list.");
        }
    }

    public void watchFilm(Movie film) {
        if (watchHistory.contains(film)) {
            System.out.println("You are watching '" + film.getTitle() + "'. Enjoy!");
        } else {
            System.out.println("Film '" + film.getTitle() + "' is not in your watch list. Please add it first.");
        }
    }

    public List<Movie> viewRecommendation() {
        // Implementasi metode untuk melihat rekomendasi
        // Sementara kita hanya akan mengembalikan daftar film yang belum ditonton pengguna
        List<Movie> recommendations = new ArrayList<>();
        for (Movie movie : getMovieList()) {
            if (!watchHistory.contains(movie)) {
                recommendations.add(movie);
            }
        }
        return recommendations;
    }
}
