#!/bin/bash

# Demander le mot de passe est défini
if [ -z "$PASSWORD" ]; then
	read -s -p "Password: " PASSWORD
	echo
fi

# Demander le chemin du fichier à afficher
if [ -z "$MEDIA_PATH" ]; then
	read -p "Path to media. Must be a file readable by mpv : " MEDIA_PATH
	MEDIA_PATH=${MEDIA_PATH:-"NO_MEDIA"}  # Définit MEDIA_PATH à "NO_MEDIA" si vide
	echo
fi

# Demander l'emplacement de l'affichage
if [[ -z "$MEDIA_POSITION_X" && "$MEDIA_PATH" != "NO_MEDIA" ]]; then
	read -p "Position of media in x axis (In pixel, In percentage followed by '%', or left, center, right) : " MEDIA_POSITION_X
	MEDIA_POSITION_X=${MEDIA_POSITION_X:-"center"}
	echo
fi
if [[ -z "$MEDIA_POSITION_Y" && "$MEDIA_PATH" != "NO_MEDIA" ]]; then
	read -p "Position of media in y axis (In pixel, In percentage followed by '%', or top, center, bottom) : " MEDIA_POSITION_Y
	MEDIA_POSITION_Y=${MEDIA_POSITION_Y:-"center"}
	echo
fi

# Demander la taille de l'affichage
if [[ -z "$MEDIA_WIDTH" && "$MEDIA_PATH" != "NO_MEDIA" ]]; then
	read -p "Media Width (In pixel, In percentage followed by '%') : " MEDIA_WIDTH
	echo
fi
if [[ -z "$MEDIA_HEIGHT" && "$MEDIA_PATH" != "NO_MEDIA" ]]; then
	read -p "Media Height (In pixel, In percentage followed by '%') : " MEDIA_HEIGHT
	echo
fi



# Exporter les variables pour les utiliser avec d'autres processus si nécessaire
export PASSWORD=$PASSWORD
export MEDIA_PATH=$MEDIA_PATH
export MEDIA_WIDTH=$MEDIA_WIDTH
export MEDIA_HEIGHT=$MEDIA_HEIGHT
export MEDIA_POSITION_X=$MEDIA_POSITION_X
export MEDIA_POSITION_Y=$MEDIA_POSITION_Y



# Détecter si l'utilisateur a saisi un chemin ou non
if [[ "$MEDIA_PATH" == "NO_MEDIA" ]]; then
    # Si l'utilisateur appuie sur "Return" sans fournir de chemin, on exécute ft_lock
    ft_lock
else
    # Si un fichier est fourni, on exécute pimp_my_lock avec les paramètres
	# Usage: $PROGRAM_NAME <media> [<x> <y>] [<width>] [<height>]
    ./pimp_my_lock_custom/pimp_my_lock "$MEDIA_PATH" "$MEDIA_POSITION_X" "$MEDIA_POSITION_Y" "$MEDIA_WIDTH" "$MEDIA_HEIGHT"
fi



# Temps en seconde avnt le relog
sleep 30

# Simuler la saisie du mot de passe
xdotool type "$PASSWORD"
xdotool key Return

# Attendre un moment
sleep 0.5

# Relancer le script de relog
./lock.sh
