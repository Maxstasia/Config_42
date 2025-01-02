" **************************************************************************** "
"                                                                              "
"                   ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗                    "
"                   ██║   ██║██║████╗ ████║██╔══██╗██╔════╝                    "
"                   ██║   ██║██║██╔████╔██║██████╔╝██║                         "
"                   ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║                         "
"                    ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗                    "
"                     ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝                    "
"                                                                              "
"                                                         :::      ::::::::    "
"    .vimrc                                             :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: mstasiak <mstasiak@student.42.fr>          +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2024/09/15 14:42:22 by mstasiak          #+#    #+#              "
"    Updated: 2024/12/04 12:51:30 by mstasiak         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "


" Affiche partiellement les commandes que vous tapez dans la dernière ligne de l'écran. "  
set showcmd



" Indique le mode actif (par exemple, insertion, normal) sur la dernière ligne de l'écran. "
set showmode



" Désactive le retour automatique à la ligne. Les lignes longues s'étendent sur toute leur longueur sans être coupées. "
set nowrap



" Active l'affichage des caractères invisibles. "
set list
" Configure l'affichage des caractères invisibles selon des symboles personnalisés. "
set listchars=space:•,eol:¶,trail:©,tab:➢\ 



" Charge les fichiers d'indentation spécifiques au type de fichier détecté. "
filetype indent on
" Définit une largeur de décalage de 4 espaces pour l'indentation. "
set shiftwidth=4
" Définit la largeur d'une tabulation à 4 colonnes. "
set tabstop=4
" Remplace les espaces de 4 par des tabulations. "
set noexpandtab



" Montre les mots correspondants lors d'une recherche. "
set showmatch
" Utilise la coloration syntaxique pour surligner les résultats de recherche. "
set hlsearch
" Pendant la recherche dans un fichier, surligne progressivement les caractères correspondant au fur et à mesure que vous tapez. "
set incsearch
" Ignore les majuscules lors des recherches. "
set ignorecase



" Active la prise en charge de la souris dans toutes les zones de l'éditeur. "
set mouse=a
" Configure Vim pour l'utilisation en mode terminal. "
"bo term
