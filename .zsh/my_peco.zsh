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

# C-r を peco で行う
function peco-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(\history -n -100000 | \
    eval $tac | \
    awk '!a[$0]++' | \
    peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# B でブランチ選択
function peco-git-branch() {
  git branch -a | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"
}
alias -g B='$(peco-git-branch)'

# F で git status からファイル選択
function peco-git-changed-files() {
  git status -s | peco --prompt "multi: C-Space>" | awk '{print $2}'
}
alias -g F='$(peco-git-changed-files)'
