# Egg Pterodactyl - Python Générique (Robust)

Cet egg Pterodactyl permet d'héberger facilement des applications Python génériques. Il est conçu pour être robuste, sécurisé et flexible.

## Fonctionnalités

*   **Support Multi-versions :** Compatible avec Python 3.8 à 3.14 via des images Docker optimisées.
*   **Intégration Git :**
    *   Clonage de dépôts publics et privés (via Token).
    *   Choix de la branche.
    *   Mise à jour automatique au démarrage (configurable).
*   **Gestion des Dépendances :**
    *   Installation automatique depuis `requirements.txt` (nom du fichier configurable).
    *   Installation de paquets supplémentaires via une variable d'environnement.
*   **Mode Upload Utilisateur :** Possibilité de désactiver Git pour gérer les fichiers manuellement via SFTP.
*   **Sécurité :** Ne nécessite pas de privilèges root pour l'exécution du script.

## Images Docker Supportées

L'egg utilise les images `ghcr.io/pelican-eggs/yolks` :

*   Python 3.14
*   Python 3.13
*   Python 3.12
*   Python 3.11
*   Python 3.10
*   Python 3.9
*   Python 3.8

## Configuration

Voici les variables disponibles pour configurer votre serveur :

| Variable | Description | Défaut |
| :--- | :--- | :--- |
| **Adresse du dépôt Git** (`GIT_ADDRESS`) | URL du dépôt Git à cloner (ex: `https://github.com/user/repo`). | (Vide) |
| **Branche Git** (`BRANCH`) | La branche à cloner. Laisser vide pour utiliser la branche par défaut. | (Vide) |
| **Fichiers téléchargés par l'utilisateur** (`USER_UPLOAD`) | Mettre à `1` pour ignorer Git et gérer les fichiers manuellement. | `0` |
| **Mise à jour automatique** (`AUTO_UPDATE`) | Mettre à `1` pour faire un `git pull` à chaque démarrage. | `0` |
| **Fichier .py principal** (`PY_FILE`) | Le point d'entrée de votre application (ex: `main.py`, `bot.py`). | `main.py` |
| **Packages Python supplémentaires** (`PY_PACKAGES`) | Liste de paquets pip à installer (séparés par un espace). | (Vide) |
| **Nom d'utilisateur Git** (`USERNAME`) | Nom d'utilisateur pour les dépôts privés. | (Vide) |
| **Jeton d'accès Git** (`ACCESS_TOKEN`) | Personal Access Token (PAT) pour les dépôts privés. | (Vide) |
| **Fichier requirements** (`REQUIREMENTS_FILE`) | Nom du fichier listant les dépendances. | `requirements.txt` |

## Installation

1.  Téléchargez le fichier [egg_python_generic_3.json](egg_python_generic_3.json) depuis ce dépôt.
2.  Dans votre panel Pterodactyl, allez dans **Nests** -> **Import Egg**.
3.  Sélectionnez le fichier JSON et le Nest approprié.
4.  Créez un nouveau serveur en utilisant cet egg.

## Auteur

xougui.7@gmail.com
