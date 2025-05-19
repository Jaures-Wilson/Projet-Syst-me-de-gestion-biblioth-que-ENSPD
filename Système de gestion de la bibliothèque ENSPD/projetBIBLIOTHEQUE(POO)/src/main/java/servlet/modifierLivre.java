package servlet;

import jakarta.servlet.ServletException;
import java.time.LocalDate;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Livre;

import java.io.IOException;
import java.util.List;

import dao.EmpruntDAO;
import dao.LivreDAO;

// Servlet permettant de modifier les informations d’un livre existant
public class modifierLivre extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Variables pour stocker l'ancien ISBN et le nombre d'emprunts de ce livre
	private String ancienIsbn;
	private int nombreEmpruntIsbn;
	private boolean isDateValid;  // Variable pour savoir si la date entrée est supérieure à la date du jour

    // Constructeur par défaut
    public modifierLivre() {
        super();
    }

    // Méthode appelée lorsqu'on veut accéder à la page de modification d’un livre (GET)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Récupère le chemin absolu vers la base de données
		String dbPath = getServletContext().getRealPath("/WEB-INF/bibliotheque.db");

		// Récupère l'ancien ISBN passé dans l'URL
		ancienIsbn = request.getParameter("isbn");

		// Recherche les informations actuelles du livre en base de données
        Livre livre = new LivreDAO(dbPath).getLivreByIsbn(ancienIsbn);

		// Compte combien de fois ce livre a été emprunté (utile pour le nombre d'exemplaires restants)
        nombreEmpruntIsbn = new EmpruntDAO(dbPath).nombreEmpruntsParIsbn(ancienIsbn);
        isDateValid = true;
		// Envoie les données du livre à la page JSP pour l'affichage dans le formulaire
        request.setAttribute("nombreEmpruntIsbn", nombreEmpruntIsbn);
        request.setAttribute("livre", livre);
        request.setAttribute("isDateValid", isDateValid);

		// Redirige vers la page de modification du livre
        this.getServletContext().getRequestDispatcher("/WEB-INF/modifierLivre.jsp").forward(request, response);
	}
	
	
	
	

	// Méthode appelée quand l’utilisateur soumet le formulaire de modification (POST)
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Récupère le chemin absolu vers la base de données
		String dbPath = getServletContext().getRealPath("/WEB-INF/bibliotheque.db");
		
		

		LocalDate datePublication = LocalDate.parse(request.getParameter("datePublication"));
		LocalDate today = LocalDate.now();

		isDateValid = datePublication.isBefore(today); // compare les dates : Est ce que la date entrée est vient avant la date du jour ?

		if (isDateValid) { // si la date est valide, on l'applique
			// Crée un objet Livre avec les nouvelles valeurs saisies par l’utilisateur
	        Livre l = new Livre();
	        l.setIsbn(request.getParameter("isbn"));
	        l.setTitre(request.getParameter("titre"));
	        l.setAuteur(request.getParameter("auteur"));
	        l.setDatePublication(LocalDate.parse(request.getParameter("datePublication")));
	        l.setTotalExemplaire(Integer.parseInt(request.getParameter("totalExemplaire")));

			// Calcule le nombre d'exemplaires disponibles en soustrayant les emprunts
	        l.setNombreExemplaire(l.getTotalExemplaire() - nombreEmpruntIsbn);

			// Met à jour le statut (disponible ou non) en fonction du nombre d'exemplaires restants
	        l.setStatut(l.getNombreExemplaire() > 0);

			// Met à jour les données du livre dans la base
	        new LivreDAO(dbPath).updateLivre(l, ancienIsbn);

			// Recharge la liste des livres mise à jour
	        List<Livre> livres = new LivreDAO(dbPath).getAllLivres();
	        request.setAttribute("livres", livres);
	        request.setAttribute("isDateValid", isDateValid);
			// Redirige vers la page affichant tous les livres
	        this.getServletContext().getRequestDispatcher("/WEB-INF/livres.jsp").forward(request, response);
		}else {
			
			// Récupère l'ancien ISBN passé dans l'URL
			ancienIsbn = request.getParameter("isbn");

			// Recherche les informations actuelles du livre en base de données
	        Livre livre = new LivreDAO(dbPath).getLivreByIsbn(ancienIsbn);

			// Compte combien de fois ce livre a été emprunté (utile pour le nombre d'exemplaires restants)
	        nombreEmpruntIsbn = new EmpruntDAO(dbPath).nombreEmpruntsParIsbn(ancienIsbn);
	        
			// Envoie les données du livre à la page JSP pour l'affichage dans le formulaire
	        request.setAttribute("nombreEmpruntIsbn", nombreEmpruntIsbn);
	        request.setAttribute("livre", livre);
	        request.setAttribute("isDateValid", isDateValid);

			// Redirige vers la page de modification du livre
	        this.getServletContext().getRequestDispatcher("/WEB-INF/modifierLivre.jsp").forward(request, response);
		}

		
	}

}
