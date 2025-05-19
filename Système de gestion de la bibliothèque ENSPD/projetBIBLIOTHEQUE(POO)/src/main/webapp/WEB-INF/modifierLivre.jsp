<!-- Définition du type de contenu de la page (encodage) -->
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- Déclaration de la bibliothèque JSTL pour utiliser les balises c: -->

<!DOCTYPE html>
<html lang="en"> <!-- Définition du langage de la page -->
<head>
<meta charset="UTF-8"> <!-- Encodage UTF-8 pour gérer les caractères spéciaux -->
<meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Paramètre pour une vue adaptée aux appareils mobiles -->
<title>Modification de livre</title> <!-- Titre de la page -->
<style>
    /* CSS Variables for consistent styling */
    :root {
        --primary-color: #003366;
        --secondary-color: #6699cc;
        --accent-color: #ffcc00;
        --light-color: #f5f5f5;
        --dark-color: #333333;
        --success-color: #5cb85c;
        --warning-color: #f0ad4e;
        --danger-color: #d9534f;
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
        margin: 0 auto;
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
    
    .header h1 {
        margin: 0;
        color: white;
    }
    
    /* Navigation */
    .home-link {
        display: inline-block;
        margin-bottom: 20px;
    }
    
    .home-link a {
        color: var(--primary-color);
        text-decoration: none;
        font-weight: bold;
        font-size: 18px;
        padding: 10px 20px;
        border-radius: 5px;
        background-color: white;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
    }
    
    .home-link a:hover {
        background-color: var(--primary-color);
        color: white;
    }
    
    /* Typography */
    h1 {
        color: var(--primary-color);
        margin-bottom: 15px;
        font-size: 24px;
    }
    
    h3 {
        color: var(--dark-color);
        margin-bottom: 20px;
        padding: 15px;
        border-radius: 5px;
        background-color: #f8f9fa;
        border-left: 4px solid var(--secondary-color);
    }
    
    strong {
        color: var(--warning-color);
        font-weight: bold;
    }
    
    /* Form Styles */
    .form-container {
        background-color: #f9f9f9;
        padding: 25px;
        border-radius: 8px;
        border: 1px solid var(--border-color);
        margin-top: 20px;
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
    
    input[type="text"],
    input[type="date"],
    input[type="number"] {
        width: 100%;
        padding: 12px;
        border: 1px solid var(--border-color);
        border-radius: 4px;
        font-size: 16px;
        transition: border-color 0.3s;
    }
    
    input[type="text"]:focus,
    input[type="date"]:focus,
    input[type="number"]:focus {
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
    
    /* Error Message */
    .error-message {
        color: var(--danger-color);
        background-color: #f8d7da;
        padding: 10px 15px;
        border-radius: 4px;
        margin-top: 20px;
        border-left: 4px solid var(--danger-color);
    }
    
    /* Required field indicator */
    .required::after {
        content: " *";
        color: var(--danger-color);
    }
    
    /* Responsive */
    @media (max-width: 768px) {
        .container {
            padding: 20px;
        }
        
        .form-container {
            padding: 15px;
        }
    }
</style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1>Système de Gestion de Bibliothèque</h1>
    </div>
    
    <div class="home-link">
        <!-- Lien pour revenir à la page d'accueil -->
        <a href="lancerProjet">ACCUEIL</a>
    </div>
    
    <!-- Titre de la section de modification du livre -->
    <h1>Modifier un livre</h1>
    
    <!-- Vérification du nombre d'emprunts d'un livre (affichage conditionnel) -->
    <!-- Si le nombre d'emprunts est égal à 0 -->
    <c:if test="${nombreEmpruntIsbn == 0}">
        <h3>Le livre que vous avez pris n'a pas encore été emprunté</h3>
    </c:if>
    
    <!-- Si le nombre d'emprunts est supérieur à 0 -->
    <c:if test="${nombreEmpruntIsbn > 0}">
        <h3>Le livre que vous avez pris a déjà été emprunté <strong>${nombreEmpruntIsbn} fois,</strong> c'est donc la valeur minimale que peut prendre le total d'exemplaires</h3>
    </c:if>
    
    <div class="form-container">
        <!-- Formulaire permettant de modifier les informations du livre -->
        <form method="post" action="modifierLivre">
            <div class="form-group">
                <label for="isbn" class="required">ISBN:</label>
                <!-- Champ pour l'ISBN, avec la valeur initiale récupérée depuis ${livre.isbn} -->
                <input type="text" id="isbn" value="${livre.isbn}" name="isbn" required>
            </div>
            
            <div class="form-group">
                <label for="titre" class="required">Titre:</label>
                <!-- Champ pour le titre, avec la valeur initiale récupérée depuis ${livre.titre} -->
                <input type="text" id="titre" value="${livre.titre}" name="titre" required>
            </div>
            
            <div class="form-group">
                <label for="auteur" class="required">Auteur:</label>
                <!-- Champ pour l'auteur, avec la valeur initiale récupérée depuis ${livre.auteur} -->
                <input type="text" id="auteur" value="${livre.auteur}" name="auteur" required>
            </div>
            
            <div class="form-group">
                <label for="datePub" class="required">Date Publication:</label>
                <!-- Champ pour la date de publication, avec la valeur initiale récupérée depuis ${livre.datePublication} -->
                <input type="date" id="datePub" value="${livre.datePublication}" name="datePublication" required>
            </div>
            
            <div class="form-group">
                <label for="totalExemplaire" class="required">Total d'exemplaires:</label>
                <!-- Champ pour le nombre total d'exemplaires, avec une restriction sur la valeur minimale -->
                <input type="number" id="totalExemplaire" value="${livre.totalExemplaire}" name="totalExemplaire" min="${nombreEmpruntIsbn}" required>
            </div>
            
            <!-- Bouton de soumission du formulaire -->
            <input type="submit" value="Modifier">
        </form>
    </div>
    
    <!-- Message d'erreur pour date invalide -->
    <c:if test="${not isDateValid}">
        <div class="error-message">
            La date entrée est invalide car elle doit être inférieure à la date du jour !
        </div>
    </c:if>
</div>

</body>
</html>