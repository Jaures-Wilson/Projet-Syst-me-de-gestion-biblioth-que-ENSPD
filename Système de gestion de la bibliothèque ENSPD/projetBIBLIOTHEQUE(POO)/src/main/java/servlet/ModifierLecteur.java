package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Lecteur;

import java.io.IOException;
import java.util.List;

import dao.LecteurDAO;

// Servlet permettant de modifier les informations d’un lecteur
public class ModifierLecteur extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Variable pour stocker l’identifiant du lecteur à modifier
	private int ancienIdLecteur;

	// Constructeur par défaut
    public ModifierLecteur() {
        super();
    }

    // Méthode appelée quand on accède à la page de modification via un lien (GET)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Chemin vers la base de données
		String dbPath = getServletContext().getRealPath("/WEB-INF/bibliotheque.db");

		// Récupère l'ID du lecteur à modifier à partir du lien
		ancienIdLecteur = Integer.parseInt(request.getParameter("idLecteur"));

		// Récupère les infos actuelles du lecteur depuis la base
        Lecteur lecteur = new LecteurDAO(dbPath).getLecteurByIdLecteur(ancienIdLecteur);

		// Envoie l’objet lecteur à la page JSP pour l'affichage
        request.setAttribute("lecteur", lecteur);

		// Redirige vers la page de modification
        this.getServletContext().getRequestDispatcher("/WEB-INF/modifierLecteur.jsp").forward(request, response);
	}

	// Méthode appelée lorsqu'on soumet le formulaire de modification (POST)
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Chemin vers la base de données
		String dbPath = getServletContext().getRealPath("/WEB-INF/bibliotheque.db");

		// Crée un nouvel objet Lecteur avec les nouvelles infos fournies par l’utilisateur
        Lecteur l = new Lecteur();
        l.setNomLecteur(request.getParameter("nomLecteur"));
        l.setAdresseLecteur(request.getParameter("adresseLecteur"));
        l.setNumeroCNI(request.getParameter("numeroCNI"));

		// Met à jour le lecteur dans la base à partir de l'ancien ID
        new LecteurDAO(dbPath).updateLecteur(l, ancienIdLecteur);

		// Récupère tous les lecteurs pour les afficher
        List<Lecteur> lecteurs = new LecteurDAO(dbPath).getAllLecteurs();
        request.setAttribute("lecteurs", lecteurs);

		// Redirige vers la page de la liste des lecteurs mise à jour
        this.getServletContext().getRequestDispatcher("/WEB-INF/lecteurs.jsp").forward(request, response);
	}

}
