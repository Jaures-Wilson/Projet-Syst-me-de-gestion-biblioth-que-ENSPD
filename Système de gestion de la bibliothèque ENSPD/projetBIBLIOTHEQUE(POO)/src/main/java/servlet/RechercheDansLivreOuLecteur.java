package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Lecteur;
import model.Livre;

import java.io.IOException;
import java.util.List;

import dao.LivreDAO;
import dao.LecteurDAO;

// Servlet qui gère la recherche de livres ou de lecteurs selon le mot-clé fourni
public class RechercheDansLivreOuLecteur extends HttpServlet {
	private static final long serialVersionUID = 1L;

    // Constructeur par défaut
    public RechercheDansLivreOuLecteur() {
        super();
    }

    // Recherche de livres — méthode GET
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Récupère le mot-clé saisi par l’utilisateur dans le champ "rechercheLivre"
		String motCle = request.getParameter("rechercheLivre");

		// Récupère le chemin vers la base de données
		String dbPath = getServletContext().getRealPath("/WEB-INF/bibliotheque.db");

		// Utilise le DAO pour rechercher les livres correspondant au mot-clé (titre ou auteur)
	    LivreDAO livreDAO = new LivreDAO(dbPath);
	    List<Livre> livres = livreDAO.chercherLivresParTitreOuAuteur(motCle);

		// Envoie la liste des résultats à la JSP
	    request.setAttribute("livres", livres);
        this.getServletContext().getRequestDispatcher("/WEB-INF/livres.jsp").forward(request, response);
	}

	// Recherche de lecteurs — méthode POST
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Récupère le mot-clé saisi par l’utilisateur dans le champ "rechercheLecteur"
		String motCle = request.getParameter("rechercheLecteur");

		// Récupère le chemin vers la base de données
		String dbPath = getServletContext().getRealPath("/WEB-INF/bibliotheque.db");

		// Utilise le DAO pour rechercher les lecteurs correspondant au mot-clé (nom, adresse ou CNI)
	    LecteurDAO lecteurDAO = new LecteurDAO(dbPath);
	    List<Lecteur> lecteurs = lecteurDAO.chercherLecteursParNomAdresseCNI(motCle);

		// Envoie la liste des résultats à la JSP
	    request.setAttribute("lecteurs", lecteurs);
        this.getServletContext().getRequestDispatcher("/WEB-INF/lecteurs.jsp").forward(request, response);
	}

}
