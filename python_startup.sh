#!/bin/bash
set -e

export PATH=$PATH:/home/container/.local/bin:/home/container
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH:/home/container/.apt/usr/lib/x86_64-linux-gnu:/home/container/.apt/usr/lib:/home/container/.apt/lib/x86_64-linux-gnu:/home/container/.apt/lib

# Version Python
PY_VER=$(python --version 2>&1 || echo "Python 3.x")
echo "[INFO] Python version: ${PY_VER}"

# Banniere ASCII Art
cat << 'EOF'
   _  __           _  __               __  __           __  _            
  | |/ /___  __  _| |/ /___  __  __   / / / /___  _____/ /_(_)___  ____ _
  |   / __ \/ / / /   / __ \/ / / /  / /_/ / __ \/ ___/ __/ / __ \/ __ `/
 /   / /_/ / /_/ /   / /_/ / /_/ /  / __  / /_/ (__  ) /_/ / / / / /_/ / 
/_/|_\____/\__,_/_/|_\____/\__,_/  /_/ /_/\____/____/\__/_/_/ /_/\__, /  
                                                                /____/   
EOF

# Mise a jour Git
if [[ -d .git ]] && [[ "${AUTO_UPDATE}" == "1" ]]; then
    echo "[GIT] Mise a jour du depot..."
    git pull || echo "[WARN] [GIT] Echec du git pull."
fi

# Gestion des dependances PIP
if [[ "${PIP_UPDATE}" == "1" ]]; then
    if [[ -n "${PY_PACKAGES}" ]]; then
        echo "[INFO] Installing additional packages..."
        pip install --disable-pip-version-check --no-warn-script-location -U --prefix .local ${PY_PACKAGES} 2>&1 | grep -v -E "(Requirement already satisfied|^[[:space:]]*$)" || true
    fi
    if [[ -f "/home/container/${REQUIREMENTS_FILE}" ]]; then
        echo "[INFO] Installing modules from ${REQUIREMENTS_FILE}..."
        pip install --disable-pip-version-check --no-warn-script-location -U --prefix .local -r "${REQUIREMENTS_FILE}" 2>&1 | grep -v -E "(Requirement already satisfied|^[[:space:]]*$)" || true
        echo "[INFO] All modules from ${REQUIREMENTS_FILE} are up to date."
    fi
fi

# Lancement de l'application Python
echo "[INFO] Demarrage de l'application Python (${PY_FILE})..."
exec /usr/local/bin/python "/home/container/${PY_FILE}"
