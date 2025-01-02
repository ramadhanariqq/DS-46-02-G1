package models;

import java.util.ArrayList;
import java.util.List;

public class Person {
    private int id;
    private String name;
    private List<Movie> movieList; // Daftar film untuk pencarian

    public Person() {
        this.movieList = new ArrayList<>(); // Inisialisasi daftar film
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Movie> getMovieList() {
        return movieList;
    }

    public void setMovieList(List<Movie> movieList) {
        this.movieList = movieList;
    }

    public List<Movie> search(String keyword) {
        List<Movie> searchResults = new ArrayList<>();
        
        for (Movie movie : movieList) {
            if (movie.getTitle().toLowerCase().contains(keyword.toLowerCase())) {
                searchResults.add(movie);
            }
        }
        
        return searchResults;
    }
}
