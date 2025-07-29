#!/bin/bash

# Vérifier si le mot de passe est défini
if [ -z "$PASSWORD" ]; then
	read -s -p "Password: " PASSWORD
	echo
	#echo $PASSWORD
	#sleep 5
fi


# Exporter les variables pour les utiliser avec d'autres processus si nécessaire
export PASSWORD=$PASSWORD


# Lancer la commande ft_lock
/usr/share/42/ft_lock &

# Attendre que ft_lock démarre temps en seconde
sleep 2400

# Simuler la saisie du mot de passe
xdotool type "$PASSWORD"
xdotool key Return

# Attendre un moment
sleep 0.1

# Lancer le script de log
./lock_V1.sh
