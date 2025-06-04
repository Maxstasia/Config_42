# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mstasiak <mstasiak@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/25 13:05:47 by mstasiak          #+#    #+#              #
#    Updated: 2025/02/25 14:29:18 by mstasiak         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

VENV_NAME = $(HOME)/.venv
VENV_BIN = $(VENV_NAME)/bin
PIP = $(VENV_BIN)/pip
PYTHON = $(VENV_BIN)/python
REQUIREMENTS = requirements.txt
SCRIPT = screen_saver.py

# Par défaut, exécuter le bot
all: run

# Création de l'environnement virtuel
$(VENV_NAME)/bin/activate: $(REQUIREMENTS)
	@echo "Création de l'environnement virtuel..."
	@python3 -m venv $(VENV_NAME)
	@$(PYTHON) -m pip install --upgrade pip setuptools wheel
	@$(PIP) install -r $(REQUIREMENTS)
	@echo "✅ Environnement virtuel créé et dépendances installées."

# Installer les dépendances
install: $(VENV_NAME)/bin/activate
	@echo "✅ Toutes les dépendances sont installées."

# Lancer le bot
run: install
	@echo "🚀 Lancement du programme..."
	@$(PYTHON) $(SCRIPT)

# Désinstaller tout
uninstall:
	@echo "🗑 Suppression de l'environnement virtuel..."
	@rm -rf $(VENV_NAME)
	@echo "✅ Environnement virtuel supprimé."

# Vérifier si les dépendances sont installées
check_deps:
	@echo "🔍 Vérification des dépendances..."
	@$(PIP) freeze > current_requirements.txt
	@diff current_requirements.txt $(REQUIREMENTS) > diff.txt; \
	if [ -s diff.txt ]; then \
		echo "⚠️ Des dépendances manquent ou sont obsolètes."; \
		echo "➡️ Vous pouvez utiliser 'make install' pour corriger."; \
	else \
		echo "✅ Toutes les dépendances sont installées et à jour."; \
	fi

# Créer un fichier requirements.txt si inexistant
$(REQUIREMENTS):
	@echo "tk" > $(REQUIREMENTS)
	@echo "📜 Fichier requirements.txt généré."
