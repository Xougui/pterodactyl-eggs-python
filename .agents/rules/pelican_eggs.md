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
