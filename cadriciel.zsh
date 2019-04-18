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

############
# BIN PATH #
############

export PATH="$HOME/.bin:$PATH"

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
