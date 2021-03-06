# pecoとghqでローカルのリポジトリクローンに飛ぶ
function peco-src () {
  local selected_dir=$(ghq list --full-path | peco --prompt "PROJECT>" --query "$LBUFFER")
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
    peco --prompt "HISTORY>" --query "$LBUFFER")
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

# vv で git 管理下のファイルを vim で開く。更新順に並び替えしてある
function peco-git-ls-files() {
  git ls-files | egrep "\.(rb|slim|haml|erb|sass|scss|coffee|js|tsx?|pm|pl|t)$"  | xargs ls -At | peco --prompt "FILES>"
}
alias vv='vim -p $(peco-git-ls-files)'

# genymotion_peco
function genymotion_peco() {
  local player="/Applications/Genymotion.app/Contents/MacOS/player.app/Contents/MacOS/player"
  # local つけるとエラー
  # "Google Nexus 5 - 4.4.4 - API 19 - 1080x1920"
  # genymotion_peco:local:2: not an identifier: 5
  vm_name=`VBoxManage list vms | peco | gsed "s/\"\(.*\)\".*/\1/"`
  if [ -n "$vm_name" ]; then
    echo "boot $vm_name"
    $player --vm-name "$vm_name" &
    disown "%`jobs | ruby -e "STDIN.each {|line| m = /\A\[(\d+)\]/.match(line); puts m[1] }"`"
  fi
  unset vm_name
}

# http://blog.livedoor.jp/sonots/archives/45320578.html
function ec2-ssh() {
  hosts="$(EC2_HOST_CONFIG_FILE=~/.aws/ec2_host_config ec2-host -j $*)"
  head=$(echo $hosts | head -1)
  if [ "$hosts" = "$head" ]; then
    ssh $(echo "$head" | jq -r .private_ip_address)
  else
    host=$(echo "$hosts" | peco)
    ssh $(echo $host | jq -r .private_ip_address)
  fi
}
