# Egg Pterodactyl - Python Générique

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

L'egg utilise les images [`ghcr.io/pelican-eggs/yolks`](https://github.com/pelican-eggs/yolks/pkgs/container/yolks) :

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
| **Mise à jour PIP au démarrage** (`PIP_UPDATE`) | Mettre à `1` pour installer les dépendances pip au démarrage. | `1` |
| **Fichier .py principal** (`PY_FILE`) | Le point d'entrée de votre application (ex: `main.py`, `bot.py`). | `main.py` |
| **Packages Python supplémentaires** (`PY_PACKAGES`) | Liste de paquets pip à installer (séparés par un espace). | (Vide) |
| **Packages Système supplémentaires** (`SYSTEM_PACKAGES`) | Liste de paquets APT (.deb) à extraire. **Attention :** Les dépendances ne sont pas résolues automatiquement. Vous devez lister manuellement toutes les dépendances nécessaires. | (Vide) |
| **Nom d'utilisateur Git** (`USERNAME`) | Nom d'utilisateur pour les dépôts privés. | (Vide) |
| **Jeton d'accès Git** (`ACCESS_TOKEN`) | Personal Access Token (PAT) pour les dépôts privés. | (Vide) |
| **Fichier requirements** (`REQUIREMENTS_FILE`) | Nom du fichier listant les dépendances. | `requirements.txt` |

> [!TIP]
> **Sécurité :** Le Jeton d'accès Git (`ACCESS_TOKEN`) est visible par les utilisateurs ayant accès aux variables du serveur. Utilisez un token avec des droits limités (Scope: Read Only).

> [!IMPORTANT]
> **Attention :** Le token Git est stocké dans la configuration locale du dépôt. Ne donnez pas d'accès SFTP à des tiers non de confiance.

> [!NOTE]
> **Note :** Pensez à adapter la configuration de démarrage (Startup Configuration) dans le panel Pterodactyl en fonction des spécificités de votre projet (ex: détection de fin de démarrage).

## Installation

1.  Téléchargez le fichier [egg_python_generic_4.json](egg_python_generic_4.json) depuis ce dépôt.
2.  Dans votre panel Pterodactyl, allez dans **Nests** -> **Import Egg**.
3.  Sélectionnez le fichier JSON et le Nest approprié.
4.  Créez un nouveau serveur en utilisant cet egg.

## Tests

Il n'existe pas de commande de test automatisée pour cet egg. Le processus de test est manuel et consiste à vérifier que l'egg fonctionne comme prévu dans un environnement Pterodactyl.

Voici les étapes recommandées pour tester l'egg :

1.  **Importer l'egg** : Suivez les [instructions d'installation](#installation) pour importer le fichier [egg_python_generic_4.json](egg_python_generic_4.json) dans votre panel Pterodactyl.
2.  **Créer un serveur** : Créez un nouveau serveur en utilisant cet egg. Configurez les variables du serveur selon vos besoins (par exemple, en fournissant un dépôt Git de test).
3.  **Vérifier l'installation** : Démarrez le serveur et suivez les journaux de la console pour vous assurer que l'installation se déroule sans erreur. Vérifiez que le dépôt Git est cloné et que les dépendances Python sont installées correctement.
4.  **Valider la fonctionnalité** : Assurez-vous que votre application Python démarre et fonctionne comme prévu. Testez les différentes fonctionnalités de l'egg, comme la mise à jour automatique.

Ce processus de test manuel garantit que l'egg est compatible avec votre environnement et que la configuration de votre serveur est correcte.

## Auteur

*   **GitHub:** @Xougui  
*   **Mail:** xougui.7@gmail.com  
*   **Discord:** @xougui 
