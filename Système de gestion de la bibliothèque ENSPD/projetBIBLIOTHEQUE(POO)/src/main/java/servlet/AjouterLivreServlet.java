package servlet;

import dao.LivreDAO;
import model.Livre;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.time.LocalDate;

// Servlet pour gérer l'ajout d'un nouveau livre dans la base de données
public class AjouterLivreServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

    // Méthode appelée lors d'une requête GET (pas utilisée ici)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Aucun traitement prévu dans cette méthode
    }

    
    
    // Méthode appelée lors d'une requête POST (soumission du formulaire d’ajout de livre)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	// Récupération du chemin vers la base de données SQLite
    	String dbPath = getServletContext().getRealPath("/WEB-INF/bibliotheque.db");

        // Récupération de l'ISBN du livre envoyé depuis le formulaire
        String isbn = request.getParameter("isbn");

        // Variable pour savoir si l'ISBN existe déjà
        boolean isbnExiste = false;
        
        // Variable pour savoir si la date entrée est supérieur à la date du jour
        boolean isDateValid = true;
        LocalDate datePublication = LocalDate.parse(request.getParameter("datePublication"));
		LocalDate today = LocalDate.now();

		isDateValid = datePublication.isBefore(today); // compare les dates : Est ce que la date entrée est vient avant la date du jour ?
		
        // Vérifie si un livre avec le même ISBN existe déjà dans la base ou si la date entrée est valide
        if(new LivreDAO(dbPath).isbnExiste(isbn) || !isDateValid) {
        	
        	// Si l’ISBN existe déjà, on informe l'utilisateur via la JSP
        	isbnExiste = new LivreDAO(dbPath).isbnExiste(isbn);
        	request.setAttribute("isbnExiste", isbnExiste);
        	request.setAttribute("isDateValid", isDateValid);
        	// Redirection vers la page JSP d'ajout du livre avec message d’erreur
        	this.getServletContext().getRequestDispatcher("/WEB-INF/ajouterLivre.jsp").forward(request, response);
        	
        } else {
        	
        	// Si l’ISBN est unique, on crée un nouveau livre avec les données du formulaire
        	Livre l = new Livre();
            l.setIsbn(isbn);
        	l.setTitre(request.getParameter("titre")); // Titre du livre
            l.setAuteur(request.getParameter("auteur")); // Auteur
            l.setDatePublication(LocalDate.parse(request.getParameter("datePublication"))); // Date de publication
            l.setNombreExemplaire(Integer.parseInt(request.getParameter("totalExemplaire"))); // Nombre d'exemplaires
            l.setTotalExemplaire(Integer.parseInt(request.getParameter("totalExemplaire"))); // Total (même valeur ici)
            l.setStatut(l.getNombreExemplaire() > 0); // Statut : true si exemplaires disponibles

            // Ajoute le livre à la base de données
            new LivreDAO(dbPath).ajouterLivre(l);
            
            // Récupère la liste mise à jour des livres pour l’afficher
            List<Livre> livres = new LivreDAO(dbPath).getAllLivres();
            
            isbnExiste = new LivreDAO(dbPath).isbnExiste(isbn);

            // Transmet les données à la JSP pour affichage
            request.setAttribute("livres", livres);
            request.setAttribute("isbnExiste", isbnExiste);
            request.setAttribute("isDateValid", isDateValid);
            // Redirection vers la page JSP qui affiche les livres
            this.getServletContext().getRequestDispatcher("/WEB-INF/livres.jsp").forward(request, response);
        }
    }
}
