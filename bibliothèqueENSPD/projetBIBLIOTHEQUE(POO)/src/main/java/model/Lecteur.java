package model;

public class Lecteur {
    private int idLecteur;
    private String nomLecteur;
    private String adresseLecteur;
    private String numeroCNI;
    private int nombreEmpruntEnCours;
    

    public String getNumeroCNI() {
		return numeroCNI;
	}

	public void setNumeroCNI(String numeroCNI) {
		this.numeroCNI = numeroCNI;
	}

	public int getNombreEmpruntEnCours() {
		return nombreEmpruntEnCours;
	}

	public void setNombreEmpruntEnCours(int nombreEmpruntEnCours) {
		this.nombreEmpruntEnCours = nombreEmpruntEnCours;
	}

	public int getIdLecteur() {
        return idLecteur;
    }

    public void setIdLecteur(int idLecteur) {
        this.idLecteur = idLecteur;
    }

    public String getNomLecteur() {
        return nomLecteur;
    }

    public void setNomLecteur(String nomLecteur) {
        this.nomLecteur = nomLecteur;
    }

    public String getAdresseLecteur() {
        return adresseLecteur;
    }

    public void setAdresseLecteur(String adresseLecteur) {
        this.adresseLecteur = adresseLecteur;
    }
}
