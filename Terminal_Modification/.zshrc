# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    .zshrc                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mstasiak <mstasiak@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/15 14:42:22 by mstasiak          #+#    #+#              #
#    Updated: 2025/09/05 11:07:28 by mstasiak         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="jonathan"
plugins=(git)
source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

export PATH=/home/$(whoami)/.local/funcheck/host:$PATH

#---------------------------------------ALIAS---------------------------------------#
#----------------------------------------ccc----------------------------------------#
#   - Crée un alias pour la commande cc                                             #
#   - Vérifie si le fichier source est fourni                                       #
#   - Crée un exécutable avec un nom différent                                      #
#   - Compile le fichier source avec des options de compilation                     #
#   - Vérifie si la compilation a réussi                                            #
#   - Exécute l'exécutable créé                                                     #
#   - Affiche un message d'erreur si la compilation échoue                          #
#   - Affiche un message d'erreur si le fichier source n'est pas fourni             #
#   - Affiche un message d'erreur si le fichier source n'est pas valide             #
#   - Affiche un message d'erreur si le fichier source n'est pas un fichier C       #
#----------------------------------------ccc----------------------------------------#
function ccc() {
    if [ -z "$1" ]; then
        echo "Usage: ccc <filename.c>"
    else
        # Crée un nom d'exécutable en ajoutant _exec à la fin du nom du fichier source
        executable="exe_${1%.*}"

        # Compile le fichier source avec l'exécutable nommé différemment
        cc -Wall -Wextra -Werror "$1" -o "$executable"

        # Vérifie si la compilation a réussi
        if [ $? -eq 0 ]; then
            echo "Compilation successful: Running $executable"

            # Exécute l'exécutable
            ./"$executable"
        else
            echo "Compilation failed"
        fi
    fi
}

#---------------------------------------norme---------------------------------------#
#   - Vérifie si la commande norminette est installée                               #
#   - Exécute norminette sur tous les fichiers passés en arguments                  #
#   - Utilise watch pour exécuter norminette en continu sur les fichiers            #
#   - Affiche un message d'erreur si la commande norminette n'est pas trouvée       #
#   - Affiche les résultats de norminette dans la console                           #
#---------------------------------------norme---------------------------------------#
function norme() {
    # Vérifier si la commande norminette est installée
    if ! command -v norminette &>/dev/null; then
        echo "Erreur : La commande 'norminette' n'est pas installée ou introuvable." >&2
        return 1
    fi

    # Exécuter norminette sur tous les arguments passés
    watch norminette -R CheckForbiddenSourceHeader "$@"
}

