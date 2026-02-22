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
├── app/
│   ├── static/
│   │   ├── css/
│   │   ├── js/
│   │   └── images/
│   ├── templates/
│   ├── routes/
│   └── models/
├── backend/
│   ├── ia/
│   │   ├── classification_env.py
│   │   ├── classification_ran.py
│   │   └── analyse_clock.py
│   ├── data_processing/
│   └── exports/
├── database/
│   └── schema.sql
├── tests/
├── uploads/
├── docs/
├── requirements.txt
├── config.py
├── app.py
└── README.md