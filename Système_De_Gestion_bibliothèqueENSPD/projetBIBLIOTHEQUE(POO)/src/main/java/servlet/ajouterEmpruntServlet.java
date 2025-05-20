package servlet;

import jakarta.servlet.ServletException;
import java.time.LocalDate;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Emprunt;
import model.Lecteur;
import model.Livre;

import java.io.IOException;
import java.util.List;

import dao.EmpruntDAO;
import dao.LivreDAO;
import dao.LecteurDAO;



// Servlet qui permet d'ajouter un nouvel emprunt de livre
public class ajouterEmpruntServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Variable pour stocker l'ISBN du livre sélectionné
	public String isbn;

	// Variable pour indiquer si le lecteur a atteint la limite d'emprunts
	public boolean verdictNbEmprunt = false;
	
	private boolean isDateValid;  // Variable pour savoir si la date entrée est supérieure à la date du jour
	
	private int idBibliothecaire;

	public ajouterEmpruntServlet() {
		super(); // Appelle le constructeur de la classe HttpServlet
	}

	// Méthode appelée lors d'une requête GET (affichage du formulaire d'emprunt)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Récupère l'ISBN du livre depuis la requête
		isbn = request.getParameter("isbn");
		
		// Récupère le chemin vers la base de données
		String dbPath = getServletContext().getRealPath("/WEB-INF/bibliotheque.db");
		
		// Récupère la session pour identifier le bibliothécaire qui effectue l'action
		idBibliothecaire = (int) getServletContext().getAttribute("idBibliothecaire");

		// Réinitialise le verdict sur le nombre d'emprunts
		verdictNbEmprunt = false;
		isDateValid = true;
		// Ajoute cette information à la requête pour l'afficher dans la JSP
		Livre livre = new LivreDAO(dbPath).getLivreByIsbn(isbn);
		request.setAttribute("livre", livre);
		request.setAttribute("verdictNbEmprunt", verdictNbEmprunt);
		request.setAttribute("isDateValid", isDateValid);
		// Redirige vers la page JSP pour ajouter un emprunt
		this.getServletContext().getRequestDispatcher("/WEB-INF/ajouterEmprunt.jsp").forward(request, response);
	}

	
	
	// Méthode appelée lors d'une requête POST (lorsqu'on soumet le formulaire)
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Récupère le chemin vers la base de données
		String dbPath = getServletContext().getRealPath("/WEB-INF/bibliotheque.db");
		
		// Récupère l'ID du lecteur depuis le formulaire
		int idLect = Integer.parseInt(request.getParameter("idLecteur"));
		
		LocalDate datePublication = LocalDate.parse(request.getParameter("dateRetourPrevue"));
		LocalDate today = LocalDate.now();
		
		isDateValid = datePublication.isAfter(today); // compare les dates : Est ce que la date entrée est vient avant la date du jour ?
		
		// Vérifie si le lecteur a déjà 3 emprunts
		if(new LecteurDAO(dbPath).verificationSiLeLecteurATroisEmprunts(idLect) || !isDateValid) {
			// Si oui, on indique l'erreur et on reste sur la page d'ajout
			verdictNbEmprunt = new LecteurDAO(dbPath).verificationSiLeLecteurATroisEmprunts(idLect);

			// Récupère les informations du lecteur pour les afficher
			Lecteur lecteur = new LecteurDAO(dbPath).getLecteurByIdLecteur(idLect);
			Livre livre = new LivreDAO(dbPath).getLivreByIsbn(isbn);
			
			request.setAttribute("lecteur", lecteur);
	        request.setAttribute("isDateValid", isDateValid);
	        
			request.setAttribute("livre", livre);
			request.setAttribute("verdictNbEmprunt", verdictNbEmprunt);

			// Redirige vers la même JSP pour informer l'utilisateur
			this.getServletContext().getRequestDispatcher("/WEB-INF/ajouterEmprunt.jsp").forward(request, response);

		} else {
			// Si le lecteur peut encore emprunter

			// Création d'un nouvel objet Emprunt
			Emprunt e = new Emprunt();
			e.setIsbn(isbn); // Affecte l'ISBN du livre
			e.setIdLecteur(idLect); // Affecte l'ID du lecteur
			
			
			e.setIdBibliothecaire(idBibliothecaire); // Enregistre son ID dans l'emprunt
			
			
			// Définit la date de l'emprunt (aujourd'hui)
			e.setDateEmprunt(LocalDate.now());

			// Récupère la date de retour prévue saisie par l'utilisateur
			e.setDateRetourPrevue(LocalDate.parse(request.getParameter("dateRetourPrevue")));
			
			// Enregistre l'emprunt dans la base de données
			new EmpruntDAO(dbPath).ajouterEmprunt(e);

			// Diminue le nombre d'exemplaires disponibles pour ce livre
			new LivreDAO(dbPath).diminuerNombreExemplaire(isbn);

			// Incrémente le nombre d'emprunts en cours pour le lecteur
			new LecteurDAO(dbPath).incrementNombreEmpruntEnCours(e.getIdLecteur());

			// Récupère la liste mise à jour des livres
			List<Livre> livres = new LivreDAO(dbPath).getAllLivres();
			request.setAttribute("livres", livres);
			
			// Envoie la liste des livres et le verdict à la JSP
			request.setAttribute("verdictNbEmprunt", verdictNbEmprunt);
			
			request.setAttribute("isDateValid", isDateValid);

			// Redirige vers la page qui affiche les livres
			this.getServletContext().getRequestDispatcher("/WEB-INF/livres.jsp").forward(request, response);
		}
	}
}
