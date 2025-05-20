package model;

import java.time.LocalDate;


public class Livre {
    private String isbn;
    private String titre;
    private String auteur;
    private LocalDate datePublication;
    private int nombreExemplaire;
    private int totalExemplaire;
    private boolean statut;

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getAuteur() {
        return auteur;
    }

    public void setAuteur(String auteur) {
        this.auteur = auteur;
    }

    public LocalDate getDatePublication() {
        return datePublication;
    }

    public void setDatePublication(LocalDate datePublication) {
        this.datePublication = datePublication;
    }


    public int getNombreExemplaire() {
        return nombreExemplaire;
    }

    public void setNombreExemplaire(int nombreExemplaire) {
        this.nombreExemplaire = nombreExemplaire;
    }
    
    public int getTotalExemplaire() {
        return totalExemplaire;
    }

    public void setTotalExemplaire(int totalExemplaire) {
        this.totalExemplaire = totalExemplaire;
    }

    public boolean isStatut() {
        return statut;
    }

    public void setStatut(boolean statut) {
        this.statut = statut;
    }
    
    
}
