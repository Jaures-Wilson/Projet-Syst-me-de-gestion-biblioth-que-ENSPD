<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Système de Gestion de Bibliothèque - Liste des Lecteurs</title>
    <link rel="stylesheet" href="CSS/lecteur.css">
</head>
<body>
    <div class="header">
        <div class="nav-bar">
            <h1 class="logo">Système de Gestion de Bibliothèque</h1>
            <div class="nav-links">
                <a href="lancerProjet">ACCUEIL</a>
                <a href="lancerProjet?page=deconnexion.jsp" class="logout-btn">Déconnexion</a>
            </div>
        </div>
    </div>

    <div class="container">
        <h1>Liste des Lecteurs</h1>

        <div class="actions">
            <a href="lancerProjet?page=ajouterLecteur.jsp" class="btn">Ajouter un Lecteur</a>
            <a href="lancerProjet?page=supprimerLecteur.jsp" class="btn btn-danger">Supprimer un Lecteur</a>
        </div>

        <form action="RechercheDansLivreOuLecteur" method="post" class="search-form">
            <input type="text" name="rechercheLecteur" placeholder="Rechercher un lecteur..." class="search-input" />
            <button type="submit" class="search-btn">Rechercher</button>
        </form>

        <table class="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nom</th>
                    <th>Adresse</th>
                    <th>Numéro de CNI</th>
                    <th>Emprunts en cours</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="l" items="${lecteurs}">
                    <tr>
                        <td>${l.idLecteur}</td>
                        <td>${l.nomLecteur}</td>
                        <td>${l.adresseLecteur}</td>
                        <td>${l.numeroCNI}</td>
                        <td>${l.nombreEmpruntEnCours}</td>
                        <td>
                            <a href="ModifierLecteur?idLecteur=${l.idLecteur}" class="action-link">Modifier</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>