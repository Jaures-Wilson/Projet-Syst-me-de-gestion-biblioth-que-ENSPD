package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Bibliothecaire;
import java.io.IOException;
import java.util.List;
import dao.BibliothecaireDAO;


// Servlet qui gère l'accès à la bibliothèque pour les bibliothécaires
public class DemarrerLaBibliothequeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Variables pour indiquer si l'identification a échoué ou réussi
	public boolean raterMotPass = false;
	public boolean trouverMotPass = false;
       
    public DemarrerLaBibliothequeServlet() {
        super(); // Appelle le constructeur de la classe HttpServlet
    }

	// Méthode appelée lors d'une requête GET (ex : lorsqu'on ouvre la page de connexion)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Récupère le chemin absolu vers la base de données SQLite
		String dbPath = getServletContext().getRealPath("/WEB-INF/bibliotheque.db");

		// Réinitialise les indicateurs de mot de passe
		raterMotPass = false;
		trouverMotPass = false;

		// Récupère la liste des bibliothécaires depuis la base de données
		BibliothecaireDAO bibliothecaireDAO = new BibliothecaireDAO(dbPath);
	    List<Bibliothecaire> bibliothecaires = bibliothecaireDAO.getAllBibliothecaire();

		// Stocke les données dans la requête pour qu'elles soient accessibles dans la JSP
	    request.setAttribute("raterMotPass", raterMotPass);
	    request.setAttribute("trouverMotPass", trouverMotPass);
	    request.setAttribute("bibliothecaires", bibliothecaires);

		// Redirige vers la page JSP de connexion
		this.getServletContext().getRequestDispatcher("/WEB-INF/connexionBiblio.jsp").forward(request, response);
	}

	// Méthode appelée lors d'une requête POST (ex : lorsqu'on soumet le formulaire de connexion)
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Récupère le chemin de la base de données
		String dbPath = getServletContext().getRealPath("/WEB-INF/bibliotheque.db");

		// Récupère les informations saisies dans le formulaire
		int idBibliothecaire = Integer.parseInt(request.getParameter("idBibliothecaire"));
		String essaiMotPass = request.getParameter("motDePasse");

		// Recherche le bibliothécaire correspondant à l'ID
		Bibliothecaire bibliothecaire = new BibliothecaireDAO(dbPath).prendreBibliothecaireById(idBibliothecaire);
		
		// Vérifie si le mot de passe est correct
		if(bibliothecaire != null && bibliothecaire.getMotDePasse().equals(essaiMotPass)) {
			// Connexion réussie
			trouverMotPass = true;

			// Crée une session et y stocke l'ID du bibliothécaire
			getServletContext().setAttribute("idBibliothecaire", idBibliothecaire);

			// Envoie les données à la JSP
			request.setAttribute("trouverMotPass", trouverMotPass);
		    request.setAttribute("bibliothecaire", bibliothecaire);

			// Redirige vers la même JSP (connexionBiblio.jsp)
			this.getServletContext().getRequestDispatcher("/WEB-INF/connexionBiblio.jsp").forward(request, response);
			
		}else {
			// Connexion échouée
			raterMotPass = true;

			// Recharge les bibliothécaires pour réafficher la liste
			BibliothecaireDAO bibliothecaireDAO = new BibliothecaireDAO(dbPath);
		    List<Bibliothecaire> bibliothecaires = bibliothecaireDAO.getAllBibliothecaire();

			// Envoie les indicateurs et données à la JSP
		    request.setAttribute("raterMotPass", raterMotPass);
		    request.setAttribute("trouverMotPass", trouverMotPass);
		    request.setAttribute("bibliothecaires", bibliothecaires);

			// Redirige à nouveau vers la JSP de connexion
			this.getServletContext().getRequestDispatcher("/WEB-INF/connexionBiblio.jsp").forward(request, response);
		}
	}
}
