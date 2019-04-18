# Check dependencies
if ! [ -x "$(command -v git)" ]; then
    echo 'Error: git is not installed.' >&2
    exit 1
fi

# Download the framework
git clone https://github.com/Antonin-Deniau/cadriciel ~/cadriciel

# init zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# init vimpluged
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# init config files
cp ~/cadriciel/conf/mountpoints.conf.sample ~/cadriciel/conf/mountpoints.conf

ln -s ~/cadriciel/conf/editorconfig ~/.editorconfig

mkdir -p ~/.config/nvim/ 
ln -s ~/cadriciel/conf/nvimrc ~/.config/nvim/init.vim


# Source
echo "source ~/cadriciel/cadriciel.zsh" >> ~/.zshrc

