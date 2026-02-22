# Application d'Analyse Intelligente des Incidents Réseau RAN & ENV

## 📋 Contexte du Projet
L'équipe Support Radio et Transmission FH gère quotidiennement un grand nombre d'incidents sur les réseaux RAN (Radio Access Network) et ENV (Environnement). Actuellement traités manuellement via des fichiers Excel/CSV, ce projet vise à développer une application web intelligente pour automatiser la lecture, l'analyse et le suivi des incidents.

## 🎯 Objectifs
- Automatiser l'import et l'analyse des fichiers Excel/CSV d'incidents
- Classifier intelligemment les incidents ENV et RAN par type d'alarme
- Détecter les causes racines et les sites sources des incidents
- Fournir un tableau de bord interactif pour les techniciens
- Générer des rapports et statistiques détaillés
- Assurer un suivi historique via base de données SQL

## 🤖 Types d'Incidents Analysés

### Incidents ENV (Environnement)
| Type d'Alarme | Description | Impact |
|--------------|-------------|--------|
| Coupure du courant | Perte totale d'alimentation électrique | Critique - Arrêt site |
| Batterie faible | Niveau de charge sous le seuil minimum | Élevé |
| Batterie défaillante | Batterie hors service | Critique |
| Variation du courant | Fluctuations anormales | Moyen |

### Incidents RAN (Radio Access Network)
| Type d'Alarme | Description |
|--------------|-------------|
| CLOCK | Détection du site origine causant la perte de synchronisation |
| Transmission | Classification FH (Fibre Hertzienne) ou Filaire |
| Sites partagés | Identification des sites TT ou Ooredoo |
| VSWR | Détection des anomalies d'antennes |

## 🏗 Architecture Technique
                ┌─────────────────┐
                │   FRONTEND      │
                │ HTML/CSS/Bootstrap│
                └────────┬────────┘
                         │
                ┌────────▼────────┐
                │   BACKEND + IA  │
                │  Python/Flask   │
                └────────┬────────┘
                         │
                ┌────────▼────────┐
                │   BASE SQL      │
                │ MySQL/SQLite    │
                └─────────────────┘

### Technologies Utilisées
| Couche | Technologie | Rôle |
|--------|------------|------|
| Frontend | HTML5/CSS3/Bootstrap 5 | Interface utilisateur responsive |
| Frontend | JavaScript/Chart.js | Graphiques interactifs |
| Backend | Python 3.x / Flask | API REST et logique métier |
| IA/Analyse | Pandas, NumPy | Traitement Excel/CSV |
| IA/ML | Scikit-learn | Classification automatique |
| Base de données | MySQL/SQLite | Stockage incidents |
| ORM | SQLAlchemy | Connexion Python-SQL |
| Exports | ReportLab/OpenPyXL | Génération PDF/Excel |

## 💻 Fonctionnalités Principales

- **Import de fichiers** : Upload Excel (.xlsx) et CSV
- **Classification IA** : Détection automatique des alarmes ENV/RAN
- **Analyse avancée** : 
  - Détection du site origine pour les incidents CLOCK
  - Identification du type de transmission (FH/Filaire)
  - Signalement des sites partagés (TT/Ooredoo)
  - Analyse des alarmes VSWR
- **Tableau de bord** : Visualisation interactive des incidents
- **Filtrage** : Par type, date, site, opérateur, catégorie
- **Export** : Rapports PDF et Excel
- **Historique** : Base de données SQL complète

## 🗄 Modèle de Base de Données

| Table | Description |
|-------|-------------|
| sites | Informations des sites réseau |
| incidents | Incidents importés des fichiers |
| alarmes_env | Alarmes environnementales |
| alarmes_ran | Alarmes radio (CLOCK, VSWR, transmission) |
| rapports | Historique des rapports générés |

## 📦 Installation

