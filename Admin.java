/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package models;

public class Admin extends Person {
    private int adminId;

    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }

    public void manageFilms(Movie film) {
        System.out.println("Managing film: " + film.getTitle());
        // Contoh implementasi: pengelolaan film bisa berupa tambah, hapus, atau update
    }

    public void addFilm(Movie film) {
        System.out.println("Film '" + film.getTitle() + "' has been added successfully.");
    }

    public void deleteFilm(int filmId) {
        System.out.println("Film with ID " + filmId + " has been deleted successfully.");
    }

    public void updateFilm(Movie film) {
        System.out.println("Film '" + film.getTitle() + "' has been updated successfully.");
    }
}