#------------------------------------all_git_pull-----------------------------------#
#   - Parcourt tous les répertoires dans le répertoire de travail                   #
#   - Vérifie si le répertoire contient un dépôt Git                                #
#   - Exécute la commande git pull dans chaque dépôt Git trouvé                     #
#   - Affiche un message indiquant le répertoire dans lequel git pull est exécuté   #
#------------------------------------all_git_pull-----------------------------------#
all_git_pull() {
    local workspace="$HOME/42"  # Remplace par ton chemin de travail
    for dir in "$workspace"/*; do
        if [ -d "$dir/.git" ]; then
            echo "🔄 Pulling in $dir..."
            (cd "$dir" && git pull)
        fi
    done
}

#-----------------------------------all_git_status----------------------------------#
#   - Parcourt tous les répertoires dans le répertoire de travail                   #
#   - Vérifie si le répertoire contient un dépôt Git                                #
#   - Exécute la commande git status dans chaque dépôt Git trouvé                   #
#   - Affiche un message indiquant le répertoire dans lequel git status est exécuté #
#-----------------------------------all_git_status----------------------------------#
all_git_status() {
    local workspace="$HOME/42"  # Remplace par ton chemin de travail
    for dir in "$workspace"/*; do
        if [ -d "$dir/.git" ]; then
            echo "🔄 status in $dir..."
            (cd "$dir" && git status)
        fi
    done
}



#------------------------------------screen_saver-----------------------------------#
#   - Change le répertoire de travail vers le répertoire de l'écran de veille       #
#   - Exécute la commande make pour compiler le projet                              #
#   - Change le répertoire de travail vers le répertoire personnel                  #
#   - Affiche un message d'erreur si la compilation échoue                          #
#------------------------------------screen_saver-----------------------------------#
function screen_saver() {
    cd /home/$(whoami)/sgoinfre/lock/screen_saver
    make
    cd
}

#---------------------------------------death---------------------------------------#
#   - lock l'écran grace à pimp my lock avec une video de Death Note                #
#---------------------------------------death---------------------------------------#
alias death=/home/$(whoami)/sgoinfre/lock/Death-Note.sh

#--------------------------------------Gambling-------------------------------------#
#   - lock l'écran grace à pimp my lock avec une video de Gambling School           #
#--------------------------------------Gambling-------------------------------------#
alias Gambling=/home/$(whoami)/sgoinfre/lock/Gamblings-School.sh



#--------------------------------------memcheck-------------------------------------#
#   - Utilise Valgrind pour vérifier les fuites de mémoire                          #
#   - Utilise le fichier de suppression par défaut de Valgrind                      #
#   - Utilise le mode de traçage des enfants pour suivre les processus enfants      #
#   - Utilise le mode de débogage complet pour obtenir des informations détaillées  #
#   - Utilise la taille de redzone de 32 octets pour détecter les débordements      #
#   - Utilise l'alignement de 16 octets pour les allocations mémoire                #
#   - Utilise le fichier de suppression par défaut de Valgrind                      #
#   - Affiche les fuites de mémoire dans un fichier de log                          #
#   - Affiche les informations de débogage dans le fichier de log                   #
#   - Affiche les informations de fuite de mémoire dans le fichier de log           #
#--------------------------------------memcheck-------------------------------------#
alias memcheck='valgrind --tool=memcheck \
    --leak-check=full \
    --leak-resolution=high \
    --show-leak-kinds=all \
    --track-origins=yes \
    --track-fds=yes \
    --num-callers=20 \
    --gen-suppressions=all \
    --suppressions=/usr/lib/valgrind/default.supp \
    --log-file=memcheck_%p.log \
    --trace-children=yes \
    --vgdb=full \
    --redzone-size=32 \
    --alignment=16'

#-------------------------------------cachegrind------------------------------------#
#   - Utilise Valgrind pour analyser les performances de la mémoire cache           #
#   - Utilise le mode de simulation de cache pour analyser les performances         #
#   - Utilise le mode de simulation de branche pour analyser les performances       #
#   - Utilise le nombre d'appels de 20 pour afficher les appels de fonction         #
#   - Utilise le fichier de log pour enregistrer les résultats de l'analyse         #
#   - Utilise le mode de traçage des enfants pour suivre les processus enfants      #
#   - Utilise le mode de débogage complet pour obtenir des informations détaillées  #
#   - Utilise le fichier de sortie de cachegrind pour enregistrer les résultats     #
#   - Utilise le fichier de suppression par défaut de Valgrind                      #
#   - Affiche les résultats de l'analyse dans le fichier de log                     #
#   - Affiche les informations de débogage dans le fichier de log                   #
#   - Affiche les informations de cachegrind dans le fichier de log                 #
#-------------------------------------cachegrind------------------------------------#
alias cachegrind='valgrind --tool=cachegrind \
    --cache-sim=yes \
    --branch-sim=yes \
    --num-callers=20 \
    --log-file=cachegrind_%p.log \
    --trace-children=yes \
    --vgdb=full \
    --cachegrind-out-file=cachegrind.out.%p'

#-------------------------------------callgring-------------------------------------#
#   - Utilise Valgrind pour analyser les performances de l'application              #
#   - Utilise le mode de simulation de cache pour analyser les performances         #
#   - Utilise le mode de simulation de branche pour analyser les performances       #
#   - Utilise le nombre d'appels de 20 pour afficher les appels de fonction         #
#   - Utilise le fichier de log pour enregistrer les résultats de l'analyse         #
#   - Utilise le mode de traçage des enfants pour suivre les processus enfants      #
#   - Utilise le mode de débogage complet pour obtenir des informations détaillées  #
#   - Utilise le fichier de sortie de callgrind pour enregistrer les résultats      #
#   - Utilise le fichier de suppression par défaut de Valgrind                      #
#   - Affiche les résultats de l'analyse dans le fichier de log                     #
#   - Affiche les informations de débogage dans le fichier de log                   #
#   - Affiche les informations de callgrind dans le fichier de log                  #
#   - Affiche les informations de performance dans le fichier de log                #
#   - Affiche les informations de simulation de cache dans le fichier de log        #
#   - Affiche les informations de simulation de branche dans le fichier de log      #
#   - Affiche les informations de simulation de mémoire dans le fichier de log      #
#   - Affiche les informations de simulation de performance dans le fichier de log  #
#-------------------------------------callgring-------------------------------------#
alias callgrind='valgrind --tool=callgrind \
    --dump-every-bb=1000000 \
    --collect-jumps=yes \
    --collect-systime=yes \
    --num-callers=20 \
    --log-file=callgrind_%p.log \
    --trace-children=yes \
    --vgdb=full \
    --callgrind-out-file=callgrind.out.%p'

#------------------------------------massifgrind------------------------------------#
#   - Utilise Valgrind pour analyser l'utilisation de la mémoire                    #
#   - Utilise le mode de simulation de mémoire pour check la mémoire utilisée       #
#   - Utilise le mode de simulation de pile pour check l'utilisation de la mémoire  #
#   - Utilise le nombre d'appels de 20 pour afficher les appels de fonction         #
#   - Utilise le fichier de log pour enregistrer les résultats de l'analyse         #
#   - Utilise le mode de traçage des enfants pour suivre les processus enfants      #
#   - Utilise le mode de débogage complet pour obtenir des informations détaillées  #
#   - Utilise le fichier de sortie de massif pour enregistrer les résultats         #
#   - Utilise le fichier de suppression par défaut de Valgrind                      #
#   - Affiche les résultats de l'analyse dans le fichier de log                     #
#   - Affiche les informations de débogage dans le fichier de log                   #
#   - Affiche les informations de massif dans le fichier de log                     #
#   - Affiche les informations de simulation de mémoire dans le fichier de log      #
#   - Affiche les informations de simulation de pile dans le fichier de log         #
#   - Affiche les informations de simulation de performance dans le fichier de log  #
#------------------------------------massifgrind------------------------------------#
alias massifgrind='valgrind --tool=massif \
    --heap=yes \
    --stacks=yes \
    --depth=30 \
    --alloc-fn=calloc,malloc,realloc \
    --detailed-freq=5 \
    --max-snapshots=200 \
    --num-callers=20 \
    --log-file=massif_%p.log \
    --trace-children=yes \
    --vgdb=full \
    --massif-out-file=massif.out.%p'

#--------------------------------------helgrind-------------------------------------#
#   - Utilise Valgrind pour vérifier les erreurs de concurrence                     #
#   - Utilise le mode de simulation de mémoire pour check les erreurs de concurrence#
#   - Utilise le mode de simulation de pile pour check les erreurs de concurrence   #
#   - Utilise le nombre d'appels de 20 pour afficher les appels de fonction         #
#   - Utilise le fichier de log pour enregistrer les résultats de l'analyse         #
#   - Utilise le mode de traçage des enfants pour suivre les processus enfants      #
#   - Utilise le mode de débogage complet pour obtenir des informations détaillées  #
#   - Utilise le fichier de sortie de helgrind pour enregistrer les résultats       #
#   - Utilise le fichier de suppression par défaut de Valgrind                      #
#   - Affiche les résultats de l'analyse dans le fichier de log                     #
#   - Affiche les informations de débogage dans le fichier de log                   #
#   - Affiche les informations de helgrind dans le fichier de log                   #
#   - Affiche les informations de simulation de mémoire dans le fichier de log      #
#   - Affiche les informations de simulation de pile dans le fichier de log         #
#   - Affiche les informations de simulation de performance dans le fichier de log  #
#   - Affiche les informations de simulation de concurrence dans le fichier de log  #
#   - Affiche les informations de simulation de thread dans le fichier de log       #
#   - Affiche les informations de simulation de synchro dans le fichier de log      #
#   - Affiche les informations de simulation de verrouillage dans le fichier de log #
#   - Affiche les informations de simulation de condition dans le fichier de log    #
#   - Affiche les informations de simulation de mutex dans le fichier de log        #
#   - Affiche les informations de simulation de sémaphore dans le fichier de log    #
#--------------------------------------helgrind-------------------------------------#
alias helgrind='valgrind --tool=helgrind \
    --free-is-write=yes \
    --history-level=full \
    --conflict-cache-size=10000000 \
    --num-callers=20 \
    --gen-suppressions=all \
    --trace-children=yes \
    --vgdb=full'

#--------------------------------------drdgrind-------------------------------------#
#   - Utilise Valgrind pour vérifier les erreurs de concurrence                     #
#   - Utilise le mode de simulation de mémoire pour check les erreurs de concurrence#
#   - Utilise le mode de simulation de pile pour check les erreurs de concurrence   #
#   - Utilise le nombre d'appels de 20 pour afficher les appels de fonction         #
#   - Utilise le fichier de log pour enregistrer les résultats de l'analyse         #
#   - Utilise le mode de traçage des enfants pour suivre les processus enfants      #
#   - Utilise le mode de débogage complet pour obtenir des informations détaillées  #
#   - Utilise le fichier de sortie de drdgrind pour enregistrer les résultats       #
#   - Utilise le fichier de suppression par défaut de Valgrind                      #
#   - Affiche les résultats de l'analyse dans le fichier de log                     #
#   - Affiche les informations de débogage dans le fichier de log                   #
#   - Affiche les informations de drdgrind dans le fichier de log                   #
#   - Affiche les informations de simulation de mémoire dans le fichier de log      #
#   - Affiche les informations de simulation de pile dans le fichier de log         #
#   - Affiche les informations de simulation de performance dans le fichier de log  #
#   - Affiche les informations de simulation de concurrence dans le fichier de log  #
#   - Affiche les informations de simulation de thread dans le fichier de log       #
#   - Affiche les informations de simulation de synchro dans le fichier de log      #
#   - Affiche les informations de simulation de verrouillage dans le fichier de log #
#   - Affiche les informations de simulation de condition dans le fichier de log    #
#   - Affiche les informations de simulation de mutex dans le fichier de log        #
#   - Affiche les informations de simulation de sémaphore dans le fichier de log    #
#--------------------------------------drdgrind-------------------------------------#
alias drdgrind='valgrind --tool=drd \
    --free-is-write=yes \
    --check-stack=yes \
    --segment-merging=yes \
    --num-callers=20 \
    --gen-suppressions=all \
    --suppressions=/usr/lib/valgrind/default.supp \
    --log-file=drd_%p.log \
    --trace-children=yes \
    --vgdb=full'

#------------------------------------segfaultgrind------------------------------------#
#   - Utilise Valgrind pour vérifier les erreurs de segmentation                      #
#   - Utilise le mode de simulation de mémoire pour check les erreurs de segmentation #
#   - Utilise le mode de simulation de pile pour check les erreurs de segmentation    #
#   - Utilise le nombre d'appels de 20 pour afficher les appels de fonction           #
#   - Utilise le fichier de log pour enregistrer les résultats de l'analyse           #
#   - Utilise le mode de traçage des enfants pour suivre les processus enfants        #
#   - Utilise le mode de débogage complet pour obtenir des informations détaillées    #
#   - Utilise le fichier de sortie de segfaultgrind pour enregistrer les résultats    #
#   - Utilise le fichier de suppression par défaut de Valgrind                        #
#------------------------------------segfaultgrind------------------------------------#
alias segfaultgrind='valgrind --tool=memcheck \
	--leak-check=full \
	--track-origins=yes'

#------------------------------------francinette------------------------------------#
#   - Alias pour utiliser la francinette                                            #
#------------------------------------francinette------------------------------------#
alias francinette=/home/$(whoami)/francinette/tester.sh

#----------------------------------------paco---------------------------------------#
#   - Alias pour utiliser la francinette sous le nom paco                           #
#----------------------------------------paco---------------------------------------#
alias paco=/home/$(whoami)/francinette/tester.sh

#------------------------------------reset_chrome-----------------------------------#
#   - Alias pour forcer la fermeture de google chrome                               #
#------------------------------------reset_chrome-----------------------------------#
alias reset_chrome='rm -rf ~/.config/google-chrome/Singleton* && rm -rf ~/.config/google-chrome'
