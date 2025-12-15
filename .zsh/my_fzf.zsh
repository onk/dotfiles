# fzfとghqでローカルのリポジトリクローンに飛ぶ
function fzf-src () {
  local selected_dir=$(ghq list | sk --exact --no-mouse --prompt "PROJECT>" --query "$LBUFFER" --preview \
    '[[ -f {}/README.md ]] && bat --style=numbers --color=always {}/README.md || echo "No README found"' --preview-window=right:40%
  )
  if [ -n "$(ghq root)/$selected_dir" ]; then
    BUFFER="cd $(ghq root)/${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-src
bindkey '^s' fzf-src

# C-r を fzf で行う
function fzf-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(\history -n -100000 | \
    eval $tac | \
    awk '!a[$0]++' | \
    sk --exact -t score,index --no-mouse --prompt "HISTORY>" --query "$LBUFFER" | gsed -e 's/\\n/\n/g' | gsed -e 's/\\t/\t/g')
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

# B でブランチ選択
function fzf-git-branch() {
  git branch -a | sk --no-mouse --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"
}
alias -g B='$(fzf-git-branch)'

# F で git status からファイル選択
function fzf-git-changed-files() {
  git status -s | sk --no-mouse --prompt "multi: C-Space>" | awk '{print $2}'
}
alias -g F='$(fzf-git-changed-files)'

# vv で git 管理下のファイルを vim で開く。更新順に並び替えしてある
function fzf-git-ls-files() {
  git ls-files | egrep "\.(rb|slim|haml|erb|sass|scss|coffee|js|tsx?|pm|pl|t)$"  | xargs ls -At | sk --no-mouse --prompt "FILES>"
}
alias vv='vim -p $(fzf-git-ls-files)'

# genymotion_fzf
function genymotion_fzf() {
  local player="/Applications/Genymotion.app/Contents/MacOS/player.app/Contents/MacOS/player"
  # local つけるとエラー
  # "Google Nexus 5 - 4.4.4 - API 19 - 1080x1920"
  # genymotion_fzf:local:2: not an identifier: 5
  vm_name=`VBoxManage list vms | sk --no-mouse | gsed "s/\"\(.*\)\".*/\1/"`
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
    host=$(echo "$hosts" | sk --no-mouse)
    ssh $(echo $host | jq -r .private_ip_address)
  fi
}
