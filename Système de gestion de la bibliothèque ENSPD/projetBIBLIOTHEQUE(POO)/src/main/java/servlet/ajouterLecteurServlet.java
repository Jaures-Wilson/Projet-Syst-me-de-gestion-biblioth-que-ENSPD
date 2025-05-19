package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Lecteur;

import java.io.IOException;
import java.util.List;

import dao.LecteurDAO;

// Servlet pour gérer l'ajout d'un nouveau lecteur dans la base de données
public class ajouterLecteurServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    // Constructeur par défaut
    public ajouterLecteurServlet() {
        super();
    }

    // Méthode appelée lors d'une requête HTTP GET (rarement utilisée ici)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Affiche un simple message dans le navigateur (peut être supprimé)
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

    // Méthode appelée lors d'une requête HTTP POST (quand le formulaire d’ajout est soumis)
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Récupère le chemin absolu de la base de données
		String dbPath = getServletContext().getRealPath("/WEB-INF/bibliotheque.db");

        // Création d'un nouvel objet Lecteur et remplissage avec les données du formulaire
        Lecteur l = new Lecteur();
        l.setNomLecteur(request.getParameter("nomLecteur")); // Nom du lecteur
        l.setAdresseLecteur(request.getParameter("adresseLecteur")); // Adresse
        l.setNumeroCNI(request.getParameter("numeroCNI")); // Numéro de la carte d'identité

        // Ajoute le lecteur dans la base de données via le DAO
        new LecteurDAO(dbPath).ajouterLecteur(l);

        // Récupère la liste des lecteurs mise à jour
        List<Lecteur> lecteurs = new LecteurDAO(dbPath).getAllLecteurs();

        // Envoie cette liste à la JSP pour affichage
        request.setAttribute("lecteurs", lecteurs);

        // Redirige vers la page JSP qui affiche les lecteurs
        this.getServletContext().getRequestDispatcher("/WEB-INF/lecteurs.jsp").forward(request, response);
	}
}
