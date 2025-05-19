<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <!-- Métadonnées du document -->
    <title>Système de Gestion de Bibliothèque - Liste des Livres</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Système de gestion de bibliothèque permettant de visualiser et gérer les livres">
    <!-- Police Google Fonts -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap">
    <!-- Lien vers la feuille de style externe -->
    <link rel="stylesheet" href="CSS/livre.css">
</head>
<body>
    <!-- En-tête de la page avec navigation -->
    <header>
        <div class="header-container">
            <div class="logo">
                <h1>Bibliothèque Moderne</h1>
            </div>
            <nav class="nav-menu" role="navigation">
                <a href="lancerProjet" title="Retour à l'accueil">ACCUEIL</a>
                <a href="lancerProjet?page=lecteurs.jsp" title="Liste des lecteurs">LECTEURS</a>
                <a href="lancerProjet?page=emprunts.jsp" title="Gestion des emprunts">EMPRUNTS</a>
            </nav>
        </div>
    </header>

    <!-- Contenu principal de la page -->
    <main class="container">
        <h1 class="page-title">Collection de Livres</h1>
        
        <!-- Boutons d'action pour la gestion des livres -->
        <section class="action-buttons">
            <a href="lancerProjet?page=ajouterLivre.jsp" class="btn" title="Ajouter un nouveau livre">Ajouter un Livre</a>
            <a href="lancerProjet?page=supprimerLivre.jsp" class="btn btn-danger" title="Supprimer un livre existant">Supprimer un Livre</a>
        </section>
        
        <!-- Formulaire de recherche de livres -->
        <section class="search-section">
            <form class="search-form" action="RechercheDansLivreOuLecteur" method="get">
                <input type="text" name="rechercheLivre" id="rechercheLivre" placeholder="Rechercher par titre, auteur ou ISBN..." aria-label="Rechercher un livre">
                <button type="submit">Rechercher</button>
            </form>
        </section>
        
        <!-- Tableau des livres disponibles -->
        <section class="table-section">
            <table class="livres-table">
                <caption class="sr-only">Liste des livres disponibles dans la bibliothèque</caption>
                <thead>
                    <tr>
                        <th scope="col">ISBN</th>
                        <th scope="col">Titre</th>
                        <th scope="col">Auteur</th>
                        <th scope="col">Date publication</th>
                        <th scope="col">Exemplaires disponibles</th>
                        <th scope="col">Total d'Exemplaires</th>
                        <th scope="col">Statut</th>
                        <th scope="col">Modifier</th>
                        <th scope="col">Emprunter</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Boucle JSTL pour afficher la liste des livres -->
                    <c:forEach var="l" items="${livres}">
                        <tr>
                            <td>${l.isbn}</td>
                            <td>${l.titre}</td>
                            <td>${l.auteur}</td>
                            <td>${l.datePublication}</td>
                            <td>${l.nombreExemplaire}</td>
                            <td>${l.totalExemplaire}</td>
                            <td>
                                <!-- Affichage conditionnel du statut avec JSTL -->
                                <c:choose>
                                    <c:when test="${l.statut}">
                                        <span class="status-available">Disponible</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-unavailable">Indisponible</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="modifierLivre?isbn=${l.isbn}" class="action-link" title="Modifier les informations du livre">Modifier</a>
                            </td>
                            <td>
                                <!-- Lien pour emprunter conditionnel selon la disponibilité -->
                                <c:if test="${l.statut}">
                                    <a href="ajouterEmpruntServlet?isbn=${l.isbn}" class="borrow-link" title="Emprunter ce livre">Emprunter</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </section>
    </main>
    
    <!-- Pied de page optionnel -->
    <footer class="footer">
        <div class="container">
            <p>&copy; <%= java.time.Year.now() %> Bibliothèque Moderne. Tous droits réservés.</p>
        </div>
    </footer>
</body>
</html>