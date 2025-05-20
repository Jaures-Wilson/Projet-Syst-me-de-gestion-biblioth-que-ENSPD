<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- Inclusion de la bibliothèque JSTL pour utiliser les tags JSTL -->

<!DOCTYPE html> <!-- Déclaration du type de document HTML -->
<html> <!-- Début du document HTML -->
<head>
    <meta charset="UTF-8"> <!-- Définition de l'encodage du document HTML -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Déconnexion - Bibliothèque ENSPD</title> <!-- Titre plus descriptif de la page -->
    <style>
        /* Styles généraux */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            color: #333;
            min-height: 100vh;
        }
        
        /* En-tête */
        .header {
            background-color: #003366; /* Bleu foncé comme sur l'image */
            width: 100%;
            padding: 10px 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        
        .header-left {
            margin-left: 20px;
        }
        
        .header-right {
            margin-right: 20px;
        }
        
        .logo {
            width: 60px;
            height: auto;
        }
        
        .logo-enspd {
            width: 80px;
            height: auto;
        }
        
        /* Conteneur principal */
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .container {
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            margin: 30px auto;
            padding: 2rem;
            text-align: center;
        }
        
        /* Titres */
        h1 {
            color: #003366; /* Bleu foncé comme l'en-tête */
            margin-bottom: 1rem;
            font-size: 2rem;
        }
        
        h2 {
            color: #555;
            font-size: 1.2rem;
            font-weight: normal;
            margin-bottom: 2rem;
            line-height: 1.5;
        }
        
        /* Boutons */
        .buttons-container {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin-top: 1.5rem;
        }
        
        input[type="submit"] {
            padding: 0.75rem 2rem;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        input[type="submit"][value="OUI"] {
            background-color: #003366; /* Bleu foncé comme l'en-tête */
            color: white;
        }
        
        input[type="submit"][value="OUI"]:hover {
            background-color: #002244;
        }
        
        input[type="submit"][value="NON"] {
            background-color: #4a6789;
            color: white;
        }
        
        input[type="submit"][value="NON"]:hover {
            background-color: #3a5273;
        }
        
        /* Séparateur */
        .divider {
            height: 1px;
            background-color: #e0e0e0;
            width: 80%;
            margin: 1.5rem auto;
        }
    </style>
</head>
<body>
    <!-- En-tête avec bannière bleue -->
    <div class="header">
        <div class="header-left">
            <img src="images/universite_douala_logo.jpg" alt="Logo Bibliothèque" class="logo" />
        </div>
        <div class="header-right">
            <img src="images/enspd_logo.jpg" alt="Logo ENSPD" class="logo-enspd" />
        </div>
    </div>

    <div class="main-container">
        <div class="container">
            <h1>DÉCONNEXION</h1>
            <div class="divider"></div>
            <h2>Cher bibliothécaire ${bibliothecaire.nomBibliothecaire}, <br>êtes-vous sûr de vouloir quitter la bibliothèque de l'ENSPD ?</h2>
            
            <div class="buttons-container">
                <!-- Formulaire pour confirmer la déconnexion -->
                <form method="get" action="DemarrerLaBibliothequeServlet"> <!-- Le formulaire envoie une requête GET au servlet 'DemarrerLaBibliothequeServlet' pour procéder à la déconnexion -->
                    <input type="submit" value="OUI"> <!-- Bouton pour confirmer la déconnexion -->
                </form>
            
                <!-- Formulaire pour annuler la déconnexion -->
                <form method="get" action="lancerProjet"> <!-- Le formulaire envoie une requête GET au servlet 'lancerProjet' pour annuler la déconnexion -->
                    <input type="submit" value="NON"> <!-- Bouton pour annuler la déconnexion et revenir à l'accueil -->
                </form>
            </div>
        </div>
    </div>
</body>
</html>