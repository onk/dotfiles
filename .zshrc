autoload -Uz promptinit
autoload -Uz vcs_info
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

# pecoとghqでローカルのリポジトリクローンに飛ぶ
function peco-src () {
  local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^s' peco-src

function peco-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(\history -n 1 | \
    eval $tac | \
    awk '!a[$0]++' | \
    peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history
