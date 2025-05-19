package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Livre;

import java.io.IOException;
import java.util.List;

import dao.LivreDAO;

public class supprimerLivre extends HttpServlet {
	private static final long serialVersionUID = 1L;

    // Constructeur
    public supprimerLivre() {
        super();
    }

    // Méthode GET : Supprime un livre par son ISBN et redirige vers la page des livres
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Récupération du chemin vers la base de données
		String dbPath = getServletContext().getRealPath("/WEB-INF/bibliotheque.db");

		// Récupération de l'ISBN du livre à supprimer
		String isbn = request.getParameter("isbn");

		// Suppression du livre dans la base de données via son ISBN
		new LivreDAO(dbPath).deleteLivre(isbn);

		// Récupération de la liste actualisée des livres
	    List<Livre> livres = new LivreDAO(dbPath).getAllLivres();

	    // Transmission de la liste des livres à la JSP
	    request.setAttribute("livres", livres);

	    // Redirection vers la page des livres
	    this.getServletContext().getRequestDispatcher("/WEB-INF/livres.jsp").forward(request, response);
	}

	// Méthode POST : Redirige vers la page des livres sans modification
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.getServletContext().getRequestDispatcher("/WEB-INF/livres.jsp").forward(request, response);
	}
}
