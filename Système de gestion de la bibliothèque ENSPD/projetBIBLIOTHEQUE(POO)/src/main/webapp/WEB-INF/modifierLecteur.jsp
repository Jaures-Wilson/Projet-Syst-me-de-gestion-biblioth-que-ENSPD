<%@ page contentType="text/html; charset=UTF-8" language="java" %> <!-- Définition du type de contenu de la page avec encodage UTF-8 -->
<!DOCTYPE html>
<html lang="en"> <!-- Définition du langage de la page -->
<head>
<meta charset="UTF-8"> <!-- Encodage UTF-8 pour gérer les caractères spéciaux -->
<meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Paramètre pour une vue adaptée aux appareils mobiles -->
<title>Modification de lecteur</title> <!-- Titre de la page -->
<style>
    /* CSS Variables for consistent styling */
    :root {
        --primary-color: #003366;
        --secondary-color: #6699cc;
        --accent-color: #ffcc00;
        --light-color: #f5f5f5;
        --dark-color: #333333;
        --success-color: #5cb85c;
        --border-color: #ddd;
    }
    
    /* Global Styles */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    body {
        background-color: var(--light-color);
        color: var(--dark-color);
        line-height: 1.6;
        padding: 20px;
    }
    
    /* Container */
    .container {
        max-width: 800px;
        margin: 20px auto;
        background-color: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    
    /* Header */
    .header {
        background-color: var(--primary-color);
        color: white;
        padding: 15px 20px;
        border-radius: 5px;
        margin-bottom: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    /* Typography */
    h1, h2 {
        color: var(--primary-color);
        margin-bottom: 15px;
    }
    
    h1 {
        font-size: 24px;
    }
    
    h2 {
        font-size: 20px;
        padding-bottom: 10px;
        border-bottom: 1px solid var(--border-color);
        margin-bottom: 20px;
    }
    
    /* Navigation */
    .nav-links {
        display: flex;
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .nav-links a {
        color: var(--primary-color);
        text-decoration: none;
        font-weight: bold;
        padding: 8px 15px;
        border-radius: 5px;
        background-color: white;
        transition: all 0.3s ease;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    
    .nav-links a:hover {
        background-color: var(--primary-color);
        color: white;
        transform: translateY(-2px);
    }
    
    /* Form Styles */
    .form-container {
        background-color: #f9f9f9;
        padding: 25px;
        border-radius: 8px;
        border: 1px solid var(--border-color);
    }
    
    .form-group {
        margin-bottom: 20px;
    }
    
    label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: var(--dark-color);
    }
    
    input[type="text"] {
        width: 100%;
        padding: 12px;
        border: 1px solid var(--border-color);
        border-radius: 4px;
        font-size: 16px;
        transition: border-color 0.3s;
    }
    
    input[type="text"]:focus {
        border-color: var(--secondary-color);
        outline: none;
        box-shadow: 0 0 5px rgba(102, 153, 204, 0.5);
    }
    
    input[type="submit"] {
        background-color: var(--primary-color);
        color: white;
        border: none;
        padding: 12px 24px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        font-weight: bold;
        transition: all 0.3s ease;
        margin-top: 10px;
    }
    
    input[type="submit"]:hover {
        background-color: var(--secondary-color);
        transform: translateY(-2px);
    }
    
    /* Responsive */
    @media (max-width: 768px) {
        .container {
            padding: 20px;
        }
        
        .nav-links {
            flex-direction: column;
            gap: 10px;
        }
    }
    
    /* Required field indicator */
    .required::after {
        content: " *";
        color: #d9534f;
    }
</style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1>Système de Gestion de Bibliothèque</h1>
    </div>
    
    <div class="nav-links">
        <!-- Lien pour revenir à la page d'accueil -->
        <a href="lancerProjet">ACCUEIL</a>
        
        <!-- Lien pour se déconnecter -->
        <a href="lancerProjet?page=deconnexion.jsp">Déconnexion</a>
    </div>
    
    <!-- Titre de la section de modification du lecteur -->
    <h2>Modifier un lecteur</h2>
    
    <div class="form-container">
        <!-- Formulaire permettant de modifier les informations du lecteur -->
        <form method="post" action="ModifierLecteur">
            <div class="form-group">
                <label for="nomLecteur" class="required">Nom du Lecteur:</label>
                <!-- Champ pour le nom du lecteur, avec la valeur initiale récupérée depuis l'attribut ${lecteur.nomLecteur} -->
                <input type="text" id="nomLecteur" value="${lecteur.nomLecteur}" name="nomLecteur" required>
            </div>
            
            <div class="form-group">
                <label for="adresseLecteur" class="required">Adresse du Lecteur:</label>
                <!-- Champ pour l'adresse du lecteur, avec la valeur initiale récupérée depuis ${lecteur.adresseLecteur} -->
                <input type="text" id="adresseLecteur" value="${lecteur.adresseLecteur}" name="adresseLecteur" required>
            </div>
            
            <div class="form-group">
                <label for="numeroCNI" class="required">Numéro de CNI:</label>
                <!-- Champ pour le numéro de CNI, avec la valeur initiale récupérée depuis ${lecteur.numeroCNI} -->
                <input type="text" id="numeroCNI" value="${lecteur.numeroCNI}" name="numeroCNI" required>
            </div>
            
            <!-- Bouton de soumission du formulaire -->
            <input type="submit" value="Modifier">
        </form>
    </div>
</div>

</body>
</html>