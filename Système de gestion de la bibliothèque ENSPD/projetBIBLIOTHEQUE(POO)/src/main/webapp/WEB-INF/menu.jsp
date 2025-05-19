<%@ page contentType="text/html; charset=UTF-8" language="java" %> <!-- Définition du type de contenu de la page avec encodage UTF-8 -->
<!DOCTYPE html>
<html>
<head>
    <title>Menu</title> <!-- Titre de la page -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <link rel="stylesheet" href="CSS/menu.css">
</head>
<body>
    <!-- En-tête avec titre principal -->
    <header>
        <h1>Menu Principal</h1> <!-- Titre principal du menu -->
    </header>
    
    <div class="container">        
        <!-- Menu avec icônes et effets -->
        <div class="menu-container">
            <h2 class="menu-title">Navigation du système</h2>
            
            <!-- Liste des options du menu sous forme de cartes cliquables -->
            <ul class="menu-list">
                <!-- Lien pour accéder à la gestion des livres -->
                <li class="menu-item">
                    <a href="lancerProjet?page=livres.jsp" class="menu-link">
                        <div class="menu-icon"></div>
                        <span class="menu-text">Gestion des Livres</span>
                    </a>
                </li>
                
                <!-- Lien pour accéder à la gestion des lecteurs -->
                <li class="menu-item">
                    <a href="lancerProjet?page=lecteurs.jsp" class="menu-link">
                        <div class="menu-icon"></div>
                        <span class="menu-text">Gestion des Lecteurs</span>
                    </a>
                </li>
                
                <!-- Lien pour accéder à la gestion des emprunts -->
                <li class="menu-item">
                    <a href="lancerProjet?page=emprunts.jsp" class="menu-link">
                        <div class="menu-icon"></div>
                        <span class="menu-text">Gestion des Emprunts</span>
                    </a>
                </li>
                
                <!-- Lien pour accéder aux statistiques -->
                <li class="menu-item">
                    <a href="lancerProjet?page=stat.jsp" class="menu-link">
                        <div class="menu-icon"></div>
                        <span class="menu-text">Statistiques</span>
                    </a>
                </li>
            </ul>
        </div>
        
        <!-- Bouton de déconnexion stylisé (maintenant en bas) -->
        <div class="logout-container">
            <a href="lancerProjet?page=deconnexion.jsp" class="logout-btn">Deconnexion</a>
        </div>
    </div>
    
    <!-- Footer simple -->
    <footer>
        &copy; ${java.time.Year.now().getValue()} Bibliothèque ENSPD - Tous droits réservés
    </footer>
</body>
</html>