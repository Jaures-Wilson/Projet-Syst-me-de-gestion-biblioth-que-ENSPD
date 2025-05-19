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
    <style>
        /* Importation des polices */
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');
        
        /* Variables pour les couleurs et l'apparence */
        :root {
            --primary-color: #003366;
            --secondary-color: #00509e;
            --accent-color: #f0c75e;
            --text-color: #333;
            --light-text: #fff;
            --bg-color: #f5f5f5;
            --card-bg: #fff;
            --shadow: 0 8px 20px rgba(0,0,0,0.1);
            --border-radius: 10px;
            --header-height: 80px;
            --chart-blue: #2980b9;
            --chart-green: #27ae60;
            --chart-orange: #f39c12;
            --chart-red: #e74c3c;
            --chart-purple: #8e44ad;
        }
        
        /* Réinitialisation des styles et base */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: var(--bg-color);
            color: var(--text-color);
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            position: relative;
            padding-bottom: 60px; /* Espace pour le footer */
        }
        
        /* En-tête avec dégradé */
        header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            padding: 20px;
            color: var(--light-text);
            text-align: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            position: relative;
            overflow: hidden;
            border-bottom: 3px solid var(--accent-color);
            animation: fadeInDown 0.8s ease-out;
        }
        
        header:before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotateBackground 20s linear infinite;
        }
        
        @keyframes rotateBackground {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        header h1 {
            position: relative;
            font-size: 2.5rem;
            margin: 0;
            padding: 10px 0;
            letter-spacing: 1px;
            text-transform: uppercase;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            z-index: 1;
        }
        
        /* Conteneur principal */
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
            background: var(--card-bg);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            position: relative;
            z-index: 1;
            animation: fadeIn 1s ease-out;
        }
        
        /* Bouton de retour au menu */
        .back-btn {
            display: inline-flex;
            align-items: center;
            margin-bottom: 20px;
            padding: 10px 20px;
            background: var(--primary-color);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .back-btn:before {
            content: "← ";
            margin-right: 8px;
        }
        
        .back-btn:hover {
            background: var(--secondary-color);
            transform: translateX(-5px);
        }
        
        /* Navigation des statistiques */
        .stats-nav {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
            border-bottom: 1px solid rgba(0,0,0,0.1);
            padding-bottom: 10px;
        }
        
        .stats-nav-item {
            margin: 0 15px;
            padding: 10px 20px;
            cursor: pointer;
            border-bottom: 3px solid transparent;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .stats-nav-item.active {
            border-bottom: 3px solid var(--accent-color);
            color: var(--primary-color);
        }
        
        .stats-nav-item:hover:not(.active) {
            border-bottom: 3px solid rgba(240,199,94,0.5);
        }
        
        /* Sections des statistiques */
        .stats-section {
            display: none;
            animation: fadeIn 0.5s ease-out;
        }
        
        .stats-section.active {
            display: block;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stats-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        
        .stats-card-title {
            font-size: 1rem;
            color: var(--text-color);
            margin-bottom: 15px;
            font-weight: 500;
        }
        
        .stats-card-value {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 10px;
        }
        
        .stats-card-info {
            font-size: 0.9rem;
            color: #666;
        }
        
        /* Section graphiques */
        .chart-container {
            margin: 30px 0;
            height: 400px;
            position: relative;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            background: white;
            padding: 20px;
        }
        
        .chart-title {
            text-align: center;
            margin-bottom: 20px;
            font-size: 1.2rem;
            color: var(--primary-color);
        }
        
        /* Tables de données */
        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin: 30px 0;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .data-table th, .data-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .data-table th {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            color: white;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 0.9rem;
            letter-spacing: 1px;
        }
        
        .data-table tr:hover {
            background: rgba(0,0,0,0.02);
        }
        
        .data-table tr:last-child td {
            border-bottom: none;
        }
        
        /* Barre graphique simple */
        .bar-chart {
            margin: 40px 0;
            padding: 0 20px;
        }
        
        .bar-item {
            margin-bottom: 20px;
        }
        
        .bar-label {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
        }
        
        .bar-name {
            font-weight: 500;
        }
        
        .bar-value {
            color: var(--primary-color);
            font-weight: 600;
        }
        
        .bar-container {
            height: 20px;
            background: #eee;
            border-radius: 10px;
            overflow: hidden;
        }
        
        .bar {
            height: 100%;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border-radius: 10px;
            transition: width 1s ease-out;
        }
        
        /* Simuler SVG pour les représentations graphiques */
        .pie-chart {
            display: flex;
            justify-content: center;
            margin: 30px 0;
        }
        
        .pie-container {
            position: relative;
            width: 200px;
            height: 200px;
        }
        
        .pie-slice {
            position: absolute;
            width: 100%;
            height: 100%;
            clip-path: polygon(50% 50%, 100% 0, 100% 100%);
            transform-origin: center;
        }
        
        .pie-legend {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }
        
        .legend-item {
            display: flex;
            align-items: center;
        }
        
        .legend-color {
            width: 15px;
            height: 15px;
            margin-right: 8px;
            border-radius: 3px;
        }
        
        /* Footer */
        footer {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            color: var(--light-text);
            text-align: center;
            padding: 15px;
            position: absolute;
            bottom: 0;
            width: 100%;
            animation: fadeInUp 1s ease-out;
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        @keyframes fadeInDown {
            from { 
                opacity: 0;
                transform: translateY(-20px);
            }
            to { 
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes fadeInUp {
            from { 
                opacity: 0;
                transform: translateY(20px);
            }
            to { 
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        /* Médias queries pour la réactivité */
        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .stats-nav {
                flex-direction: column;
                align-items: center;
            }
            
            .stats-nav-item {
                margin: 5px 0;
            }
            
            header h1 {
                font-size: 2rem;
            }
            
            .container {
                margin: 20px 10px;
                padding: 15px;
            }
            
            .chart-container {
                height: 300px;
            }
        }
    </style>
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
    
    <!-- Importation de Chart.js pour les graphiques -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
    
    <script>
        // Fonction pour naviguer entre les différentes sections
        function showSection(sectionId) {
            // Cacher toutes les sections
            document.querySelectorAll('.stats-section').forEach(section => {
                section.classList.remove('active');
            });
            
            // Afficher la section sélectionnée
            document.getElementById(sectionId).classList.add('active');
            
            // Mettre à jour la navigation
            document.querySelectorAll('.stats-nav-item').forEach(item => {
                item.classList.remove('active');
            });
            
            // Trouver l'élément de navigation correspondant à la section
            document.querySelectorAll('.stats-nav-item').forEach(item => {
                if (item.textContent.toLowerCase().includes(sectionId) || 
                    (sectionId === 'general' && item.textContent.includes('Vue Générale'))) {
                    item.classList.add('active');
                }
            });
        }
        
        // Initialisation des graphiques après le chargement de la page
        document.addEventListener('DOMContentLoaded', function() {
            // Graphique des tendances d'emprunts mensuels
            const empruntsCtx = document.getElementById('empruntsChart').getContext('2d');
            const empruntsChart = new Chart(empruntsCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'],
                    datasets: [{
                        label: 'Nombre d\'emprunts',
                        data: [42, 38, 52, 45, 56, 62, 48, 54, 60, 65, 58, 63],
                        backgroundColor: 'rgba(0, 80, 158, 0.2)',
                        borderColor: 'rgba(0, 80, 158, 1)',
                        borderWidth: 2,
                        tension: 0.3,
                        pointBackgroundColor: 'rgba(0, 80, 158, 1)',
                        pointRadius: 4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        tooltip: {
                            backgroundColor: 'rgba(0, 51, 102, 0.8)',
                            padding: 10,
                            cornerRadius: 6
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(0, 0, 0, 0.05)'
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });
            
            // Graphique des livres par année de publication
            const anneePublicationCtx = document.getElementById('anneePublicationChart').getContext('2d');
            const anneePublicationChart = new Chart(anneePublicationCtx, {
                type: 'bar',
                data: {
                    labels: ['Avant 1950', '1950-1970', '1970-1990', '1990-2000', '2000-2010', '2010-2020', 'Après 2020'],
                    datasets: [{
                        label: 'Nombre de livres',
                        data: [35, 48, 85, 92, 105, 65, 20],
                        backgroundColor: [
                            'rgba(41, 128, 185, 0.7)',
                            'rgba(39, 174, 96, 0.7)',
                            'rgba(243, 156, 18, 0.7)',
                            'rgba(231, 76, 60, 0.7)',
                            'rgba(142, 68, 173, 0.7)',
                            'rgba(52, 152, 219, 0.7)',
                            'rgba(22, 160, 133, 0.7)'
                        ],
                        borderColor: 'rgba(255, 255, 255, 0.5)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Nombre de livres',
                                font: {
                                    size: 14,
                                    weight: 'bold'
                                }
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Période de publication',
                                font: {
                                    size: 14,
                                    weight: 'bold'
                                }
                            }
                        }
                    }
                }
            });
            
            // Graphique de la répartition des lecteurs par tranche d'âge
            const ageCtx = document.getElementById('ageChart').getContext('2d');
            const ageChart = new Chart(ageCtx, {
                type: 'doughnut',
                data: {
                    labels: ['< 18 ans', '18-25 ans', '26-40 ans', '41-60 ans', '> 60 ans'],
                    datasets: [{
                        data: [45, 38, 52, 32, 20],
                        backgroundColor: [
                            'rgba(41, 128, 185, 0.7)',
                            'rgba(39, 174, 96, 0.7)',
                            'rgba(243, 156, 18, 0.7)',
                            'rgba(231, 76, 60, 0.7)',
                            'rgba(142, 68, 173, 0.7)'
                        ],
                        borderColor: 'rgba(255, 255, 255, 0.8)',
                        borderWidth: 2
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'right'
                        },
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    let label = context.label || '';
                                    let value = context.raw || 0;
                                    let sum = context.dataset.data.reduce((a, b) => a + b, 0);
                                    let percentage = Math.round((value / sum) * 100);
                                    return `${label}: ${value} (${percentage}%)`;
                                }
                            }
                        }
                    }
                }
            });
            
            // Graphique des emprunts par jour de la semaine
            const jourSemaineCtx = document.getElementById('jourSemaineChart').getContext('2d');
            const jourSemaineChart = new Chart(jourSemaineCtx, {
                type: 'bar',
                data: {
                    labels: ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'],
                    datasets: [{
                        label: 'Nombre d\'emprunts',
                        data: [32, 28, 65, 34, 38, 75, 12],
                        backgroundColor: 'rgba(0, 51, 102, 0.7)',
                        borderColor: 'rgba(0, 51, 102, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    indexAxis: 'y',
                    scales: {
                        x: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(0, 0, 0, 0.05)'
                            }
                        },
                        y: {
                            grid: {
                                display: false
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });
            
            // Graphique de l'évolution des emprunts sur l'année
            const evolutionAnnuelleCtx = document.getElementById('evolutionAnnuelleChart').getContext('2d');
            const evolutionAnnuelleChart = new Chart(evolutionAnnuelleCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'],
                    datasets: [
                        {
                            label: '2024',
                            data: [36, 32, 45, 48, 52, 58, 45, 38, 55, 60, 55, 62],
                            backgroundColor: 'rgba(41, 128, 185, 0.2)',
                            borderColor: 'rgba(41, 128, 185, 1)',
                            borderWidth: 2,
                            tension: 0.3
                        },
                        {
                            label: '2025',
                            data: [42, 38, 52, 45, 56, 62, null, null, null, null, null, null],
                            backgroundColor: 'rgba(243, 156, 18, 0.2)',
                            borderColor: 'rgba(243, 156, 18, 1)',
                            borderWidth: 2,
                            tension: 0.3
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        tooltip: {
                            mode: 'index',
                            intersect: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Nombre d\'emprunts'
                            }
                        }
                    }
                }
            });
        });
        
        // Animation des barres au chargement de la page
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(function() {
                document.querySelectorAll('.bar').forEach(bar => {
                    const width = bar.style.width;
                    bar.style.width = '0';
                    setTimeout(() => {
                        bar.style.width = width;
                    }, 100);
                });
            }, 300);
        });
    </script>