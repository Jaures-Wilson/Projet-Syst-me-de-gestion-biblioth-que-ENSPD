package dao;

import model.Livre;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;

public class LivreDAO {

    // Chemin vers la base de données (peut être une URL JDBC)
    String dbPath = "";

    public LivreDAO(String dbPath) {
        this.dbPath = dbPath;
    }

    // Méthode pour récupérer tous les livres depuis la base de données
    public List<Livre> getAllLivres() {
        List<Livre> livres = new ArrayList<>();
        String sql = "SELECT * FROM Livre";

        // Connexion à la base + exécution de la requête + lecture des résultats
        try (Connection conn = DBConnection.getConnection(dbPath);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            // Parcourt chaque ligne du résultat et crée un objet Livre
            while (rs.next()) {
                Livre l = new Livre();
                l.setIsbn(rs.getString("isbn"));
                l.setTitre(rs.getString("titre"));
                l.setAuteur(rs.getString("auteur"));
                l.setDatePublication(LocalDate.parse(rs.getString("datePublication")));
                l.setNombreExemplaire(rs.getInt("nombreExemplaire"));
                l.setTotalExemplaire(rs.getInt("totalExemplaire"));
                l.setStatut(rs.getBoolean("statut"));
                livres.add(l); // Ajout à la liste
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Affiche les erreurs SQL
        }

        return livres;
    }

    // Ajoute un nouveau livre dans la base de données
    public void ajouterLivre(Livre livre) {
        String sql = "INSERT INTO Livre(isbn, titre, auteur, datePublication, nombreExemplaire, totalExemplaire, statut) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Remplissage des paramètres dans la requête préparée
            ps.setString(1, livre.getIsbn());
            ps.setString(2, livre.getTitre());
            ps.setString(3, livre.getAuteur());
            ps.setString(4, livre.getDatePublication().toString()); // Conversion de LocalDate en String
            ps.setInt(5, livre.getNombreExemplaire());
            ps.setInt(6, livre.getTotalExemplaire());
            ps.setBoolean(7, livre.isStatut());

            ps.executeUpdate(); // Exécution de l’insertion
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Supprime un livre par son ISBN
    public boolean deleteLivre(String isbn) {
        String sql = "DELETE FROM Livre WHERE isbn = ?";
        boolean deleted = false;

        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, isbn);
            int affectedRows = pstmt.executeUpdate();

            if (affectedRows > 0) {
                deleted = true; // Si au moins une ligne a été supprimée
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return deleted;
    }

    // Récupère un livre par son ISBN
    public Livre getLivreByIsbn(String isbn) {
        Livre livre = null;
        String sql = "SELECT * FROM Livre WHERE isbn = ?";

        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, isbn);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                livre = new Livre();
                livre.setIsbn(rs.getString("isbn"));
                livre.setTitre(rs.getString("titre"));
                livre.setAuteur(rs.getString("auteur"));
                livre.setDatePublication(LocalDate.parse(rs.getString("datePublication")));
                livre.setNombreExemplaire(rs.getInt("nombreExemplaire"));
                livre.setTotalExemplaire(rs.getInt("totalExemplaire"));
                livre.setStatut(rs.getBoolean("statut"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return livre;
    }

    // Met à jour les informations d’un livre (par exemple, modifier le titre, l’auteur, etc.)
    public boolean updateLivre(Livre livre, String ancienIsbn) {
        String sql = "UPDATE Livre SET isbn = ?, titre = ?, auteur = ?, datePublication = ?, nombreExemplaire = ?, totalExemplaire = ?, statut = ? WHERE isbn = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean updated = false;

        try {
            conn = DBConnection.getConnection(dbPath);
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, livre.getIsbn());
            pstmt.setString(2, livre.getTitre());
            pstmt.setString(3, livre.getAuteur());
            pstmt.setString(4, livre.getDatePublication().toString());
            pstmt.setInt(5, livre.getNombreExemplaire());
            pstmt.setInt(6, livre.getTotalExemplaire());
            pstmt.setBoolean(7, livre.isStatut());
            pstmt.setString(8, ancienIsbn);

            int rows = pstmt.executeUpdate();
            updated = (rows > 0); // Si au moins une ligne a été modifiée

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return updated;
    }

    // Diminue le nombre d’exemplaires disponibles d’un livre
    public boolean diminuerNombreExemplaire(String isbn) {
        String sql = "UPDATE Livre " +
                     "SET nombreExemplaire = nombreExemplaire - 1, " +
                     "    statut = CASE WHEN nombreExemplaire - 1 > 0 THEN 1 ELSE 0 END " +
                     "WHERE isbn = ? AND nombreExemplaire > 0";
        boolean updated = false;

        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, isbn);
            int rows = pstmt.executeUpdate();
            updated = (rows > 0);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return updated;
    }

    // Augmente le nombre d’exemplaires disponibles d’un livre
    public boolean augmenterNombreExemplaire(String isbn) {
        String sql = "UPDATE Livre " +
                     "SET nombreExemplaire = nombreExemplaire + 1, " +
                     "    statut = CASE WHEN nombreExemplaire + 1 > 0 THEN 1 ELSE 0 END " +
                     "WHERE isbn = ?";
        boolean updated = false;

        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, isbn);
            int rows = pstmt.executeUpdate();
            updated = (rows > 0);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return updated;
    }

    // Récupère tous les livres dont tous les exemplaires sont disponibles (aucun emprunté)
    public List<Livre> prendreLivresEntierementDisponibles() {
        List<Livre> livres = new ArrayList<>();
        String sql = "SELECT * FROM Livre WHERE nombreExemplaire = totalExemplaire";

        try (Connection conn = DBConnection.getConnection(dbPath);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Livre l = new Livre();
                l.setIsbn(rs.getString("isbn"));
                l.setTitre(rs.getString("titre"));
                l.setAuteur(rs.getString("auteur"));
                l.setDatePublication(LocalDate.parse(rs.getString("datePublication")));
                l.setNombreExemplaire(rs.getInt("nombreExemplaire"));
                l.setTotalExemplaire(rs.getInt("totalExemplaire"));
                l.setStatut(rs.getBoolean("statut"));
                livres.add(l);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return livres;
    }

    // Recherche de livres contenant un mot-clé dans le titre ou l’auteur
    public List<Livre> chercherLivresParTitreOuAuteur(String motCle) {
        List<Livre> livres = new ArrayList<>();
        String sql;

        // Si pas de mot-clé fourni, récupérer tous les livres
        if (motCle == null || motCle.trim().isEmpty()) {
            sql = "SELECT * FROM Livre"; 
        } else {
            sql = "SELECT * FROM Livre WHERE LOWER(titre) LIKE ? OR LOWER(auteur) LIKE ?";
        }

        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Ajoute les paramètres si mot-clé fourni
            if (motCle != null && !motCle.trim().isEmpty()) {
                String motCleFormatte = "%" + motCle.toLowerCase() + "%";
                stmt.setString(1, motCleFormatte);
                stmt.setString(2, motCleFormatte);
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Livre l = new Livre();
                l.setIsbn(rs.getString("isbn"));
                l.setTitre(rs.getString("titre"));
                l.setAuteur(rs.getString("auteur"));
                l.setDatePublication(LocalDate.parse(rs.getString("datePublication")));
                l.setNombreExemplaire(rs.getInt("nombreExemplaire"));
                l.setTotalExemplaire(rs.getInt("totalExemplaire"));
                l.setStatut(rs.getBoolean("statut"));
                livres.add(l);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return livres;
    }

    // Vérifie si un ISBN donné existe déjà dans la base
    public boolean isbnExiste(String isbnRecherche) {
        String sql = "SELECT COUNT(*) FROM Livre WHERE isbn = ?";
        
        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, isbnRecherche);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0; // Retourne true si un livre avec cet ISBN existe
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false; 
    }
}
