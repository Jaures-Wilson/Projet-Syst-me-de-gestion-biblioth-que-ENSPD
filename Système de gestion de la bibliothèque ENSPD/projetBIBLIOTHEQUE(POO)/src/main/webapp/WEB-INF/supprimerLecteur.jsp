<!-- Déclaration de la bibliothèque JSTL pour utiliser les balises comme c: -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %> <!-- Définition du type de contenu de la page avec encodage UTF-8 -->

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"> <!-- Encodage UTF-8 pour gérer les caractères spéciaux -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Pour le responsive design -->
    <title>Supprimer un lecteur</title> <!-- Titre de la page -->
    <link rel="stylesheet" href="CSS/supprimer_lecteur.css"> <!-- Lien vers la feuille de style CSS -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet"> <!-- Police Google Fonts -->
</head>
<body>

<div class="header">
    <!-- Lien pour revenir à la page d'accueil -->
    <h1 class="nav-link"><a href="lancerProjet">ACCUEIL</a></h1>
    <!-- Lien pour se déconnecter -->
    <div class="deconnexion">
        <a href="lancerProjet?page=deconnexion.jsp">Déconnexion</a>
    </div>
    <!-- Titre de la page -->
    <h2 class="page-title"><strong>Sélectionner un lecteur à supprimer</strong></h2>
    <!-- Message d'avertissement -->
    <div class="warning">
        <span class="warning-icon">⚠️</span>
        <h2><strong>NB : Certains lecteurs sont retirés de la liste car
        les lecteurs qui ont fait des emprunts ne peuvent être supprimés sans remettre la totalité des livres empruntés !!!</strong></h2>
    </div>
</div>

<div class="reader-list">
    <!-- Boucle à travers tous les lecteurs pour afficher leurs noms et numéros CNI avec un lien pour les supprimer -->
    <c:forEach var="l" items="${lecteurs}">
        <div class="reader-item">
            <!-- Lien pour supprimer un lecteur, avec leur ID passé en paramètre -->
            <a href="supprimerLecteur?idLecteur=${l.idLecteur}">
                NOM <span class="separator">=></span> ${l.nomLecteur} <span class="separator">///</span> NUMERO-CNI <span class="separator">=></span> ${l.numeroCNI}
            </a>
        </div>
    </c:forEach>
    
    <!-- Affichage conditionnel si aucun lecteur n'est disponible pour suppression -->
    <c:if test="${empty lecteurs}">
        <div class="no-readers">Aucun lecteur disponible pour suppression</div>
    </c:if>
</div>

</body>
</html>