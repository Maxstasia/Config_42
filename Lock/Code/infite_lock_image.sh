#!/bin/bash

# Vérifier si le mot de passe est défini
if [ -z "$PASSWORD" ]; then
    read -s -p "Password: " PASSWORD
	echo
fi



# Demander le chemin du fichier à afficher
if [ -z "$MEDIA_PATH" ]; then
    read -p "Media Path (image or video file): " MEDIA_PATH
	echo
fi



# Demander la taille de l'affichage
if [ -z "$MEDIA_WIDTH" ]; then
	read -p "Media Width (e.g., 50% or 500px): " MEDIA_WIDTH
	echo
fi
if [ -z "$MEDIA_HEIGHT" ]; then
	read -p "Media Height (e.g., 50% or 500px): " MEDIA_HEIGHT
	echo
fi



# Demander l'emplacement de l'affichage
if [ -z "$MEDIA_POSITION" ]; then
	read -p "Media Position (keywords: top, bottom, left, right or custom pixels like +100+200): " MEDIA_POSITION
	echo
fi



# Exporter les variables pour les utiliser avec d'autres processus si nécessaire
export PASSWORD=$PASSWORD
export MEDIA_PATH=$MEDIA_PATH
export MEDIA_WIDTH=$MEDIA_WIDTH
export MEDIA_HEIGHT=$MEDIA_HEIGHT
export MEDIA_POSITION=$MEDIA_POSITION



# Déterminer la géométrie basée sur les mots-clés ou les pixels
case "$MEDIA_POSITION" in
    top)
        MEDIA_GEOMETRY="+0+0" ;;         # Haut gauche
    bottom)
        MEDIA_GEOMETRY="+0-0" ;;        # Bas gauche
    left)
        MEDIA_GEOMETRY="+0+0" ;;        # Haut gauche
    right)
        MEDIA_GEOMETRY="-0+0" ;;        # Haut droit
    *)
        MEDIA_GEOMETRY="$MEDIA_POSITION" ;; # Position personnalisée
esac



# Détecter le type de fichier et ajuster les options d'affichage
if [[ "$MEDIA_PATH" =~ \.(jpg|jpeg|png|gif)$ ]]; then
    # Afficher l'image
    mpv --no-input-terminal --geometry=${MEDIA_WIDTH}x${MEDIA_HEIGHT}${MEDIA_GEOMETRY} --ontop "$MEDIA_PATH" > /dev/null 2>&1 &
elif [[ "$MEDIA_PATH" =~ \.(mp4|mkv|avi)$ ]]; then
    # Lire la vidéo en boucle
    mpv --no-input-terminal --geometry=${MEDIA_WIDTH}x${MEDIA_HEIGHT}${MEDIA_GEOMETRY} --ontop --loop "$MEDIA_PATH" > /dev/null 2>&1 &
else
    echo "Error: Unsupported file format. Please provide an image (jpg, png, gif) or video (mp4, mkv, avi)." >&2
    exit 1
fi



# Lancer la commande ft_lock
/usr/share/42/ft_lock &

# Attendre que ft_lock démarre temps en seconde
sleep 30

# Simuler la saisie du mot de passe
xdotool type "$PASSWORD"
xdotool key Return

# Attendre un moment
sleep 0.5

# Lancer le script de log
./lock_V2.sh
