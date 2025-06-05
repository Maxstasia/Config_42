#!/bin/bash

# Vérifier si le mot de passe est défini
if [ -z "$PASSWORD" ]; then
    read -s -p "Password: " PASSWORD
	echo
fi


# Exporter les variables pour les utiliser avec d'autres processus si nécessaire
export PASSWORD=$PASSWORD


# Lancer la commande ft_lock
/usr/share/42/ft_lock &

# Attendre que ft_lock démarre temps en seconde
sleep 10

# Simuler la saisie du mot de passe
xdotool type "$PASSWORD"
xdotool key Return

# Attendre un moment
sleep 0.5

# Lancer le script de log
./lock_V1.sh
