package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Livre;

import java.io.IOException;
import java.util.List;

import dao.LivreDAO;
import dao.BibliothecaireDAO;
import dao.EmpruntDAO;
import dao.LecteurDAO;
import model.Bibliothecaire;
import model.Emprunt;
import model.Lecteur;

// Servlet principale qui redirige vers les différentes pages du projet selon la demande
public class lancerProjet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    // Constructeur par défaut
    public lancerProjet() {
        super();
    }

    // Méthode appelée lors d'une requête GET (affichage d’une page selon l’option choisie)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Récupère le chemin absolu vers la base de données
		String dbPath = getServletContext().getRealPath("/WEB-INF/bibliotheque.db");

		// Valeur par défaut si aucun paramètre "page" n’est donné
		String defaultValue = "menu.jsp";  
        String page = request.getParameter("page");

        // Si aucune page spécifiée, on redirige vers la page par défaut
        if (page == null) {
            page = defaultValue;  
        }

        // Préparation de variables utiles pour certaines pages
        List<Lecteur> lecteurs;
        List<Livre> livres;
        String redirectPage = "";

        // Choix de la page à afficher selon le paramètre "page" reçu
        switch (page) {

            case "ajouterLivre.jsp":
                // Redirige vers le formulaire d’ajout de livre
            	 boolean isDateValid = true;
            	 request.setAttribute("isDateValid", isDateValid);
                redirectPage = "ajouterLivre.jsp";
                break;

            case "supprimerLivre.jsp":
                // Récupère les livres disponibles pour suppression
                livres = new LivreDAO(dbPath).prendreLivresEntierementDisponibles();
                request.setAttribute("livres", livres);
                redirectPage = "supprimerLivre.jsp";
                break;

            case "ajouterLecteur.jsp":
                // Redirige vers le formulaire d’ajout de lecteur
                redirectPage = "ajouterLecteur.jsp";
                break;
                
            case "stat.jsp":
                // Redirige vers le formulaire d’ajout de lecteur
                redirectPage = "stat.jsp";
                break;   

            case "supprimerLecteur.jsp":
                // Récupère les lecteurs qui n’ont pas d’emprunts pour les supprimer
                lecteurs = new LecteurDAO(dbPath).prendreLecteursSansEmprunt();
                request.setAttribute("lecteurs", lecteurs);
                redirectPage = "supprimerLecteur.jsp";
                break;

            case "deconnexion.jsp":
            	// Déconnecte le bibliothécaire (on récupère ses infos pour affichage)
            	int idBibliothecaire = (int) getServletContext().getAttribute("idBibliothecaire");
            	Bibliothecaire bibliothecaire = new BibliothecaireDAO(dbPath).prendreBibliothecaireById(idBibliothecaire);
                request.setAttribute("bibliothecaire", bibliothecaire);
                redirectPage = "deconnexion.jsp";
                break;

            case "emprunts.jsp":
            	// Affiche tous les emprunts
            	List<Emprunt> emprunts = new EmpruntDAO(dbPath).getAllEmprunts();
                request.setAttribute("emprunts", emprunts);
                redirectPage = "emprunts.jsp";
                break;

            case "lecteurs.jsp":
            	// Affiche tous les lecteurs
            	lecteurs = new LecteurDAO(dbPath).getAllLecteurs();
                request.setAttribute("lecteurs", lecteurs);
                redirectPage = "lecteurs.jsp";
                break;

            case "livres.jsp":
            	// Affiche tous les livres
				livres = new LivreDAO(dbPath).getAllLivres();
			    request.setAttribute("livres", livres);
			    redirectPage = "livres.jsp";
			    break;

            default:
                // Si aucune des pages ne correspond, on affiche le menu principal
                redirectPage = "menu.jsp";  
                break;
        }

        // Redirection vers la page JSP appropriée
		this.getServletContext().getRequestDispatcher("/WEB-INF/" + redirectPage).forward(request, response);
	}

    // Méthode POST redirige automatiquement vers GET
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}