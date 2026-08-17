#!/bin/bash
set -e

export PATH=$PATH:/home/container/.local/bin:/home/container
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH:/home/container/.apt/usr/lib/x86_64-linux-gnu:/home/container/.apt/usr/lib:/home/container/.apt/lib/x86_64-linux-gnu:/home/container/.apt/lib

# Couleurs ANSI modernes
CYAN='\033[38;2;64;224;208m'
BLUE='\033[38;2;99;102;241m'
GREEN='\033[38;2;52;211;153m'
YELLOW='\033[38;2;251;191;36m'
RED='\033[38;2;248;113;113m'
DIM='\033[38;2;148;163;184m'
BOLD='\033[1m'
NC='\033[0m'

# Banniere ASCII Art avec degradation de couleur
echo -e "${CYAN}"
cat << 'EOF'
   _  __           _  __               __  __           __  _            
  | |/ /___  __  _| |/ /___  __  __   / / / /___  _____/ /_(_)___  ____ _
  |   / __ \/ / / /   / __ \/ / / /  / /_/ / __ \/ ___/ __/ / __ \/ __ `/
 /   / /_/ / /_/ /   / /_/ / /_/ /  / __  / /_/ (__  ) /_/ / / / / /_/ / 
/_/|_\____/\__,_/_/|_\____/\__,_/  /_/ /_/\____/____/\__/_/_/ /_/\__, /  
                                                                /____/   
EOF
echo -e "${NC}"

# Information System & Environnement
PY_VER=$(python --version 2>&1 || echo "Python 3.x")
echo -e "${DIM}┌─${NC} ${BOLD}XouXou Hosting${NC} ${DIM}• Environment Details${NC}"
echo -e "${DIM}│${NC}  ${BOLD}Python${NC}    : ${GREEN}${PY_VER}${NC}"
echo -e "${DIM}│${NC}  ${BOLD}Execution${NC} : ${CYAN}${PY_FILE}${NC}"
if [[ -d .git ]]; then
    GIT_BRANCH=$(git branch --show-current 2>/dev/null || echo "main")
    echo -e "${DIM}│${NC}  ${BOLD}Git Repo${NC}  : ${BLUE}Branch [${GIT_BRANCH}]${NC}"
fi
echo -e "${DIM}└─────────────────────────────────────────────────────────────${NC}\n"

# Mise a jour Git
if [[ -d .git ]] && [[ "${AUTO_UPDATE}" == "1" ]]; then
    echo -e "${YELLOW}⚡ [GIT]${NC} Synchronisation du dépôt..."
    git pull || echo -e "${RED}⚠️  [GIT]${NC} Échec de synchronisation."
fi

# Gestion des dépendances PIP
if [[ "${PIP_UPDATE}" == "1" ]]; then
    if [[ -n "${PY_PACKAGES}" ]]; then
        echo -e "${BLUE}📦 [PIP]${NC} Installation des paquets supplémentaires..."
        pip install --disable-pip-version-check --no-warn-script-location -U --prefix .local ${PY_PACKAGES} 2>&1 | grep -v -E "(Requirement already satisfied|^[[:space:]]*$)" || true
    fi
    if [[ -f "/home/container/${REQUIREMENTS_FILE}" ]]; then
        echo -e "${BLUE}📦 [PIP]${NC} Vérification des dépendances (${REQUIREMENTS_FILE})..."
        pip install --disable-pip-version-check --no-warn-script-location -U --prefix .local -r "${REQUIREMENTS_FILE}" 2>&1 | grep -v -E "(Requirement already satisfied|^[[:space:]]*$)" || true
        echo -e "${GREEN}✓ [PIP]${NC} Toutes les dépendances sont prêtes."
    fi
fi

# Lancement de l'application Python
echo -e "\n${GREEN}🚀 [START]${NC} Lancement de l'application ${BOLD}${PY_FILE}${NC}...\n"
exec /usr/local/bin/python "/home/container/${PY_FILE}"
