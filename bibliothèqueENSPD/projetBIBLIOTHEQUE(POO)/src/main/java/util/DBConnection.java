package util;

// Importation des classes nécessaires pour gérer une connexion SQL
import java.sql.*;

public class DBConnection {

    // Constante qui contient le début de l'URL de connexion pour SQLite
    private static final String DB_URL = "jdbc:sqlite:";

    // Méthode statique pour obtenir une connexion à la base de données
    public static Connection getConnection(String dbPath) throws SQLException {
        try {
            // Charge le driver JDBC pour SQLite (obligatoire dans certaines versions de Java)
            Class.forName("org.sqlite.JDBC");
        } catch (ClassNotFoundException e) {
            // Si le driver n'est pas trouvé, rien n'est affiché ici (mais on pourrait logguer une erreur)
        }

        // Retourne une connexion à la base en utilisant l'URL complète (ex: jdbc:sqlite:maBase.db)
        return DriverManager.getConnection(DB_URL + dbPath);
    }
}
