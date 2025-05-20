// Attendre que le DOM soit complètement chargé
document.addEventListener("DOMContentLoaded", function() {
    // Gestion de la navigation entre les sections
    initNavigation();
    
    // Initialisation des graphiques
    initCharts();
});

// Fonction pour gérer la navigation entre les sections de statistiques
function initNavigation() {
    const navItems = document.querySelectorAll('.stats-nav-item');
    
    navItems.forEach(item => {
        item.addEventListener('click', function() {
           
            navItems.forEach(nav => nav.classList.remove('active'));
            
            
            this.classList.add('active');
            
            const sectionId = this.getAttribute('onclick').match(/showSection\('(.+?)'\)/)[1];
            showSection(sectionId);
        });
    });
}

// Fonction pour afficher une section spécifique
function showSection(sectionId) {
    // Cacher toutes les sections
    document.querySelectorAll('.stats-section').forEach(section => {
        section.classList.remove('active');
    });
    
    // Afficher la section demandée
    document.getElementById(sectionId).classList.add('active');
    
    // Activer le bouton de navigation correspondant
    document.querySelectorAll('.stats-nav-item').forEach(item => {
        item.classList.remove('active');
        if (item.getAttribute('onclick').includes(sectionId)) {
            item.classList.add('active');
        }
    });
}

// Fonction pour initialiser tous les graphiques
function initCharts() {
    
    createEmpruntsChart();
    
    
    createAnneePublicationChart();
    
    // Graphique des lecteurs par tranche d'âge
    createAgeChart();
    
    // Graphique des emprunts par jour de la semaine
    createJourSemaineChart();
    
    // Graphique de l'évolution annuelle des emprunts
    createEvolutionAnnuelleChart();
}

// Création du graphique des tendances d'emprunts mensuels
function createEmpruntsChart() {
    const ctx = document.getElementById('empruntsChart').getContext('2d');
    
    // Données des 12 derniers mois
    const data = {
        labels: ['Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre', 'Janvier', 'Février', 'Mars', 'Avril', 'Mai'],
        datasets: [
            {
                label: 'Nombre d\'emprunts',
                data: [65, 59, 80, 81, 56, 55, 40, 45, 60, 70, 72, 68],
                fill: true,
                backgroundColor: 'rgba(74, 111, 165, 0.2)',
                borderColor: 'rgba(74, 111, 165, 1)',
                tension: 0.4
            }
        ]
    };
    
    new Chart(ctx, {
        type: 'line',
        data: data,
        options: {
            responsive: true,
            plugins: {
                title: {
                    display: false
                },
                legend: {
                    display: false
                },
                tooltip: {
                    mode: 'index',
                    intersect: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: {
                        drawBorder: false
                    }
                },
                x: {
                    grid: {
                        display: false
                    }
                }
            }
        }
    });
}

// Création du graphique des livres par année de publication
function createAnneePublicationChart() {
    const ctx = document.getElementById('anneePublicationChart').getContext('2d');
    
    // Données par décennie
    const data = {
        labels: ['Avant 1950', '1950-1959', '1960-1969', '1970-1979', '1980-1989', '1990-1999', '2000-2009', '2010-2019', '2020+'],
        datasets: [
            {
                label: 'Nombre de livres',
                data: [15, 22, 30, 40, 55, 75, 100, 85, 28],
                backgroundColor: 'rgba(74, 111, 165, 0.8)',
                borderColor: 'rgba(74, 111, 165, 1)',
                borderWidth: 1
            }
        ]
    };
    
    new Chart(ctx, {
        type: 'bar',
        data: data,
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}

// Création du graphique des lecteurs par tranche d'âge
function createAgeChart() {
    const ctx = document.getElementById('ageChart').getContext('2d');
    
    const data = {
        labels: ['Moins de 18 ans', '18-25 ans', '26-40 ans', '41-60 ans', 'Plus de 60 ans'],
        datasets: [
            {
                data: [35, 42, 65, 28, 17],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.8)',
                    'rgba(54, 162, 235, 0.8)',
                    'rgba(255, 206, 86, 0.8)',
                    'rgba(75, 192, 192, 0.8)',
                    'rgba(153, 102, 255, 0.8)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)'
                ],
                borderWidth: 1
            }
        ]
    };
    
    new Chart(ctx, {
        type: 'pie',
        data: data,
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'right'
                }
            }
        }
    });
}

// Création du graphique des emprunts par jour de la semaine
function createJourSemaineChart() {
    const ctx = document.getElementById('jourSemaineChart').getContext('2d');
    
    const data = {
        labels: ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'],
        datasets: [
            {
                label: 'Nombre d\'emprunts',
                data: [12, 15, 22, 10, 18, 30, 5],
                backgroundColor: 'rgba(74, 111, 165, 0.8)',
                borderColor: 'rgba(74, 111, 165, 1)',
                borderWidth: 1
            }
        ]
    };
    
    new Chart(ctx, {
        type: 'bar',
        data: data,
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}

// Création du graphique de l'évolution annuelle des emprunts
function createEvolutionAnnuelleChart() {
    const ctx = document.getElementById('evolutionAnnuelleChart').getContext('2d');
    
    // Données pour les 3 dernières années
    const data = {
        labels: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'],
        datasets: [
            {
                label: '2023',
                data: [42, 45, 51, 49, 54, 52, 45, 40, 54, 58, 56, 55],
                borderColor: 'rgba(153, 102, 255, 1)',
                backgroundColor: 'rgba(153, 102, 255, 0.2)',
                fill: false,
                tension: 0.4
            },
            {
                label: '2024',
                data: [48, 50, 55, 57, 56, 60, 55, 50, 62, 65, 64, 60],
                borderColor: 'rgba(75, 192, 192, 1)',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                fill: false,
                tension: 0.4
            },
            {
                label: '2025',
                data: [58, 60, 65, 67, 68, 70, 72, 71, 75, null, null, null],
                borderColor: 'rgba(255, 99, 132, 1)',
                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                fill: false,
                tension: 0.4
            }
        ]
    };
    
    new Chart(ctx, {
        type: 'line',
        data: data,
        options: {
            responsive: true,
            plugins: {
                tooltip: {
                    mode: 'index',
                    intersect: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}