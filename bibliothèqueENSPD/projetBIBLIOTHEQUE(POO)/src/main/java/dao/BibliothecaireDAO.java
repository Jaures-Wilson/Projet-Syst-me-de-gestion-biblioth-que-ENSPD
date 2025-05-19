package dao;

// On importe les classes nécessaires
import model.Bibliothecaire; // Le modèle représentant un bibliothécaire
import util.DBConnection;    // Classe utilitaire pour se connecter à la base de données

import java.sql.*;           // Pour tout ce qui concerne la base de données (JDBC)
import java.util.ArrayList;
import java.util.List;

// Classe DAO (Data Access Object) pour manipuler les bibliothécaires dans la base de données
public class BibliothecaireDAO {
	
	String dbPath = ""; // Chemin vers la base de données

	// Constructeur prenant en paramètre le chemin de la base de données
	public BibliothecaireDAO(String dbPath) {
		this.dbPath = dbPath;
	}
	
	// Méthode qui retourne une liste de tous les bibliothécaires présents dans la base de données
	public List<Bibliothecaire> getAllBibliothecaire() {
        List<Bibliothecaire> bibliothecaires = new ArrayList<>(); // Liste qui va contenir les résultats
        String sql = "SELECT * FROM Bibliothecaire"; // Requête SQL

        // On utilise un try-with-resources pour gérer automatiquement la fermeture de la connexion
        try (Connection conn = DBConnection.getConnection(dbPath); // Connexion à la BDD
             Statement stmt = conn.createStatement();              // Création de l'instruction SQL
             ResultSet rs = stmt.executeQuery(sql)) {              // Exécution de la requête et récupération des résultats

            // Tant qu'on a des résultats
            while (rs.next()) {
            	Bibliothecaire l = new Bibliothecaire(); // Création d'un objet Bibliothecaire
            	l.setIdBibliothecaire(rs.getInt("idBibliothecaire")); // On récupère l'ID
                l.setNomBibliothecaire(rs.getString("nomBibliothecaire")); // On récupère le nom
                l.setMotDePasse(rs.getString("motDePasse")); // On récupère le mot de passe
                
                bibliothecaires.add(l); // On ajoute à la liste
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Affichage de l'erreur en cas de problème SQL
        }

        return bibliothecaires; // On retourne la liste des bibliothécaires
    }
	
	// Méthode qui retourne un bibliothécaire spécifique selon son ID
	public Bibliothecaire prendreBibliothecaireById(int idBibliothecaire) {
	    Bibliothecaire bibliothecaire = null;
	    String sql = "SELECT * FROM Bibliothecaire WHERE idBibliothecaire = ?"; // Requête SQL avec un paramètre

	    try (Connection conn = DBConnection.getConnection(dbPath); // Connexion à la BDD
	         PreparedStatement stmt = conn.prepareStatement(sql)) { // Utilisation d’un PreparedStatement pour sécuriser la requête

	        stmt.setInt(1, idBibliothecaire); // On remplace le ? par l’ID du bibliothécaire
	        ResultSet rs = stmt.executeQuery(); // Exécution de la requête

	        // Si on trouve un résultat
	        if (rs.next()) {
	            bibliothecaire = new Bibliothecaire(); // Création de l'objet
	            bibliothecaire.setIdBibliothecaire(rs.getInt("idBibliothecaire"));
	            bibliothecaire.setNomBibliothecaire(rs.getString("nomBibliothecaire"));
	            bibliothecaire.setMotDePasse(rs.getString("motDePasse"));
	        }

	    } catch (SQLException e) {
	        e.printStackTrace(); // Affichage de l'erreur si problème
	    }

	    return bibliothecaire; // Retourne le bibliothécaire trouvé ou null
	}
}
