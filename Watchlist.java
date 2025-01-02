package models;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Watchlist {
    private int watchlistId;
    private int userId;
    private List<Movie> films;

    public Watchlist() {
        this.films = new ArrayList<>();
    }

    public int getWatchlistId() {
        return watchlistId;
    }

    public void setWatchlistId(int watchlistId) {
        this.watchlistId = watchlistId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public List<Movie> getFilms() {
        return films;
    }

    public void setFilms(List<Movie> films) {
        this.films = films;
    }

    public void addToWatchlist(int userId, Movie film) {
        if (this.userId == userId) {
            if (!films.contains(film)) {
                films.add(film);
                System.out.println("Film '" + film.getTitle() + "' has been added to the watchlist.");
            } else {
                System.out.println("Film '" + film.getTitle() + "' is already in the watchlist.");
            }
        } else {
            System.out.println("User ID does not match.");
        }
    }

    public void removeFromWatchlist(int userId, int filmId) {
        if (this.userId == userId) {
            Iterator<Movie> iterator = films.iterator();
            while (iterator.hasNext()) {
                Movie film = iterator.next();
                if (film.getId() == filmId) {
                    iterator.remove();
                    System.out.println("Film with ID " + filmId + " has been removed from the watchlist.");
                    return;
                }
            }
            System.out.println("Film with ID " + filmId + " was not found in the watchlist.");
        } else {
            System.out.println("User ID does not match.");
        }
    }

    public List<Movie> getWatchlistByUser(int userId) {
        if (this.userId == userId) {
            return films;
        } else {
            System.out.println("User ID does not match.");
            return new ArrayList<>();
        }
    }
}
