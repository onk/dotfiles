autoload -Uz compinit
autoload -Uz promptinit
autoload -Uz vcs_info
compinit
promptinit

# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=1000000
SAVEHIST=1000000
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt NO_BANG_HIST
function history-all { history -E 1 }

REPORTTIME=3

export CDPATH=$HOME
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

WORDCHARS='*?-.[]~&;!#$%^(){}<>'

# prompt
if [ -f ~/.zsh/my_prompt.zsh ]; then
  source ~/.zsh/my_prompt.zsh
fi

# completion
zstyle ':completion:*:default' menu select
setopt list_packed

# C-S, C-Q によるフロー制御を使わない
setopt NO_FLOW_CONTROL

alias -g RD='RAILS_ENV=development'
alias -g RT='RAILS_ENV=test'
alias -g RP='RAILS_ENV=production'
alias -g CSU='| cut -d":" -f1 | sort | uniq'
alias rm="gomi"
alias g="git"
alias s="git status -sb"
alias r="bundle exec rails"
alias m="bundle exec middleman"
alias :q="exit"
alias sb="SOCKS_PROXY=localhost:1080 bundle-socks"
alias sr="SOCKS_PROXY=localhost:1080 bundle-socks exec rails"
alias bi="bundle install --path ~/.bundle --binstubs=~/.bundle/bin --jobs=4 --without="
alias sbi="SOCKS_PROXY=localhost:1080 bundle-socks install --path ~/.bundle --binstubs=~/.bundle/bin --jobs=4 --without="
alias cod="git checkout develop"
alias com="git checkout master"
alias cow="git checkout working"
alias my="mycli -u root"
function v() {vi -p ${${=*/:/ +}/:*}}

case "${OSTYPE}" in
  darwin*)
    alias ll='ls -lFG'
    alias lsd='ls -lFG | grep -e "^d" --color=never'
    ;;
  linux*)
    alias ll='ls -lvF --color'
    alias lsd='ls -lvF --color | grep -e "^d" --color=never'
    ;;
esac

# cd したら ls
function chpwd() {
  case "${OSTYPE}" in
    darwin*)
      ls -lF -G
      ;;
    linux*)
      ls -lvF --color
      ;;
  esac
}

# chruby
source /usr/local/share/chruby/chruby.sh
chruby 2.3.0-dev

# gopath
if [ -z "${GOPATH:-}" ]; then
  export GOPATH=$HOME/go
  PATH=$PATH:$GOPATH/bin
fi

# android
PATH=$PATH:$HOME/.android/platform-tools

# peco
if [ -f ~/.zsh/my_peco.zsh ]; then
  source ~/.zsh/my_peco.zsh
fi

# zsh-bd
if [ -f ~/.zsh/plugins/bd/bd.zsh ]; then
  source ~/.zsh/plugins/bd/bd.zsh
fi

# http://ukstudio.jp/2015/03/26/open_pull_request/
function find-pr() {
  local parent=$2||'master'
  git log $1..$2 --merges --ancestry-path --reverse --oneline | head -n1
}

function find-pr-open() {
  local pr="$(find-pr $1 $2 | awk '{print substr($5, 2)}')"
  local repo="$(git config --get remote.origin.url | sed 's#ssh://git@#https://#' | sed 's/\.git$//')"
  open "${repo}/pull/${pr}"
}

function find-mr-open() {
  local pr="$(find-pr $1 $2 | awk '{print substr($7, 2)}')"
  local repo="$(git config --get remote.origin.url | sed 's#ssh://git@#http://#' | sed 's/\.git$//')"
  open "${repo}/merge_requests/${pr}"
}

function rm_xattr() {
  for file in $*
  do
    for attr in $(xattr $file)
    do
      xattr -d $attr $file
    done
  done
}
