package model;

import java.time.LocalDate;

public class Emprunt {
    private int idEmprunt;
    private String isbn;
    private int idLecteur;
    private int idBibliothecaire;
    private LocalDate dateEmprunt;
    private LocalDate dateRetourPrevue;
    private LocalDate dateRetourEffective;

    public int getIdEmprunt() {
        return idEmprunt;
    }

    public void setIdEmprunt(int idEmprunt) {
        this.idEmprunt = idEmprunt;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public int getIdLecteur() {
        return idLecteur;
    }

    public void setIdLecteur(int idLecteur) {
        this.idLecteur = idLecteur;
    }
    
    public int getIdBibliothecaire() {
        return idBibliothecaire;
    }

    public void setIdBibliothecaire(int idBibliothecaire) {
        this.idBibliothecaire = idBibliothecaire;
    }

    public LocalDate getDateEmprunt() {
        return dateEmprunt;
    }

    public void setDateEmprunt(LocalDate dateEmprunt) {
        this.dateEmprunt = dateEmprunt;
    }

    public LocalDate getDateRetourPrevue() {
        return dateRetourPrevue;
    }

    public void setDateRetourPrevue(LocalDate dateRetourPrevue) {
        this.dateRetourPrevue = dateRetourPrevue;
    }

    public LocalDate getDateRetourEffective() {
        return dateRetourEffective;
    }

    public void setDateRetourEffective(LocalDate dateRetourEffective) {
        this.dateRetourEffective = dateRetourEffective;
    }
}
