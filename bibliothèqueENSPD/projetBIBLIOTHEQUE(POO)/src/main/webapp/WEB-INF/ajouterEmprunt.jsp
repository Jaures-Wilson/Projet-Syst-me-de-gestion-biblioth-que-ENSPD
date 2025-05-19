<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Ajouter un Emprunt</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        :root {
            --primary-color: #003366;
            --secondary-color: #6699cc;
            --accent-color: #ffcc00;
            --light-color: #f5f5f5;
            --dark-color: #333333;
            --error-color: #d9534f;
            --success-color: #5cb85c;
        }
        
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
        }
        
        .header {
            background-color: var(--primary-color);
            color: white;
            padding: 15px 20px;
            border-radius: 5px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            width: 80px;
            height: auto;
        }
        
        .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-weight: bold;
            transition: color 0.3s;
        }
        
        .nav-links a:hover {
            color: var(--accent-color);
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        h1, h2, h3 {
            color: var(--primary-color);
            margin-bottom: 15px;
        }
        
        .book-info {
            background-color: #e9f0f7;
            padding: 15px;
            border-left: 5px solid var(--secondary-color);
            margin-bottom: 20px;
            border-radius: 0 5px 5px 0;
        }
        
        form {
            margin-top: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        
        input[type="number"],
        input[type="date"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        
        input[type="submit"] {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        
        input[type="submit"]:hover {
            background-color: var(--secondary-color);
        }
        
        .error-message {
            color: var(--error-color);
            background-color: #f8d7da;
            padding: 10px;
            border-radius: 4px;
            margin-top: 15px;
            border-left: 5px solid var(--error-color);
        }
        
        .required::after {
            content: " *";
            color: var(--error-color);
        }
    </style>
</head>

<body>
    <div class="header">
        <div class="title">
            <h1>Système de Gestion de Bibliothèque</h1>
        </div>
        <div class="nav-links">
            <a href="lancerProjet">ACCUEIL</a>
            <a href="lancerProjet?page=deconnexion.jsp">Déconnexion</a>
        </div>
    </div>

    <div class="container">
        <h2>Ajouter un Emprunt</h2>
        
        <div class="book-info">
            <h3>Détails du livre</h3>
            <p><strong>ISBN:</strong> ${livre.isbn}</p>
            <p><strong>Titre:</strong> ${livre.titre}</p>
            <p><strong>Auteur:</strong> ${livre.auteur}</p>
        </div>

        <form method="post" action="ajouterEmpruntServlet">
            <div class="form-group">
                <label for="idLecteur" class="required">ID Lecteur:</label>
                <input type="number" id="idLecteur" name="idLecteur" required>
            </div>
            
            <div class="form-group">
                <label for="dateRetourPrevue" class="required">Date Retour Prévue:</label>
                <input type="date" id="dateRetourPrevue" name="dateRetourPrevue" required>
            </div>
            
            <input type="submit" value="Ajouter l'emprunt">
        </form>

        <c:if test="${verdictNbEmprunt}">
            <div class="error-message">
                <p>Le lecteur d'identifiant ${lecteur.idLecteur} et nommé ${lecteur.nomLecteur} précédemment saisi
                NE PEUT PLUS FAIRE DES EMPRUNTS car il a atteint le nombre maximal d'emprunts qui est de TROIS emprunts.</p>
            </div>
        </c:if>
        
        <c:if test="${not isDateValid}">
            <div class="error-message">
                <p>La date entrée est invalide car elle doit être supérieure à la date du jour !</p>
            </div>
        </c:if>
    </div>

    <script>
        // Set minimum date for the date picker to today
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('dateRetourPrevue').setAttribute('min', today);
    </script>
</body>
</html>