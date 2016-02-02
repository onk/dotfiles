#!/bin/sh
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew update
brew upgrade

brew tap homebrew/services

# peco
brew install peco
brew install migemogrep

# opencv
brew tap homebrew/science
brew install opencv

# clang-format
brew tap tcr/tcr
brew install clang-format

brew install coreutils

brew install readline
brew install icu4c
brew install cmake
brew install libgit2

brew install mecab
brew install mecab-ipadic

brew install git
brew install git-now
brew install mercurial

brew install ruby-build
brew install chruby
brew install node
brew install go
brew cask install java
brew install phantomjs

brew install mysql
brew install redis
brew install memcached
brew install nginx

brew install zsh
brew install wget
brew install pstree
brew install tree
brew install watch
brew install nkf
brew install tcpflow
brew install tig --with-docs
brew install byobu
brew install ag
brew install jq
brew install httpie
brew install vim --override-system-vi
brew install libtiff
brew install ghostscript
brew install imagemagick --with-libtiff
brew install apktool
brew install jad
brew install dex2jar
brew install xcproj
brew install ttyrec
brew install ffmpeg --with-fdk-aac --with-theora --with-libvorbis
brew install sox
brew install taglib
brew install graphviz
brew install plantuml
brew install ctags
brew install pidcat
brew install mycli
brew install mitmproxy
brew install git-secrets

brew install Caskroom/cask/google-chrome
brew install Caskroom/cask/filezilla
brew install Caskroom/cask/vagrant
brew install Caskroom/cask/virtualbox
brew install Caskroom/cask/genymotion
brew install Caskroom/cask/skype
brew install Caskroom/cask/cyberduck
brew install Caskroom/cask/libreoffice
brew install Caskroom/cask/sequel-pro
brew install Caskroom/cask/astrill
brew install Caskroom/cask/processing
brew install Caskroom/cask/mysqlworkbench
brew install Caskroom/cask/dockertoolbox
brew install Caskroom/cask/fluid
