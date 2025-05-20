package dao;

// Importation des classes nécessaires
import model.Emprunt;         // Le modèle qui représente un emprunt
import util.DBConnection;     // Classe utilitaire pour gérer les connexions à la base de données

import java.sql.*;            // Pour utiliser les classes JDBC (SQL)
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;   // Pour gérer les dates

// Classe DAO pour gérer les opérations sur les emprunts dans la base de données
public class EmpruntDAO {
    
    String dbPath = ""; // Chemin vers la base de données

    // Constructeur qui initialise le chemin de la base de données
    public EmpruntDAO(String dbPath) {
        this.dbPath = dbPath;
    }

    // Méthode pour récupérer tous les emprunts de la base de données
    public List<Emprunt> getAllEmprunts() {
        List<Emprunt> emprunts = new ArrayList<>();
        String sql = "SELECT * FROM Emprunt"; // Requête SQL

        // Connexion à la base et exécution de la requête
        try (Connection conn = DBConnection.getConnection(dbPath);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            // Pour chaque ligne du résultat
            while (rs.next()) {
                Emprunt e = new Emprunt();
                e.setIdEmprunt(rs.getInt("idEmprunt"));
                e.setIsbn(rs.getString("isbn"));
                e.setIdLecteur(rs.getInt("idLecteur"));
                e.setIdBibliothecaire(rs.getInt("idBibliothecaire")); 
                e.setDateEmprunt(LocalDate.parse(rs.getString("dateEmprunt"))); // Conversion de la chaîne vers LocalDate
                e.setDateRetourPrevue(LocalDate.parse(rs.getString("dateRetourPrevue")));
                e.setDateRetourEffective(rs.getString("dateRetourEffective") != null ? LocalDate.parse(rs.getString("dateRetourEffective")) : null);
                emprunts.add(e); // Ajout dans la liste
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Affiche les erreurs SQL
        }

        return emprunts; // On retourne la liste des emprunts
    }

    // Méthode pour ajouter un nouvel emprunt dans la base de données
    public void ajouterEmprunt(Emprunt emprunt) {
        String sql = "INSERT INTO Emprunt(isbn, idLecteur, idBibliothecaire, dateEmprunt, dateRetourPrevue) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Remplissage des paramètres de la requête
            ps.setString(1, emprunt.getIsbn());
            ps.setInt(2, emprunt.getIdLecteur());
            ps.setInt(3, emprunt.getIdBibliothecaire());
            ps.setString(4, emprunt.getDateEmprunt().toString());
            ps.setString(5, emprunt.getDateRetourPrevue().toString());

            ps.executeUpdate(); // Exécution de la requête INSERT
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Méthode pour récupérer un emprunt spécifique par son ID
    public Emprunt getEmpruntById(int id) {
        Emprunt emprunt = null;
        String sql = "SELECT * FROM Emprunt WHERE idEmprunt = ?";

        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id); // Remplir le paramètre

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    emprunt = new Emprunt();
                    emprunt.setIdEmprunt(rs.getInt("idEmprunt"));
                    emprunt.setIsbn(rs.getString("isbn"));
                    emprunt.setIdLecteur(rs.getInt("idLecteur"));
                    emprunt.setIdBibliothecaire(rs.getInt("idBibliothecaire"));
                    emprunt.setDateEmprunt(LocalDate.parse(rs.getString("dateEmprunt")));
                    emprunt.setDateRetourPrevue(LocalDate.parse(rs.getString("dateRetourPrevue")));
                    emprunt.setDateRetourEffective(rs.getString("dateRetourEffective") != null ? LocalDate.parse(rs.getString("dateRetourEffective")) : null);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return emprunt; // Retourner l’emprunt trouvé ou null si inexistant
    }

    // Méthode pour mettre à jour la date de retour effective d’un emprunt (retour du livre)
    public void updateDateRetourEffective(int idEmprunt) {
        String sql = "UPDATE Emprunt SET dateRetourEffective = ? WHERE idEmprunt = ?";
        
        String currentDate = LocalDate.now().toString(); // Date actuelle

        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, currentDate); // Définir la date de retour
            pstmt.setInt(2, idEmprunt); // L’ID de l’emprunt concerné

            pstmt.executeUpdate(); // Exécution de la mise à jour
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Méthode qui retourne le nombre d’emprunts faits pour un livre donné (via son ISBN)
    public int nombreEmpruntsParIsbn(String isbnRecherche) {
        String sql = "SELECT COUNT(*) FROM Emprunt WHERE isbn = ?";
        int nombreEmprunts = 0;

        try (Connection conn = DBConnection.getConnection(dbPath);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, isbnRecherche); // On recherche les emprunts pour cet ISBN

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    nombreEmprunts = rs.getInt(1); // On récupère le résultat du COUNT
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return nombreEmprunts; // On retourne le nombre trouvé
    }
}
