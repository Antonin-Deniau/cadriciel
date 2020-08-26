# Check dependencies
if ! [ -x "$(command -v git)" ]; then
    echo 'Error: git is not installed.' >&2
    exit 1
fi
if ! [ -x "$(command -v curl)" ]; then
    echo 'Error: curl is not installed.' >&2
    exit 1
fi

# init zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# Init tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# init vimpluged
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# init config files
cp ~/cadriciel/conf/mountpoints.conf.sample ~/cadriciel/conf/mountpoints.conf

mkdir -p ~/.config/nvim/ 
ln -s ~/cadriciel/conf/nvimrc ~/.config/nvim/init.vim
ln -s ~/cadriciel/conf/tmux.conf ~/.tmux.conf
ln -s ~/cadriciel/conf/editorconfig ~/.editorconfig
ln -s ~/cadriciel/conf/gitconfig ~/.gitconfig

# Source
echo "source ~/cadriciel/cadriciel.zsh" >> ~/.zshrc

