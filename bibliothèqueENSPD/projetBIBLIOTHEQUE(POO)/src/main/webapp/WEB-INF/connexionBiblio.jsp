<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- Inclusion de la bibliothèque JSTL pour utiliser des tags c:-->
<%@ page contentType="text/html; charset=UTF-8" language="java" %> <!-- Déclaration du type de contenu de la page (HTML avec encodage UTF-8) -->

<!DOCTYPE html> <!-- Déclaration du type de document HTML -->
<html> <!-- Début du document HTML -->
<head>
    <title>Connexion Bibliothecaire</title> <!-- Titre de la page qui apparaîtra dans l'onglet du navigateur -->
    <link rel="stylesheet" href="CSS/connexion.css">
</head>
<body>
    <!-- En-tête avec les logos -->
    <div class="header">
        <img src="${pageContext.request.contextPath}/images/enspd_logo.jpg" alt="Logo ENSPD" class="logo">
        <img src="${pageContext.request.contextPath}/images/universite_douala_logo.jpg" alt="Logo Université de Douala" class="logo">
    </div>

    <div class="container">
        <h1>BIENVENUE A LA BIBLIOTHEQUE DE l'ENSPD !!</h1> <!-- Titre principal de la page d'accueil -->
        
        <!-- Condition JSTL : Si 'trouverMotPass' est faux, afficher le formulaire de connexion -->
        <c:if test="${not trouverMotPass}">
            <h2>Connexion</h2> <!-- Sous-titre pour la section de connexion -->
            <form action="DemarrerLaBibliothequeServlet" method="post"> <!-- Formulaire qui envoie une requête POST au servlet 'DemarrerLaBibliothequeServlet' -->
                <label for="idBibliothecaire">Nom de Bibliothecaire :</label> <!-- Label pour le champ de sélection du bibliothécaire -->
                <select name="idBibliothecaire" id="idBibliothecaire"> <!-- Liste déroulante pour choisir un bibliothécaire -->
                    <c:forEach var="b" items="${bibliothecaires}"> <!-- Boucle sur la liste des bibliothécaires pour générer les options -->
                        <option value="${b.idBibliothecaire }">${b.nomBibliothecaire }</option> <!-- Chaque bibliothécaire est une option de la liste -->
                    </c:forEach>
                </select>
            
                <label for="motDePasse">Mot de passe :</label> <!-- Label pour le champ de mot de passe -->
                <input type="password" id="motDePasse" name="motDePasse" required> <!-- Champ pour saisir le mot de passe, obligatoire -->
            
                <button type="submit">Se connecter</button> <!-- Bouton pour soumettre le formulaire de connexion -->
            </form>
        </c:if>

        <!-- Condition JSTL : Si 'trouverMotPass' est vrai, afficher un message de bienvenue avec les détails du bibliothécaire connecté -->
        <c:if test="${trouverMotPass}">
            <div class="welcome-message">
                <form action="lancerProjet" method="get"> <!-- Formulaire qui envoie une requête GET au servlet 'lancerProjet' -->
                    <h1>Bienvenue très chrèr(e) ${bibliothecaire.nomBibliothecaire}</h1> <!-- Message de bienvenue avec le nom du bibliothécaire -->
                    <h3>Dans cette bibliotheque, votre identifiant sera : ${bibliothecaire.idBibliothecaire}</h3> <!-- Affichage de l'ID du bibliothécaire connecté -->
                    <button type="submit">CONTINUER</button> <!-- Bouton pour continuer après la connexion -->
                </form>
            </div>
        </c:if>
            
        <!-- Condition JSTL : Si 'raterMotPass' est vrai, afficher un message d'erreur -->
        <c:if test="${raterMotPass}">
            <div class="error-message">
                <h2>Erreur de nom d'utilisateur ou Mot de passe érroné !!</h2> <!-- Message d'erreur si le nom d'utilisateur ou le mot de passe est incorrect -->
            </div>
        </c:if>
    </div>
    
    <!-- Footer professionnel -->
    <div class="footer">
        <div class="footer-content">
            <div class="footer-section">
                <h3>Bibliothèque ENSPD</h3>
                <p>Centre de ressources et de documentation pour les étudiants et enseignants de l'ENSPD à l'Université de Douala.</p>
            </div>
            
            <div class="footer-section">
                <h3>Quelques informations</h3>
                <p> Située à Douala, pk17</p>
                <p> La réference à au Littoral </p>
                <p> Horaires d'ouverture : </p>
                <p> 7h00 - 16h00 </p>
            </div>
            
            <div class="footer-section">
                <h3>Contact</h3>
                <p>Université de Douala, Campus ENSPD</p>
                <p>BP 2701, Douala, Cameroun</p>
                <p>Tél: (+237) 233 40 29 00</p>
                <p>Email: bibliotheque@enspd-udo.cm</p>
            </div>
        </div>
        
        <div class="footer-bottom">
            &copy; ${java.time.Year.now().getValue()} Bibliothèque ENSPD - Tous droits réservés | Développé par le Département Informatique ENSPD
        </div>
    </div>
</body>
</html>