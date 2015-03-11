DOTFILES_DIR=$HOME/dotfiles
ln -sf $DOTFILES_DIR/.zshrc $HOME/.zshrc
ln -sfn $DOTFILES_DIR/.zsh $HOME/.zsh
mkdir -p $HOME/.zsh/plugins/bd
curl https://raw.githubusercontent.com/Tarrasch/zsh-bd/master/bd.zsh > $HOME/.zsh/plugins/bd/bd.zsh
ln -sf $DOTFILES_DIR/.gitconfig $HOME/.gitconfig
ln -sf $DOTFILES_DIR/.gitignore_global $HOME/.gitignore_global
ln -sf $DOTFILES_DIR/.tigrc $HOME/.tigrc
ln -sfn $DOTFILES_DIR/.byobu $HOME/.byobu
ln -sf $DOTFILES_DIR/.vimrc $HOME/.vimrc
ln -sf $DOTFILES_DIR/.gemrc $HOME/.gemrc
ln -sf $DOTFILES_DIR/.railsrc $HOME/.railsrc
