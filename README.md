# Egg Pterodactyl - Python Générique v4

Cet egg Pterodactyl permet d'héberger des applications Python génériques de manière flexible et sécurisée. Il est conçu pour supporter un large éventail de projets, du simple script au bot Discord complexe.

## Sommaire

- [Caractéristiques](#caractéristiques)
- [Images Docker Supportées](#images-docker-supportées)
- [Configuration](#configuration)
  - [Variables du Serveur](#variables-du-serveur)
- [Installation](#installation)
- [Sécurité](#sécurité)
  - [Jeton d'accès Git](#jeton-daccès-git)
  - [Accès SFTP](#accès-sftp)
- [Tests](#tests)
- [Auteur](#auteur)

## Caractéristiques

*   **Support Multi-versions :** Compatible avec Python 3.8 à 3.14 via des images Docker optimisées.
*   **Intégration Git :**
    *   Clonage de dépôts publics ou privés (via Token d'accès personnel).
    *   Sélection de la branche à utiliser.
    *   Mise à jour automatique au démarrage (configurable).
*   **Gestion des Dépendances :**
    *   Installation automatique depuis un fichier `requirements.txt` (nom de fichier configurable).
    *   Installation de paquets Python supplémentaires via une variable d'environnement.
    *   Support expérimental pour les paquets système (APT).
*   **Installation d'outils :** Installation optionnelle de FFmpeg (build statique).
*   **Flexibilité :** Un mode "User Upload" permet de désactiver Git pour gérer les fichiers manuellement via SFTP.
*   **Sécurité :** Le conteneur ne s'exécute pas avec des privilèges root.

## Images Docker Supportées

L'egg utilise les images Docker optimisées de `ghcr.io/pelican-eggs/yolks` :
*   Python 3.14
*   Python 3.13
*   Python 3.12
*   Python 3.11
*   Python 3.10
*   Python 3.9
*   Python 3.8

## Configuration

### Variables du Serveur

Voici les variables disponibles pour configurer votre serveur :

| Variable | Description | Défaut |
| :--- | :--- | :--- |
| **Adresse du dépôt Git** (`GIT_ADDRESS`) | URL `https` du dépôt Git à cloner (ex: `https://github.com/user/repo`). Ne pas inclure `.git` à la fin. | (Vide) |
| **Branche Git** (`BRANCH`) | Nom de la branche à utiliser. Laisser vide pour utiliser la branche par défaut du dépôt. | (Vide) |
| **Fichiers téléchargés par l'utilisateur** (`USER_UPLOAD`) | `1` pour ignorer l'installation Git. Utile si vous gérez vos fichiers manuellement via SFTP. | `0` |
| **Mise à jour automatique** (`AUTO_UPDATE`) | `1` pour exécuter `git pull` à chaque démarrage du serveur. | `0` |
| **Mise à jour PIP au démarrage** (`PIP_UPDATE`) | `1` pour installer les dépendances Python au démarrage. Désactivez (`0`) pour accélérer le boot si vos dépendances changent peu. | `1` |
| **Fichier .py principal** (`PY_FILE`) | Point d'entrée de l'application (ex: `main.py`, `bot.py`). | `main.py` |
| **Packages Python supplémentaires** (`PY_PACKAGES`) | Paquets `pip` à installer en plus du fichier `requirements.txt` (séparés par un espace). | (Vide) |
| **Packages Système supplémentaires** (`SYSTEM_PACKAGES`) | **(Expert)** Liste des paquets `.deb` à installer (séparés par un espace). Voir avertissement de sécurité. | (Vide) |
| **Nom d'utilisateur Git** (`USERNAME`) | Nom d'utilisateur pour cloner un dépôt privé. | (Vide) |
| **Jeton d'accès Git** (`ACCESS_TOKEN`) | Jeton d'accès personnel (`Personal Access Token`) pour un dépôt privé. | (Vide) |
| **Fichier requirements** (`REQUIREMENTS_FILE`) | Nom du fichier de dépendances `pip` (ex: `requirements.txt`). | `requirements.txt` |
| **Installer FFmpeg** (`INSTALL_FFMPEG`) | `1` pour télécharger et installer une version statique de FFmpeg, prête à l'emploi. | `0` |

> [!NOTE]
> Pensez à adapter la configuration de démarrage (`Startup Configuration`) dans le panel Pterodactyl en fonction des spécificités de votre projet (par exemple, la détection de fin de démarrage).

## Installation

1.  Téléchargez le fichier `egg_python_generic_4.json` depuis ce dépôt.
2.  Dans votre panel Pterodactyl, allez dans **Nests** -> **Import Egg**.
3.  Sélectionnez le fichier JSON et le Nest approprié.
4.  Créez un nouveau serveur en utilisant cet egg.

## Sécurité

### Jeton d'accès Git

> [!IMPORTANT]
> Le **Jeton d'accès Git (`ACCESS_TOKEN`)** est visible en clair par tous les utilisateurs ayant accès à l'onglet "Startup" du serveur. Pour des raisons de sécurité, il est impératif d'utiliser un token avec des permissions minimales (lecture seule du dépôt).

### Accès SFTP

> [!CAUTION]
> Le token Git est stocké dans la configuration locale du dépôt sur le serveur (`/home/container/.git/config`). **Ne donnez jamais d'accès SFTP ou de sous-utilisateur à des personnes non fiables**, car elles pourraient facilement récupérer ce token.

### Paquets Système (APT)

> [!WARNING]
> La fonctionnalité d'installation de paquets système (`SYSTEM_PACKAGES`) est **expérimentale** et doit être utilisée avec une extrême prudence.
> *   **Pas de résolution de dépendances :** Vous devez lister manuellement **tous** les fichiers `.deb` nécessaires pour un paquet et ses dépendances. Omettre une dépendance conduit quasi-systématiquement à un crash (`Segmentation fault`).
> *   **Instabilité :** Des paquets système mal configurés peuvent rendre le serveur instable ou inutilisable.
> *   **Alternative :** Pour des outils complexes comme FFmpeg, privilégiez l'option `INSTALL_FFMPEG` qui utilise un build statique et fiable.

## Validation

Il n'existe pas de suite de tests automatisés pour cet egg. La validation se fait manuellement en suivant ces étapes :

1.  **Importation :** Suivez les [instructions d'installation](#installation) pour importer l'egg dans votre panel Pterodactyl.
2.  **Création d'un serveur :** Créez un serveur en utilisant cet egg. Configurez-le avec un dépôt Git de test ou en mode "User Upload".
3.  **Vérification :** Démarrez le serveur et observez la console. Assurez-vous que le clonage Git et l'installation des dépendances (`pip`) se déroulent sans erreur.
4.  **Fonctionnement :** Confirmez que votre application Python démarre correctement et que les fonctionnalités clés (comme la mise à jour automatique) se comportent comme attendu.

Ce processus simple permet de garantir que l'egg est compatible avec votre environnement et que la configuration est correcte.

## Auteur

*   **GitHub:** @Xougui
*   **Mail:** xougui.7@gmail.com
*   **Discord:** @xougui
