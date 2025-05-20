<!-- Déclaration de la bibliothèque JSTL pour utiliser des balises comme c: -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %> <!-- Définition du type de contenu et de l'encodage UTF-8 -->

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"> <!-- Encodage UTF-8 pour une gestion correcte des caractères spéciaux -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Pour rendre la page responsive -->
    <title>Supprimer un livre</title> <!-- Titre de la page -->
    <link rel="stylesheet" href="CSS/Suprimer_livre.css"> <!-- Lien vers la feuille de style CSS -->
</head>
<body>

<div class="container">
    <div class="header header-links">
        <!-- Lien vers la page d'accueil -->
        <h1><a href="lancerProjet">ACCEUIL</a></h1>
        <!-- Lien pour la déconnexion -->
        <h2><a href="lancerProjet?page=deconnexion.jsp">Deconnexion</a></h2>
        <!-- Titre de la section pour la suppression d'un livre -->
        <h2><strong>Sélectionner un livre à supprimer !!!</strong></h2>
        <!-- Message informant l'utilisateur que certains livres sont retirés de la liste s'ils ont été empruntés -->
        <div class="warning">
            <h2><strong>NB : La totalité ou certains livres ont été enlevés de la liste car on ne peut supprimer
            un livre qui a déjà été emprunté par au moins une personne !!!</strong></h2>
        </div>
    </div>

    <div class="book-list">
        <!-- Boucle à travers tous les livres dans la variable ${livres} -->
        <c:forEach var="l" items="${livres}">
            <div class="book-item">
                <!-- Lien pour supprimer un livre, avec son ISBN passé en paramètre -->
                <a href="supprimerLivre?isbn=${l.isbn}">NOM : ${l.titre} <span class="separator">///</span> AUTEUR : ${l.auteur}</a>
            </div>
        </c:forEach>
        
        <!-- Affichage conditionnel si aucun livre n'est disponible -->
        <c:if test="${empty livres}">
            <div class="no-books">Aucun livre disponible pour suppression</div>
        </c:if>
    </div>
</div>

</body>
</html>