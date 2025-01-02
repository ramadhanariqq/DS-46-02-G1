package models;

public class Movie {
    private int id;
    private String title;
    private String genre;
    private String releaseDate;
    private double rating;
    private String synopsis;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(String releaseDate) {
        this.releaseDate = releaseDate;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public String getSynopsis() {
        return synopsis;
    }

    public void setSynopsis(String synopsis) {
        this.synopsis = synopsis;
    }

    public String getDetails() {
        // Implementasi metode untuk mendapatkan detail film
        return String.format("Title: %s, Genre: %s, Release Date: %s, Rating: %.1f, Synopsis: %s",
                             title, genre, releaseDate, rating, synopsis);
    }
}