```bash
# Cloner le repository
git clone https://github.com/mohamedaliabdelli/projet_incidents.git

# Accéder au dossier
cd projet_incidents

# Créer un environnement virtuel
python -m venv venv

# Activer l'environnement
# Windows:
venv\Scripts\activate
# Linux/Mac:
source venv/bin/activate

# Installer les dépendances
pip install -r requirements.txt

# Configurer la base de données
python init_db.py

# Lancer l'application
python app.py

📁 Structure du Projet
projet_incidents/
│
├── README.md
├── requirements.txt
├── main.py
│
├── backend/
│   ├── app.py                        # Démarre le serveur Flask/FastAPI
│   │
│   ├── config/
│   │   ├── config.yaml               # Paramètres généraux
│   │   └── db_config.yaml            # Connexion base de données
│   │
│   ├── api/
│   │   ├── _init_.py
│   │   ├── vswr.py                   # Routes incidents VSWR
│   │   ├── clock.py                  # Routes incidents horloge
│   │   ├── rtwp.py                   # Routes incidents interférence
│   │   ├── env_alarms.py             # Routes alarmes environnement
│   │   ├── impact_service.py         # Routes impact sur services
│   │   └── stats.py                  # Routes statistiques globales
│   │
│   ├── services/
│   │   ├── _init_.py
│   │   ├── collector.py              # Collecte depuis les fichiers xlsx
│   │   ├── processor.py              # Nettoyage des données
│   │   ├── vswr_analyzer.py          # Analyse incidents VSWR
│   │   ├── clock_analyzer.py         # Analyse incidents horloge
│   │   ├── rtwp_analyzer.py          # Analyse interférences RTWP
│   │   ├── env_analyzer.py           # Analyse alarmes ENV
│   │   ├── impact_analyzer.py        # Analyse impact service
│   │   ├── classifier.py             # Classification automatique
│   │   └── alerting.py               # Génération des alertes
│   │
│   ├── models/
│   │   ├── _init_.py
│   │   ├── vswr_incident.py          # Modèle incident VSWR
│   │   ├── clock_incident.py         # Modèle incident horloge
│   │   ├── rtwp_incident.py          # Modèle incident interférence
│   │   ├── env_alarm.py              # Modèle alarme environnement
│   │   ├── impact_service.py         # Modèle impact service
│   │   └── user.py                   # Modèle utilisateur
│   │
│   └── tests/
│       ├── test_vswr.py
│       ├── test_clock.py
│       ├── test_rtwp.py
│       ├── test_env.py
│       └── test_impact.py
│
├── frontend/
│   ├── index.html                    # Page principale
│   │
│   ├── pages/
│   │   ├── dashboard.html            # Vue globale RAN + ENV
│   │   ├── vswr.html                 # Page incidents VSWR
│   │   ├── clock.html                # Page incidents horloge
│   │   ├── rtwp.html                 # Page interférences
│   │   ├── env_alarms.html           # Page alarmes ENV
│   │   ├── impact_service.html       # Page impact service
│   │   └── reports.html              # Export des rapports
│   │
│   ├── css/
│   │   ├── style.css                 # Style général
│   │   ├── dashboard.css             # Style tableau de bord
│   │   └── tables.css                # Style des tableaux
│   │
│   ├── js/
│   │   ├── api.js                    # Appels vers le backend
│   │   ├── charts.js                 # Affichage des graphiques
│   │   ├── vswr.js                   # Logique page VSWR
│   │   ├── clock.js                  # Logique page horloge
│   │   ├── rtwp.js                   # Logique page interférences
│   │   ├── env_alarms.js             # Logique page ENV
│   │   ├── impact_service.js         # Logique page impact
│   │   └── reports.js                # Logique export rapports
│   │
│   └── assets/
│       └── images/                   # Logos et icônes
│
├── database/
│   ├── schema.sql                    # Structure de toutes les tables
│   │
│   ├── migrations/
│   │   ├── 001_create_vswr.sql
│   │   ├── 002_create_clock.sql
│   │   ├── 003_create_rtwp.sql
│   │   ├── 004_create_env_alarms.sql
│   │   └── 005_create_impact_service.sql
│   │
│   ├── seeds/
│   │   ├── seed_vswr.sql
│   │   ├── seed_clock.sql
│   │   ├── seed_rtwp.sql
│   │   ├── seed_env_alarms.sql
│   │   └── seed_impact_service.sql
│   │
│   └── queries/
│       ├── vswr_queries.sql
│       ├── clock_queries.sql
│       ├── rtwp_queries.sql
│       ├── env_queries.sql
│       └── impact_queries.sql
│
├── data/
│   ├── raw/
│   │   ├── VSWR.xlsx
│   │   ├── clock.xlsx
│   │   ├── RTWP_interférence.xlsx
│   │   ├── alarmes_environnement.xlsx
│   │   └── impact_service.xlsx
│   │
│   ├── processed/
│   │   ├── vswr_clean.csv
│   │   ├── clock_clean.csv
│   │   ├── rtwp_clean.csv
│   │   ├── env_alarms_clean.csv
│   │   └── impact_service_clean.csv
│   │
│   ├── exports/
│   │   ├── csv/
│   │   └── excel/
│   │
│   └── notebooks/
│       ├── exploration_VSWR.py       # Script exploration données VSWR
│       ├── exploration_clock.py      # Script exploration données horloge
│       ├── exploration_RTWP.py       # Script exploration données RTWP
│       ├── exploration_ENV.py        # Script exploration données ENV
│       ├── exploration_impact.py     # Script exploration impact service
│       └── analyse_results.md        # Rapport des résultats d'analyse
│
└── docs/
    ├── architecture.md               # Schéma global du projet
    ├── user_guide.md                 # Guide d'utilisation
    └── api_reference.md              # Documentation des routes API
