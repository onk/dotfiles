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

export CDPATH=$HOME

# prompt
if [ -f ~/.zsh/my_prompt.zsh ]; then
  source ~/.zsh/my_prompt.zsh
fi

# C-S, C-Q によるフロー制御を使わない
setopt NO_FLOW_CONTROL

alias g="git"
alias s="git status -sb"
alias r="bundle exec rails"
alias sb="SOCKS_PROXY=localhost:1080 bundle-socks"
alias sr="SOCKS_PROXY=localhost:1080 bundle-socks exec rails"
alias bi="bundle install --path ~/.bundle --binstubs=~/.bundle/bin --without= --jobs=4"
alias sbi="SOCKS_PROXY=localhost:1080 bundle-socks install --path ~/.bundle --binstubs=~/.bundle/bin --without= --jobs=4"
function v() {vi ${${=*/:/ +}/:*}}

# chruby
source /usr/local/share/chruby/chruby.sh
chruby 2.3.0-dev

# gopath
if [ -z "${GOPATH:-}" ]; then
  export GOPATH=$HOME/go
  PATH=$PATH:$GOPATH/bin
fi

# peco
if [ -f ~/.zsh/my_peco.zsh ]; then
  source ~/.zsh/my_peco.zsh
fi
