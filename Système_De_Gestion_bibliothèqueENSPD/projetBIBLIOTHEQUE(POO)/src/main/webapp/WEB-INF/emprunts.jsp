<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Système de Gestion de Bibliothèque - Historique des Emprunts</title>
    <link rel="stylesheet" href="CSS/emprunts.css">
    
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
        <h1>Historique des Emprunts</h1>

        <table class="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>ISBN</th>
                    <th>ID Lecteur</th>
                    <th>ID Bibliothécaire</th>
                    <th>Date Emprunt</th>
                    <th>Date Retour Prévue</th>
                    <th>Date Retour Effective</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="e" items="${emprunts}">
                    <tr>
                        <td>${e.idEmprunt}</td>
                        <td>${e.isbn}</td>
                        <td>${e.idLecteur}</td>
                        <td>${e.idBibliothecaire}</td>
                        <td>${e.dateEmprunt}</td>
                        <td>${e.dateRetourPrevue}</td>
                        <td>${e.dateRetourEffective}</td>
                        <td>
                            <c:if test="${empty e.dateRetourEffective}">
                                <a href="retournerEmpruntServlet?idEmprunt=${e.idEmprunt}" class="btn-action">Retour Livre</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>