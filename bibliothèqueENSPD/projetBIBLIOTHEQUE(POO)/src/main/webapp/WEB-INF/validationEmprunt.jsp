<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <!-- Définition de l'encodage des caractères UTF-8 -->
<title>Validation du retour de l'emprunt</title> <!-- Titre de la page -->
<style>
    /* CSS Variables for consistent styling */
    :root {
        --primary-color: #003366;
        --secondary-color: #6699cc;
        --accent-color: #ffcc00;
        --light-color: #f5f5f5;
        --dark-color: #333333;
        --success-color: #5cb85c;
        --danger-color: #d9534f;
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
        display: flex;
        flex-direction: column;
        align-items: center;
        min-height: 100vh;
    }
    
    /* Container */
    .container {
        max-width: 800px;
        width: 100%;
        background-color: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        margin-top: 20px;
        text-align: center;
    }
    
    /* Typography */
    h1 {
        color: var(--primary-color);
        margin: 20px 0;
        font-size: 24px;
        font-weight: bold;
        text-align: center;
    }
    
    h2 {
        color: var(--secondary-color);
        margin: 15px 0 5px 0;
        font-size: 20px;
    }
    
    h3 {
        color: var(--dark-color);
        background-color: #f0f5fa;
        padding: 12px;
        margin: 10px 0 20px 0;
        border-radius: 5px;
        font-size: 18px;
        border-left: 4px solid var(--secondary-color);
    }
    
    /* Header */
    .header {
        background-color: var(--primary-color);
        color: white;
        padding: 15px 20px;
        border-radius: 5px;
        margin-bottom: 20px;
        width: 100%;
        max-width: 800px;
        text-align: center;
    }
    
    .header h1 {
        color: white;
        margin: 0;
    }
    
    /* Form Styles */
    .buttons-container {
        display: flex;
        justify-content: center;
        gap: 20px;
        margin-top: 30px;
    }
    
    form {
        margin: 10px 0;
    }
    
    input[type="submit"] {
        padding: 12px 30px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        font-weight: bold;
        transition: all 0.3s ease;
    }
    
    input[type="submit"][value="OUI"] {
        background-color: var(--success-color);
        color: white;
    }
    
    input[type="submit"][value="OUI"]:hover {
        background-color: #4cae4c;
        transform: translateY(-2px);
    }
    
    input[type="submit"][value="NON"] {
        background-color: var(--danger-color);
        color: white;
    }
    
    input[type="submit"][value="NON"]:hover {
        background-color: #c9302c;
        transform: translateY(-2px);
    }
    
    /* Book Info Section */
    .book-info {
        background-color: #f9f9f9;
        border-radius: 8px;
        padding: 20px;
        margin-bottom: 25px;
        border: 1px solid #eee;
    }
    
    /* Question Emphasis */
    .question {
        font-size: 24px;
        color: var(--primary-color);
        margin: 25px 0;
        font-weight: bold;
    }
</style>
</head>
<body>

<div class="header">
    <h1>VALIDATION DU RETOUR</h1>
</div>

<div class="container">
    <h1>VERIFIER SI :</h1>

    <div class="book-info">
        <!-- Affiche le titre du livre emprunté -->
        <h2>Il s'agit vraiment de la REMISE du livre nommé :</h2>
        <h3>${livre.titre}</h3> <!-- Affiche le titre du livre depuis l'attribut ${livre.titre} -->

        <!-- Affiche l'auteur du livre emprunté -->
        <h2>ET écrit par l'auteur :</h2>
        <h3>${livre.auteur}</h3> <!-- Affiche l'auteur du livre depuis l'attribut ${livre.auteur} -->
    </div>

    <div class="question">Est-ce le cas ?</div>

    <div class="buttons-container">
        <!-- Formulaire pour valider la remise du livre -->
        <form method="post" action="retournerEmpruntServlet">
            <input type="submit" value="OUI"> <!-- Bouton pour confirmer la remise du livre -->
        </form>

        <!-- Formulaire pour annuler l'action de retour -->
        <form method="get" action="lancerProjet">
            <input type="hidden" name="page" value="emprunts.jsp">
            <input type="submit" value="NON"> <!-- Bouton pour refuser la remise du livre -->
        </form>
    </div>
</div>

</body>
</html>