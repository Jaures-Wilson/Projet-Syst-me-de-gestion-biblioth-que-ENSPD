<%@ page contentType="text/html; charset=UTF-8" language="java" %> <!-- Déclaration du type de contenu de la page (HTML avec encodage UTF-8) -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- Déclaration de la bibliothèque JSTL pour les balises c: -->

<!DOCTYPE html> <!-- Déclaration du type de document HTML -->
<html lang="en"> <!-- Début du document HTML avec langue anglaise spécifiée -->
<head>
    <meta charset="UTF-8"> <!-- Déclaration de l'encodage des caractères en UTF-8 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Pour rendre la page responsive sur les appareils mobiles -->
    <title>Ajout de livre</title> <!-- Titre de la page qui apparaîtra dans l'onglet du navigateur -->
    <link rel="stylesheet" href="CSS/ajouter_livre.css"> <!-- Lien vers la feuille de style CSS -->
</head>
<body>
    <div class="navigation">
        <h1><a href="lancerProjet">ACCUEIL</a></h1> <!-- Lien vers la page d'accueil du projet (correction de "ACCEUIL") -->
        <h2><a href="lancerProjet?page=deconnexion.jsp">Déconnexion</a></h2> <!-- Lien pour se déconnecter (correction de l'accent) -->
    </div>
    
    <h2>Ajouter un Livre</h2> <!-- Titre de la section pour ajouter un livre -->

    <form method="post" action="AjouterLivreServlet"> <!-- Formulaire qui enverra les données au servlet 'AjouterLivreServlet' via la méthode POST -->
        <div>
            <label for="isbn">ISBN:</label>
            <input type="text" id="isbn" name="isbn" required>
        </div>
        
        <div>
            <label for="titre">Titre:</label>
            <input type="text" id="titre" name="titre" required>
        </div>
        
        <div>
            <label for="auteur">Auteur:</label>
            <input type="text" id="auteur" name="auteur" required>
        </div>
        
        <div>
            <label for="datePub">Date Publication:</label>
            <input type="date" id="datePub" name="datePublication" required>
        </div>
        
        <div>
            <label for="totalExemplaire">Nombre d'exemplaires:</label>
            <input type="number" id="totalExemplaire" name="totalExemplaire" required>
        </div>
        
        <input type="submit" value="Ajouter"> <!-- Bouton pour soumettre le formulaire -->
    </form>

    <!-- Condition JSTL : Si la variable 'isbnExiste' est vraie, afficher un message d'erreur -->
    <c:if test="${isbnExiste}">
        <div class="error-message">
            <h2>Cet ISBN existe déjà, veuillez insérer un autre !!!</h2> <!-- Message d'erreur si l'ISBN existe déjà -->
        </div>
    </c:if>
    
    <c:if test="${not isDateValid}">
        <div class="error-message">
            La date entrée est invalide car doit être inférieure à la date du jour !!!
        </div>
    </c:if>
</body>
</html>