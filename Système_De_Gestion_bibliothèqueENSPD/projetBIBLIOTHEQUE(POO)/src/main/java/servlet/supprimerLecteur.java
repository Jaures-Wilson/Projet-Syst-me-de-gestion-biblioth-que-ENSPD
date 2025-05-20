package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Lecteur;

import java.io.IOException;
import java.util.List;
import dao.LecteurDAO;

public class supprimerLecteur extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    // Constructeur
    public supprimerLecteur() {
        super();
    }

    // Méthode GET : Supprime un lecteur et redirige vers la liste des lecteurs
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Récupération du chemin vers la base de données
		String dbPath = getServletContext().getRealPath("/WEB-INF/bibliotheque.db");

		// Récupération de l'ID du lecteur à supprimer passé en paramètre
		int idLecteur = Integer.parseInt(request.getParameter("idLecteur"));

		// Suppression du lecteur dans la base de données
		new LecteurDAO(dbPath).deleteLecteur(idLecteur);

		// Récupération de la liste actualisée des lecteurs
	    List<Lecteur> lecteurs = new LecteurDAO(dbPath).getAllLecteurs();

	    // Transmission de la liste des lecteurs à la JSP
	    request.setAttribute("lecteurs", lecteurs);

	    // Redirection vers la page des lecteurs
	    this.getServletContext().getRequestDispatcher("/WEB-INF/lecteurs.jsp").forward(request, response);
	}

	// Méthode POST : Réutilise la méthode GET pour gérer la suppression
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
