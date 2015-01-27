# C-S, C-Q によるフロー制御を使わない
setopt NO_FLOW_CONTROL

alias g="git"
alias s="git status -sb -uno"
function v() {vi ${${=*/:/ +}/:*}}

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
