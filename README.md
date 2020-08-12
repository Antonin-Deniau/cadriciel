Cadriciel
=========

Dotenv environment with an installer.

INSTALLATION
------------

```bash
git clone https://github.com/Antonin-Deniau/cadriciel.git ~/cadriciel && zsh ~/cadriciel/init.zsh
```

ARCHITECTURE
------------

- ~/tools                           # Contain manually installed tools
- ~/.bin                            # Contain symbolic links to manually installed tools
- ~/cadriciel                       # You are in this folder
- ~/cadriciel/init.zsh              # The init file, used for installation
- ~/cadriciel/cadriciel.zsh         # The main file, linked to your .zshrc file
- ~/cadriciel/plugins               # Contain locals plugins
- ~/cadriciel/conf/mountpoints.conf # Contain SSH mountpoints for the mount plugin
- ~/cadriciel/conf/editorconfig     # The editorconfig file

USEFULL TOOLS TO ADD
--------------------

- jq     # Parse and query json from the cli
- ag/rg  # Fast find/grep from the cli
- up     # Interactive pipe
- pyenv  # Manage python versions
- nvm    # Manage node versions

