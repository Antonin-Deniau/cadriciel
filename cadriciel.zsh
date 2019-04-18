################
# ARCHITECTURE #
################

# ~/tools                           # Contain manually installed tools
# ~/.bin                            # Contain symbolic links to manually installed tools
# ~/cadriciel                       # You are in this folder
# ~/cadriciel/init.zsh              # The init file, used for installation
# ~/cadriciel/cadriciel.zsh         # The main file, linked to your .zshrc file
# ~/cadriciel/plugins               # Contain locals plugins
# ~/cadriciel/conf/mountpoints.conf # Contain SSH mountpoints
# ~/cadriciel/conf/editorconfig     # The editorconfig file

########################
# USEFULL TOOLS TO ADD #
########################

# jq     # Parse and query json from the cli
# ag/rg  # Fast find/grep from the cli
# up     # Interactive pipe
# pyenv  # Manage python versions
# nvm    # Manage node versions

#########
# ZPLUG #
#########
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "plugins/git", from:oh-my-zsh
zplug "themes/nicoulaj", from:oh-my-zsh
zplug "hcgraf/zsh-mercurial"

# Load local plugins
zplug "~/cadriciel/plugins/*", from:local
for plugin in ~/cadriciel/plugins/*; do
    zplug $plugin, from:local
done

if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi
zplug load

###########
# ALIASES #
###########

alias 'a'='alias'
a 'ccat'='pygmentize -g'
a 'vi'='nvim'
a 'vim'='nvim'
a 'less'='pygmentize -g | /bin/less'
a 'ls'='ls --color=auto'
#########
# BINDS #
#########

export LESSCHARSET="UTF-8"

# Correspondance touches-fonction
bindkey '^A'    beginning-of-line       # Home
bindkey '^E'    end-of-line             # End
bindkey '^D'    delete-char             # Del
bindkey '^U' 	backward-kill-line		# Override kill-whole-line
#bindkey '^W' 	kill-region				# Override backward-kill-word
bindkey '[3~' delete-char             # Del
bindkey '[2~' overwrite-mode          # Insert
bindkey '[5~' history-search-backward # pgup
bindkey '[6~' history-search-forward  # pgdn
bindkey '^[[1;5D' backward-word		# Ctrl + gauche 
bindkey '^[[1;5C' forward-word		# Ctrl + droite
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down
bindkey '^[[Z' reverse-menu-complete

##########
# COLORS #
##########

:<<EOF
# Prompt couleur (la couleur n'est pas la même pour le root et
# pour les simples utilisateurs)
if [ "`id -u`" -eq 0 ]; then
  export PS1="%{[33;36;1m%}%T%{[0m%} %{[33;34;1m%}%n%{[0m[33;33;1m%}@%{[33;37;1m%}%m %{[33;32;1m%}%~%{[0m[33;33;1m%}%#%{[0m%} "
else
  export PS1="%{[33;36;1m%}%T%{[0m%} %{[33;31;1m%}%n%{[0m[33;33;1m%}@%{[33;37;1m%}%m %{[33;32;1m%}%~%{[0m[33;33;1m%}%#%{[0m%} "
fio
EOF

# Console linux, dans un screen ou un rxvt
if [ "$TERM" = "linux" -o "$TERM" = "screen" -o "$TERM" = "rxvt" ]
then
  # Correspondance touches-fonction spécifique
  bindkey '[1~' beginning-of-line       # Home
  bindkey '[4~' end-of-line             # End
fi

# xterm
if [ "$TERM" = "xterm" ]
then
  # Correspondance touches-fonction spécifique
  bindkey '[H'  beginning-of-line       # Home
  bindkey '[F'  end-of-line             # End
fi

# Gestion de la couleur pour 'ls' (exportation de LS_COLORS)
if [ -x /usr/bin/dircolors ]
then
  if [ -r ~/.dir_colors ]
  then
    eval "`dircolors ~/.dir_colors`"
  elif [ -r /etc/dir_colors ]
  then
    eval "`dircolors /etc/dir_colors`"
  fi
fi

###############
# ZSH Options #
###############

# Pour UTF8
setopt printeightbit

# Pour UTF8
setopt printeightbit

# Je ne veux JAMAIS de beeps


unsetopt beep
unsetopt hist_beep
unsetopt list_beep
# >| doit être utilisés pour pouvoir écraser un fichier déjà existant ;
# le fichier ne sera pas écrasé avec '>'
setopt clobber
# Ctrl+D est équivalent à 'logout'
unsetopt ignore_eof
# Affiche le code de sortie si différent de '0'
setopt print_exit_value
# Demande confirmation pour 'rm *'
unsetopt rm_star_silent
# Correction orthographique des commandes
# Désactivé car, contrairement à ce que dit le "man", il essaye de
# corriger les commandes avant de les hasher
#setopt correct

# Schémas de complétion

# - Schéma A :
# 1ère tabulation : complète jusqu'au bout de la partie commune
# 2ème tabulation : propose une liste de choix
# 3ème tabulation : complète avec le 1er item de la liste
# 4ème tabulation : complète avec le 2ème item de la liste, etc...
# -> c'est le schéma de complétion par défaut de zsh.

# Schéma B :
# 1ère tabulation : propose une liste de choix et complète avec le 1er item
#                   de la liste
# 2ème tabulation : complète avec le 2ème item de la liste, etc...
# Si vous voulez ce schéma, décommentez la ligne suivante :
#setopt menu_complete

# Schéma C :
# 1ère tabulation : complète jusqu'au bout de la partie commune et
#                   propose une liste de choix
# 2ème tabulation : complète avec le 1er item de la liste
# 3ème tabulation : complète avec le 2ème item de la liste, etc...
# Je n'ai malheureusement jamais réussi à mettre en place ce schéma
# alors qu'il me paraît être le schéma idéal !
# Si vous savez comment faire ça avec zsh -> alexis@via.ecp.fr

# Options de complétion
# Quand le dernier caractère d'une complétion est '/' et que l'on
# tape 'espace' après, le '/' est effaçé
setopt auto_remove_slash
# Fait la complétion sur les fichiers et répertoires cachés
setopt glob_dots

# Traite les liens symboliques comme il faut
setopt chase_links

# Quand l'utilisateur commence sa commande par '!' pour faire de la
# complétion historique, il n'exécute pas la commande immédiatement
# mais il écrit la commande dans le prompt
setopt hist_verify
# Si la commande est invalide mais correspond au nom d'un sous-répertoire
# exécuter 'cd sous-répertoire'
setopt auto_cd
# L'exécution de "cd" met le répertoire d'où l'on vient sur la pile
setopt auto_pushd
# Ignore les doublons dans la pile
setopt pushd_ignore_dups
# N'affiche pas la pile après un "pushd" ou "popd"
setopt pushd_silent
# "pushd" sans argument = "pushd $HOME"
setopt pushd_to_home

# Les jobs qui tournent en tâche de fond sont nicé à '0'
unsetopt bg_nice
# N'envoie pas de "HUP" aux jobs qui tourent quand le shell se ferme
unsetopt hup
## AUTRES OPTIONS
#setopt correct                           # correction des commandes
#setopt correct_all                       # correction des arguments
setopt hist_ignore_dups                  # vire les commandes en double
unsetopt hist_ignore_space               # n'ignore pas les espaces dans l'his.
#setopt hist_no_store                     # n'enregistre pas la cmd history

#
# 5. Complétion des options des commandes
#

zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' menu select
zstyle ":completion:*:commands" rehash 1 # Ne pas utiliser le cache
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit
compinit

########
# ENVS #
########
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
export LESSOPEN='|lesspipe %s'

########
# PATH #
########
export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/.bin:$PATH"

