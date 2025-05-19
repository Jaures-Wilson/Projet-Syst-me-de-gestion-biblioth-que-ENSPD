<%@ page contentType="text/html; charset=UTF-8" language="java" %> <!-- Déclaration du type de contenu de la page (HTML avec encodage UTF-8) -->
<!DOCTYPE html>
<html>
<head>
    <title>Ajouter un Lecteur</title> <!-- Titre de la page affiché dans l'onglet du navigateur -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/ajouter_lecteur.css"> <!-- Lien vers la feuille de style CSS -->
</head>
<body>
    <h1><a href="lancerProjet">ACCEUIL</a></h1> <!-- Lien vers la page d'accueil -->
    <h2>Ajouter un Lecteur</h2> <!-- Titre de la section pour ajouter un lecteur -->
    
    <form method="post" action="ajouterLecteurServlet"> <!-- Formulaire qui envoie les données au Servlet 'ajouterLecteurServlet' via la méthode POST -->
        <div class="form-group">
            <label for="nomLecteur" class="required">Nom</label>
            <input type="text" id="nomLecteur" name="nomLecteur" required placeholder="Entrez le nom du lecteur">
        </div>
        
        <div class="form-group">
            <label for="adresseLecteur" class="required">Adresse</label>
            <input type="text" id="adresseLecteur" name="adresseLecteur" required placeholder="Entrez l'adresse du lecteur">
        </div>
        
        <div class="form-group">
            <label for="numeroCNI" class="required">Numéro de CNI</label>
            <input type="text" id="numeroCNI" name="numeroCNI" required placeholder="Entrez le numéro de CNI">
        </div>
        
        <input type="submit" value="Ajouter"> <!-- Bouton pour soumettre le formulaire -->
    </form>
</body>
</html>