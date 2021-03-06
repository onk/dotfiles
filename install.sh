#!/bin/sh
DOTFILES_DIR=$HOME/dotfiles
ln -sf $DOTFILES_DIR/.zshrc $HOME/.zshrc
ln -sfn $DOTFILES_DIR/.zsh $HOME/.zsh
ln -sf $DOTFILES_DIR/.gitconfig $HOME/.gitconfig
ln -sf $DOTFILES_DIR/.gitignore_global $HOME/.gitignore_global
ln -sf $DOTFILES_DIR/.tigrc $HOME/.tigrc
ln -sfn $DOTFILES_DIR/.byobu $HOME/.byobu
ln -sf $DOTFILES_DIR/.vimrc $HOME/.vimrc
mkdir -p $HOME/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim
ln -sf $DOTFILES_DIR/.gemrc $HOME/.gemrc
ln -sf $DOTFILES_DIR/.pryrc $HOME/.pryrc
ln -sfn $DOTFILES_DIR/.git_hooks $HOME/.git_hooks
ln -sfn $DOTFILES_DIR/.peco $HOME/.peco
ln -sfn $DOTFILES_DIR/.abcde.conf $HOME/.abcde.conf
