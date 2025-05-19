package dao;

// Importation de la classe Lecteur (le modèle) et de la classe de connexion à la base de données
import model.Lecteur;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LecteurDAO {
    
    // Chemin de la base de données (passé au constructeur)
    String dbPath = "";
    public LecteurDAO(String dbPath) {
        this.dbPath = dbPath;
    }

    // Récupère tous les lecteurs dans la base de données
    public List<Lecteur> getAllLecteurs() {
        List<Lecteur> lecteurs = new ArrayList<>();
        String sql = "SELECT * FROM Lecteur";

        // Connexion à la base, exécution de la requête et lecture des résultats
        try (Connection conn = DBConnection.getConnection(dbPath);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Lecteur l = new Lecteur();
                l.setIdLecteur(rs.getInt("idLecteur"));
                l.setNomLecteur(rs.getString("nomLecteur"));
                l.setAdresseLecteur(rs.getString("adresseLecteur"));
                l.setNumeroCNI(rs.getString("numeroCNI"));
                l.setNombreEmpruntEnCours(rs.getInt("nombreEmpruntEnCours"));
                lecteurs.add(l); // Ajoute le lecteur à la liste
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lecteurs;
    }

    // Ajoute un nouveau lecteur à la base (le nombre d'emprunts est mis à 0 par défaut)
    public void ajouterLecteur(Lecteur lecteur) {
        String sql = "INSERT INTO Lecteur(nomLecteur, adresseLecteur, numeroCNI, nombreEmpruntEnCours) VALUES (?, ?, ?, 0)";

        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, lecteur.getNomLecteur());
            ps.setString(2, lecteur.getAdresseLecteur());
            ps.setString(3, lecteur.getNumeroCNI());
            ps.executeUpdate(); // Exécution de l'insertion
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Supprime un lecteur selon son ID
    public boolean deleteLecteur(int id) {
        String sql = "DELETE FROM Lecteur WHERE idLecteur = ?";
        boolean deleted = false;

        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            int affectedRows = pstmt.executeUpdate(); // Exécute la suppression

            if (affectedRows > 0) {
                deleted = true; // Si au moins une ligne est affectée → succès
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return deleted;
    }

    // Récupère un lecteur à partir de son identifiant
    public Lecteur getLecteurByIdLecteur(int idLecteur) {
        Lecteur lecteur = null;
        String sql = "SELECT * FROM Lecteur WHERE idLecteur = ?";

        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idLecteur);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                lecteur = new Lecteur();
                lecteur.setIdLecteur(rs.getInt("idLecteur"));
                lecteur.setNomLecteur(rs.getString("nomLecteur"));
                lecteur.setAdresseLecteur(rs.getString("adresseLecteur"));
                lecteur.setNumeroCNI(rs.getString("numeroCNI"));
                lecteur.setNombreEmpruntEnCours(rs.getInt("nombreEmpruntEnCours"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lecteur;
    }

    // Met à jour les informations d’un lecteur
    public boolean updateLecteur(Lecteur lecteur, int ancienIdLecteur) {
        String sql = "UPDATE Lecteur SET nomLecteur = ?, adresseLecteur = ?, numeroCNI = ? WHERE idLecteur = ?";
        boolean updated = false;

        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, lecteur.getNomLecteur());
            pstmt.setString(2, lecteur.getAdresseLecteur());
            pstmt.setString(3, lecteur.getNumeroCNI());
            pstmt.setInt(4, ancienIdLecteur);

            int rows = pstmt.executeUpdate(); // Exécute la mise à jour
            updated = (rows > 0);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return updated;
    }

    // Incrémente le nombre d'emprunts en cours d'un lecteur
    public void incrementNombreEmpruntEnCours(int idLecteur) {
        String selectSql = "SELECT nombreEmpruntEnCours FROM Lecteur WHERE idLecteur = ?";
        String updateSql = "UPDATE Lecteur SET nombreEmpruntEnCours = ? WHERE idLecteur = ?";

        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement selectStmt = conn.prepareStatement(selectSql);
             PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {

            selectStmt.setInt(1, idLecteur);
            ResultSet rs = selectStmt.executeQuery();

            if (rs.next()) {
                int currentValue = rs.getInt("nombreEmpruntEnCours");
                int newValue = currentValue + 1;

                updateStmt.setInt(1, newValue);
                updateStmt.setInt(2, idLecteur);
                updateStmt.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Décrémente le nombre d'emprunts en cours (sans aller en-dessous de 0)
    public void decrementNombreEmpruntEnCours(int idLecteur) {
        String selectSql = "SELECT nombreEmpruntEnCours FROM Lecteur WHERE idLecteur = ?";
        String updateSql = "UPDATE Lecteur SET nombreEmpruntEnCours = ? WHERE idLecteur = ?";

        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement selectStmt = conn.prepareStatement(selectSql);
             PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {

            selectStmt.setInt(1, idLecteur);
            ResultSet rs = selectStmt.executeQuery();

            if (rs.next()) {
                int currentValue = rs.getInt("nombreEmpruntEnCours");
                int newValue = currentValue > 0 ? currentValue - 1 : 0;
                updateStmt.setInt(1, newValue);
                updateStmt.setInt(2, idLecteur);
                updateStmt.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Vérifie si un lecteur a exactement 3 emprunts en cours
    public boolean verificationSiLeLecteurATroisEmprunts(int idLecteur) {
        String sql = "SELECT nombreEmpruntEnCours FROM Lecteur WHERE idLecteur = ?";

        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idLecteur);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int nombreEmprunts = rs.getInt("nombreEmpruntEnCours");
                return nombreEmprunts == 3;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Récupère les lecteurs qui n'ont actuellement aucun emprunt
    public List<Lecteur> prendreLecteursSansEmprunt() {
        List<Lecteur> lecteurs = new ArrayList<>();
        String sql = "SELECT * FROM Lecteur WHERE nombreEmpruntEnCours = 0";

        try (Connection conn = DBConnection.getConnection(dbPath);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Lecteur l = new Lecteur();
                l.setIdLecteur(rs.getInt("idLecteur"));
                l.setNomLecteur(rs.getString("nomLecteur"));
                l.setAdresseLecteur(rs.getString("adresseLecteur"));
                l.setNumeroCNI(rs.getString("numeroCNI"));
                l.setNombreEmpruntEnCours(rs.getInt("nombreEmpruntEnCours"));
                lecteurs.add(l);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lecteurs;
    }

    // Recherche de lecteurs par mot-clé (nom, adresse ou CNI)
    public List<Lecteur> chercherLecteursParNomAdresseCNI(String motCle) {
        List<Lecteur> lecteurs = new ArrayList<>();
        String sql;

        // Si le mot clé est vide, on retourne tous les lecteurs
        if (motCle == null || motCle.trim().isEmpty()) {
            sql = "SELECT * FROM Lecteur";
        } else {
            sql = "SELECT * FROM Lecteur WHERE LOWER(nomLecteur) LIKE ? OR LOWER(adresseLecteur) LIKE ? OR LOWER(numeroCNI) LIKE ?";
        }

        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            if (motCle != null && !motCle.trim().isEmpty()) {
                String motCleFormatte = "%" + motCle.toLowerCase() + "%";
                stmt.setString(1, motCleFormatte);
                stmt.setString(2, motCleFormatte);
                stmt.setString(3, motCleFormatte);
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Lecteur l = new Lecteur();
                l.setIdLecteur(rs.getInt("idLecteur"));
                l.setNomLecteur(rs.getString("nomLecteur"));
                l.setAdresseLecteur(rs.getString("adresseLecteur"));
                l.setNumeroCNI(rs.getString("numeroCNI"));
                l.setNombreEmpruntEnCours(rs.getInt("nombreEmpruntEnCours"));
                lecteurs.add(l);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lecteurs;
    }

}
