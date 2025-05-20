<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.format.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Statistiques</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Importation du CSS depuis un fichier externe -->
    <link rel="stylesheet" href="CSS/stat.css">
    <!-- Importation de Chart.js pour les graphiques -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
</head>
<body>
    <!-- En-tête avec titre principal -->
    <header>
        <h1>Statistiques de la Bibliothèque</h1>
    </header>
    
    <div class="container">
        <!-- Bouton retour vers le menu -->
        <a href="lancerProjet?page=menu.jsp" class="back-btn">Retour au menu</a>
        
        <!-- Navigation entre les différentes statistiques -->
        <div class="stats-nav">
            <div class="stats-nav-item active" onclick="showSection('general')">Vue Générale</div>
            <div class="stats-nav-item" onclick="showSection('livres')">Statistiques Livres</div>
            <div class="stats-nav-item" onclick="showSection('lecteurs')">Statistiques Lecteurs</div>
            <div class="stats-nav-item" onclick="showSection('emprunts')">Statistiques Emprunts</div>
        </div>
        
        <!-- Section Vue Générale -->
        <div id="general" class="stats-section active">
            <h2 class="chart-title">Aperçu global de la bibliothèque</h2>
            
            <div class="stats-grid">
                <!-- Cartes statistiques principales -->
                <%
                    // Simulation de données en attendant la connexion à la base de données réelle
                    int totalLivres = 450;
                    int totalLecteurs = 187;
                    int totalEmprunts = 238;
                    int empruntsActifs = 42;
                    
                    try {
                        // Code pour récupérer les données réelles
                        /* Connection conn = ... votre connexion à la base de données
                        Statement stmt = conn.createStatement();
                        
                        ResultSet rsLivres = stmt.executeQuery("SELECT COUNT(*) FROM livres");
                        if (rsLivres.next()) {
                            totalLivres = rsLivres.getInt(1);
                        }
                        
                        ResultSet rsLecteurs = stmt.executeQuery("SELECT COUNT(*) FROM lecteurs");
                        if (rsLecteurs.next()) {
                            totalLecteurs = rsLecteurs.getInt(1);
                        }
                        
                        ResultSet rsTotalEmprunts = stmt.executeQuery("SELECT COUNT(*) FROM emprunts");
                        if (rsTotalEmprunts.next()) {
                            totalEmprunts = rsTotalEmprunts.getInt(1);
                        }
                        
                        ResultSet rsEmpruntsActifs = stmt.executeQuery("SELECT COUNT(*) FROM emprunts WHERE date_retour IS NULL");
                        if (rsEmpruntsActifs.next()) {
                            empruntsActifs = rsEmpruntsActifs.getInt(1);
                        }
                        */
                    } catch (Exception e) {
                        out.println("Erreur lors de la récupération des données: " + e.getMessage());
                    }
                %>
                
                <div class="stats-card">
                    <div class="stats-card-title">Total des Livres</div>
                    <div class="stats-card-value"><%= totalLivres %></div>
                    <div class="stats-card-info">Dans la collection</div>
                </div>
                
                <div class="stats-card">
                    <div class="stats-card-title">Total des Lecteurs</div>
                    <div class="stats-card-value"><%= totalLecteurs %></div>
                    <div class="stats-card-info">Inscrits à la bibliothèque</div>
                </div>
                
                <div class="stats-card">
                    <div class="stats-card-title">Total des Emprunts</div>
                    <div class="stats-card-value"><%= totalEmprunts %></div>
                    <div class="stats-card-info">Depuis l'ouverture</div>
                </div>
                
                <div class="stats-card">
                    <div class="stats-card-title">Emprunts Actifs</div>
                    <div class="stats-card-value"><%= empruntsActifs %></div>
                    <div class="stats-card-info">En cours actuellement</div>
                </div>
            </div>
            
            <!-- Graphique des tendances d'emprunts mensuelle -->
            <div class="chart-container">
                <h3 class="chart-title">Tendance des emprunts par mois</h3>
                <canvas id="empruntsChart"></canvas>
            </div>
            
            <!-- Répartition des livres par catégorie -->
            <div class="bar-chart">
                <h3 class="chart-title">Répartition des livres par catégorie</h3>
                <%
                    // Simulation de données de catégories
                    Map<String, Integer> categories = new HashMap<>();
                    categories.put("Roman", 120);
                    categories.put("Science-Fiction", 85);
                    categories.put("Histoire", 65);
                    categories.put("Jeunesse", 95);
                    categories.put("Sciences", 45);
                    categories.put("Art", 40);
                    
                    // Calculer le maximum pour normaliser les barres
                    int maxCount = 0;
                    for (int count : categories.values()) {
                        if (count > maxCount) maxCount = count;
                    }
                    
                    // Afficher les barres pour chaque catégorie
                    for (Map.Entry<String, Integer> entry : categories.entrySet()) {
                        String category = entry.getKey();
                        int count = entry.getValue();
                        double percentage = (count * 100.0) / maxCount;
                %>
                <div class="bar-item">
                    <div class="bar-label">
                        <span class="bar-name"><%= category %></span>
                        <span class="bar-value"><%= count %> livres</span>
                    </div>
                    <div class="bar-container">
                        <div class="bar" style="width: <%= percentage %>%;"></div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
        
        <!-- Section Statistiques Livres -->
        <div id="livres" class="stats-section">
            <h2 class="chart-title">Statistiques détaillées sur les livres</h2>
            
            <div class="stats-grid">
                <div class="stats-card">
                    <div class="stats-card-title">Livres Disponibles</div>
                    <div class="stats-card-value"><%= totalLivres - empruntsActifs %></div>
                    <div class="stats-card-info">Actuellement en rayon</div>
                </div>
                
                <div class="stats-card">
                    <div class="stats-card-title">Livres Empruntés</div>
                    <div class="stats-card-value"><%= empruntsActifs %></div>
                    <div class="stats-card-info">Actuellement en prêt</div>
                </div>
                
                <div class="stats-card">
                    <div class="stats-card-title">Taux d'Occupation</div>
                    <div class="stats-card-value"><%= Math.round((empruntsActifs * 100.0) / totalLivres) %>%</div>
                    <div class="stats-card-info">Des livres sont empruntés</div>
                </div>
                
                <div class="stats-card">
                    <div class="stats-card-title">Âge Moyen</div>
                    <div class="stats-card-value">6.3</div>
                    <div class="stats-card-info">Années depuis l'acquisition</div>
                </div>
            </div>
            
            <!-- Livres les plus populaires -->
            <h3 class="chart-title">Les 10 livres les plus empruntés</h3>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Titre</th>
                        <th>Auteur</th>
                        <th>Catégorie</th>
                        <th>Emprunts</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Données simulées de livres populaires
                        String[][] topLivres = {
                            {"Le Petit Prince", "Antoine de Saint-Exupéry", "Jeunesse", "42"},
                            {"1984", "George Orwell", "Science-Fiction", "38"},
                            {"Harry Potter à l'école des sorciers", "J.K. Rowling", "Jeunesse", "35"},
                            {"Les Misérables", "Victor Hugo", "Roman", "30"},
                            {"Le Seigneur des Anneaux", "J.R.R. Tolkien", "Fantasy", "28"},
                            {"Astérix et Obélix", "René Goscinny", "BD", "26"},
                            {"L'Étranger", "Albert Camus", "Roman", "25"},
                            {"Dune", "Frank Herbert", "Science-Fiction", "24"},
                            {"Notre-Dame de Paris", "Victor Hugo", "Roman", "22"},
                            {"Le Comte de Monte-Cristo", "Alexandre Dumas", "Roman", "20"}
                        };
                        
                        for (String[] livre : topLivres) {
                    %>
                    <tr>
                        <td><%= livre[0] %></td>
                        <td><%= livre[1] %></td>
                        <td><%= livre[2] %></td>
                        <td><%= livre[3] %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            
            <!-- Visualisation des livres par année de publication -->
            <div class="chart-container">
                <h3 class="chart-title">Livres par année de publication</h3>
                <canvas id="anneePublicationChart"></canvas>
            </div>
        </div>
        
        <!-- Section Statistiques Lecteurs -->
        <div id="lecteurs" class="stats-section">
            <h2 class="chart-title">Statistiques détaillées sur les lecteurs</h2>
            
            <div class="stats-grid">
                <div class="stats-card">
                    <div class="stats-card-title">Lecteurs Actifs</div>
                    <div class="stats-card-value">124</div>
                    <div class="stats-card-info">Avec au moins un emprunt récent</div>
                </div>
                
                <div class="stats-card">
                    <div class="stats-card-title">Nouveaux Lecteurs</div>
                    <div class="stats-card-value">28</div>
                    <div class="stats-card-info">Inscrits ce mois-ci</div>
                </div>
                
                <div class="stats-card">
                    <div class="stats-card-title">Âge Moyen</div>
                    <div class="stats-card-value">34</div>
                    <div class="stats-card-info">Des lecteurs inscrits</div>
                </div>
                
                <div class="stats-card">
                    <div class="stats-card-title">Emprunts Par Lecteur</div>
                    <div class="stats-card-value">3.2</div>
                    <div class="stats-card-info">En moyenne par an</div>
                </div>
            </div>
            
            <!-- Répartition par tranche d'âge -->
            <div class="pie-chart">
                <h3 class="chart-title">Répartition des lecteurs par tranche d'âge</h3>
                <div class="chart-container">
                    <canvas id="ageChart"></canvas>
                </div>
            </div>
            
            <!-- Lecteurs les plus actifs -->
            <h3 class="chart-title">Les 5 lecteurs les plus actifs</h3>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Nom</th>
                        <th>Emprunts totaux</th>
                        <th>Dernière activité</th>
                        <th>Catégories préférées</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Données simulées des lecteurs les plus actifs
                        String[][] topLecteurs = {
                            {"Marie Dupont", "42", "03/05/2025", "Roman, Jeunesse"},
                            {"Jean Martin", "38", "28/04/2025", "Science-Fiction, Fantasy"},
                            {"Sophie Dubois", "31", "05/05/2025", "Histoire, Art"},
                            {"Lucas Petit", "27", "01/05/2025", "BD, Roman"},
                            {"Emma Bernard", "24", "30/04/2025", "Sciences, Roman"}
                        };
                        
                        for (String[] lecteur : topLecteurs) {
                    %>
                    <tr>
                        <td><%= lecteur[0] %></td>
                        <td><%= lecteur[1] %></td>
                        <td><%= lecteur[2] %></td>
                        <td><%= lecteur[3] %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        
        <!-- Section Statistiques Emprunts -->
        <div id="emprunts" class="stats-section">
            <h2 class="chart-title">Statistiques détaillées sur les emprunts</h2>
            
            <div class="stats-grid">
                <div class="stats-card">
                    <div class="stats-card-title">Emprunts Mensuels</div>
                    <div class="stats-card-value">68</div>
                    <div class="stats-card-info">En moyenne</div>
                </div>
                
                <div class="stats-card">
                    <div class="stats-card-title">Durée Moyenne</div>
                    <div class="stats-card-value">18</div>
                    <div class="stats-card-info">Jours par emprunt</div>
                </div>
                
                <div class="stats-card">
                    <div class="stats-card-title">Taux de Retard</div>
                    <div class="stats-card-value">12%</div>
                    <div class="stats-card-info">Des retours sont en retard</div>
                </div>
                
                <div class="stats-card">
                    <div class="stats-card-title">Retards Actuels</div>
                    <div class="stats-card-value">5</div>
                    <div class="stats-card-info">Livres en retard</div>
                </div>
            </div>
            
            <!-- Graphique des emprunts par jour de la semaine -->
            <div class="chart-container">
                <h3 class="chart-title">Emprunts par jour de la semaine</h3>
                <canvas id="jourSemaineChart"></canvas>
            </div>
            
            <!-- Évolution des emprunts sur l'année -->
            <div class="chart-container">
                <h3 class="chart-title">Évolution des emprunts sur l'année</h3>
                <canvas id="evolutionAnnuelleChart"></canvas>
            </div>
            
            <!-- Derniers emprunts -->
            <h3 class="chart-title">Les 10 derniers emprunts</h3>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Titre</th>
                        <th>Lecteur</th>
                        <th>Retour prévu</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Simulation des derniers emprunts
                        String[][] derniersEmprunts = {
                            {"10/05/2025", "L'Art de la Guerre", "Thomas Durant", "31/05/2025"},
                            {"09/05/2025", "Les Fourmis", "Julie Leroux", "30/05/2025"},
                            {"09/05/2025", "Le Parfum", "Nicolas Martin", "30/05/2025"},
                            {"08/05/2025", "Le Mythe de Sisyphe", "Sophie Dubois", "29/05/2025"},
                            {"07/05/2025", "Sapiens", "Jean Martin", "28/05/2025"},
                            {"07/05/2025", "Le Hobbit", "Lucas Petit", "28/05/2025"},
                            {"06/05/2025", "La Ferme des Animaux", "Marie Dupont", "27/05/2025"},
                            {"06/05/2025", "Fondation", "Emma Bernard", "27/05/2025"},
                            {"05/05/2025", "Le Meilleur des Mondes", "Thomas Durant", "26/05/2025"},
                            {"05/05/2025", "Crime et Châtiment", "Julie Leroux", "26/05/2025"}
                        };
                        
                        for (String[] emprunt : derniersEmprunts) {
                    %>
                    <tr>
                        <td><%= emprunt[0] %></td>
                        <td><%= emprunt[1] %></td>
                        <td><%= emprunt[2] %></td>
                        <td><%= emprunt[3] %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
    
    <footer>
        <p>© <%= LocalDate.now().getYear() %> Système de Gestion de Bibliothèque - Tous droits réservés</p>
    </footer>
    
    <!-- Importation du JavaScript depuis un fichier externe -->
    <script src="js/stat.js"></script>
</body>
</html>