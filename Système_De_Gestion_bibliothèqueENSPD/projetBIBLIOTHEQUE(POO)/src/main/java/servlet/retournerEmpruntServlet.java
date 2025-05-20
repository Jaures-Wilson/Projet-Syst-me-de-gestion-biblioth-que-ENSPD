package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Livre;

import java.io.IOException;
import java.util.List;

import dao.LivreDAO;
import dao.EmpruntDAO;
import model.Emprunt;
import dao.LecteurDAO;

// Servlet qui gère la logique de retour d'un emprunt (validation retour + mise à jour des données)
public class retournerEmpruntServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Variable pour stocker temporairement l’emprunt sélectionné
	private Emprunt emprunt;

	public retournerEmpruntServlet() {
		super();
	}

	// Étape 1 : Afficher la page de validation du retour d’un emprunt (GET)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Récupération du chemin vers la base de données
		String dbPath = getServletContext().getRealPath("/WEB-INF/bibliotheque.db");

		// Récupération de l’ID de l’emprunt passé en paramètre
		int idEmprunt = Integer.parseInt(request.getParameter("idEmprunt"));

		// Récupération de l’objet Emprunt correspondant à l’ID
		emprunt = new EmpruntDAO(dbPath).getEmpruntById(idEmprunt);

		// Récupération du livre lié à cet emprunt
		Livre livre = new LivreDAO(dbPath).getLivreByIsbn(emprunt.getIsbn());

		// Transmission des données à la JSP
		request.setAttribute("livre", livre);
		this.getServletContext().getRequestDispatcher("/WEB-INF/validationEmprunt.jsp").forward(request, response);
	}

	// Étape 2 : Traiter le retour effectif de l’emprunt (POST)
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Récupération du chemin vers la base de données
		String dbPath = getServletContext().getRealPath("/WEB-INF/bibliotheque.db");

		// Mise à jour de la date de retour effective de l’emprunt
		new EmpruntDAO(dbPath).updateDateRetourEffective(emprunt.getIdEmprunt());

		// Mise à jour : le livre revient donc on augmente le nombre d’exemplaires disponibles
		new LivreDAO(dbPath).augmenterNombreExemplaire(emprunt.getIsbn());

		// Mise à jour du nombre d'emprunts en cours pour le lecteur concerné
		new LecteurDAO(dbPath).decrementNombreEmpruntEnCours(emprunt.getIdLecteur());

		// Mise à jour de la liste des emprunts et redirection vers la page des emprunts
		List<Emprunt> emprunts = new EmpruntDAO(dbPath).getAllEmprunts();
		request.setAttribute("emprunts", emprunts);
		this.getServletContext().getRequestDispatcher("/WEB-INF/emprunts.jsp").forward(request, response);
	}
}
