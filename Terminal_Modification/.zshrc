# **************************************************************************** #
#                                                                              #
#                   ███████╗███████╗██╗  ██╗██████╗  ██████╗                   #
#                   ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝                   #
#                     ███╔╝ ███████╗███████║██████╔╝██║                        #
#                    ███╔╝  ╚════██║██╔══██║██╔══██╗██║                        #
#                   ███████╗███████║██║  ██║██║  ██║╚██████╗                   #
#                   ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝                   #
#                                                                              #
#                                                         :::      ::::::::    #
#    .zshrc                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mstasiak <mstasiak@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/15 14:42:22 by mstasiak          #+#    #+#              #
#    Updated: 2025/02/19 12:52:29 by mstasiak         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="jonathan"
plugins=(git)
source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# Alias :
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

function norme() {
    # Vérifier si la commande norminette est installée
    if ! command -v norminette &>/dev/null; then
        echo "Erreur : La commande 'norminette' n'est pas installée ou introuvable." >&2
        return 1
    fi

    # Exécuter norminette sur tous les arguments passés
    watch norminette -R CheckForbiddenSourceHeader "$@"
}


alias death=/home/$(whoami)/sgoinfre/lock/Death-Note.sh
alias Gambling=/home/$(whoami)/sgoinfre/lock/Gamblings-School.sh

alias francinette=/home/$(whoami)/francinette/tester.sh
alias paco=/home/$(whoami)/francinette/tester.sh
export PATH=/home/$(whoami)/.local/funcheck/host:$PATH
