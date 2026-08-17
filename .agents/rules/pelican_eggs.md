# Directives de conception des Eggs Pelican Panel / Pterodactyl

1. **Format YAML strict :**
   - Toujours vérifier l'indentation uniforme des blocs littéraux (`|-` ou `|`) contenant de l'ASCII art pour éviter les erreurs de parsing du service d'importation Pelican.
   - Maintenir la synchronisation 1:1 entre les exports `.yaml` et `.json`.

2. **Démarrage épuré (Startup Commands) :**
   - Ne jamais surcharger `startup_commands` avec de longs scripts bash ou de l'ASCII art inline (évite l'écho de commande du démon Wings et le double affichage).
   - Préférer un appel d'une seule ligne chargeant un script externe hébergé ou un point d'entrée exécutable :
     ```bash
     curl -sSL https://<domaine>/eggs/<script_startup>.sh | bash
     ```
   - Le script distant gère l'affichage de la version, la bannière, la mise à jour Git, l'installation des dépendances pip (`requirements.txt`), et l'exécution du processus final (`exec python ...`).

3. **Gestion propre des logs PIP & Dépendances :**
   - Éviter d'inonder la console avec les dizaines de lignes `Requirement already satisfied`.
   - Ne pas utiliser `-q` (qui masquerait les erreurs ou téléchargements réels), mais filtrer spécifiquement le bruit :
     ```bash
     pip install --disable-pip-version-check --no-warn-script-location -U --prefix .local -r "${REQUIREMENTS_FILE}" 2>&1 | grep -v -E "(Requirement already satisfied|^[[:space:]]*$)" || true
     ```
   - Conserver systématiquement les sorties d'erreur (`ERROR`, `WARN`, `Traceback`) pour que l'utilisateur puisse diagnostiquer les problèmes.

4. **Déploiement et Synchronisation Web :**
   - Les scripts de démarrage distants sont hébergés sur `https://xouxou-hosting.fr/eggs/<script>.sh`.
   - Après toute modification dans le projet `eggs`, synchroniser automatiquement le fichier dans `C:\Users\xougu\Desktop\xouxou_hosting\eggs/` (qui correspond à `/var/www/html/xouxou_hosting/eggs/` sur le serveur).
   - Lors des vérifications en ligne, utiliser un User-Agent valide (`curl/8.x`) pour valider la concordance du contenu et du hash.
