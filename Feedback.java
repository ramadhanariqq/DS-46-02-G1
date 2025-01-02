package models;

import java.util.ArrayList;
import java.util.List;

public class Feedback {
    private int feedbackId;
    private int userId;
    private int filmId;
    private double rating;
    private String comment;
    private static final List<Feedback> feedbackList = new ArrayList<>();

    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getFilmId() {
        return filmId;
    }

    public void setFilmId(int filmId) {
        this.filmId = filmId;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public void submitFeedback(int userId, int filmId, double rating, String comment) {
        Feedback feedback = new Feedback();
        feedback.setFeedbackId(feedbackList.size() + 1); // Auto increment ID
        feedback.setUserId(userId);
        feedback.setFilmId(filmId);
        feedback.setRating(rating);
        feedback.setComment(comment);
        feedbackList.add(feedback);
        System.out.println("Feedback submitted successfully!");
    }

    public List<Feedback> getFeedbackByFilm(int filmId) {
        List<Feedback> filmFeedbacks = new ArrayList<>();
        for (Feedback fb : feedbackList) {
            if (fb.getFilmId() == filmId) {
                filmFeedbacks.add(fb);
            }
        }
        return filmFeedbacks;
    }
}
