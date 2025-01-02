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
#    Updated: 2024/01/02 19:02:15 by mstasiak         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="jonathan"

plugins=(git)

source $ZSH/oh-my-zsh.sh

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
 
function norme(){
	watch norminette -R CheckForbiddenSourceHearder
}

alias death="exec sgoinfre/Death-Note.sh"
alias Gambling="exec sgoinfre/Gamblings-School.sh"

alias francinette=/mnt/nfs/homes/mstasiak/francinette/tester.sh
alias paco=/mnt/nfs/homes/mstasiak/francinette/tester.sh
