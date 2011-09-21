#export LC_ALL=ja_JP.UTF-8

# ------------------------------
# 補完周り
# -----------------------------/
# 補完設定
autoload -Uz compinit
compinit
source ~/.zsh/plugin/cdd
#source ~/.zsh/plugin/incr*.zsh

# ディレクトリ名だけで cd
setopt auto_cd

# 色の指定を%{$fg[red]%}みたいに人に優しい指定の仕方が出来るようになる
autoload -Uz colors
colors

export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# プロンプトに $HOST 等が使えるようになる(?)
setopt prompt_subst

# 実行後はコピペしやすいように右プロンプトを削除する
setopt transient_rprompt

# # # git branch を表示
# autoload -Uz vcs_info
# zstyle ':vcs_info:*' enable git svn hg bzr
# zstyle ':vcs_info:*' formats '(%s)-[%b]'
# zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
# zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
# zstyle ':vcs_info:bzr:*' use-simple true
#
# autoload -Uz is-at-least
# if is-at-least 4.3.10; then
#   # この check-for-changes が今回の設定するところ
#   zstyle ':vcs_info:git:*' check-for-changes true
#   zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
#   zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
#   zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
#   zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'
# fi
#
# function _update_vcs_info_msg() {
#   psvar=()
#   LANG=en_US.UTF-8 vcs_info
#   [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
# }
#
# autoload -Uz add-zsh-hook
# add-zsh-hook precmd _update_vcs_info_msg
#
# プロンプト。右側にカレントディレクトリを表示している。
PROMPT="%{${fg[red]}%}%n\$%{${reset_color}%} "
PROMPT2="%{${fg[red]}%}%_\$%{${reset_color}%} "
SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
RPROMPT="[%~] %1(v|%F{green}%1v%f|)"

# 移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧
setopt auto_pushd
setopt pushd_ignore_dups

# コマンド履歴。
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
function history-all { history -E 1 }

# 他の画面とコマンド履歴を共有
setopt share_history

# 補完候補を詰めて表示する
setopt list_packed

# 補完候補にエイリアスを含める
setopt complete_aliases

# コマンドにsudoを付けてもきちんと補完出来るようにする
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                                           /usr/sbin /usr/bin /sbin /bin
# 大文字/小文字を区別しないで補完出来るようにするが、大文字を入力した場合は区別する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完候補を矢印キーなどで選択出来るようにする
zstyle ':completion:*:default' menu select

# 補完候補も LS_COLORS に従って色づけ
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# 補完候補を hjkl で選択可能に
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# 入力履歴から補完。Ctrl+P, Ctrl+N
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# glob (*) での履歴のインクリメンタル検索
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

# ------------------------------
# funcion
# ------------------------------
# cd したら ls
#function cd() {builtin cd $@ && ls -v -F --color=auto}
function chpwd() {
  ls -Fl --color
  _reg_pwd_screennum
}

export LANG=ja_JP.UTF-8
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case'
export GREP_OPTIONS='--color=auto --exclude-dir=".svn"'

PATH=$PATH:/opt/local/bin:/usr/local/bin:/var/lib/gems/1.8/bin
PATH=./bin:$PATH
export PATH

alias ll='ls -alpv --color'
alias cp="cp -i"
alias mv="mv -i"
alias rm="trash-put"
alias less="/usr/share/vim/vim72/macros/less.sh"

alias vi="vi -p"
alias :q='exit'

alias -g V='| vim -R -'

alias r="rails"
# export JAVA_HOME=/usr/lib/jvm/java-6-sun
# export JAVA_HOME=/usr/lib/jvm/java-6-openjdk

bindkey '[3~' delete-char
bindkey '[1~' beginning-of-line
bindkey '[4~' end-of-line
bindkey '' backward-delete-char

# screen のタイトル
preexec () {
  [ ${STY} ] && echo -ne "\ek${1%% *}\e\\"
}

# ssh-agentの設定
agent="$HOME/.ssh/ssh-agent"
if [ -S "$SSH_AUTH_SOCK" ]; then
  case $SSH_AUTH_SOCK in
    /tmp/*/agent.[0-9]*)
    ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
  esac
elif [ -S $agent ]; then
  export SSH_AUTH_SOCK=$agent
else
  echo "no ssh-agent"
fi

# bandle + cd
function cdb() {
  cd `ruby -e "require 'rubygems';gem 'bundler';require 'bundler';Bundler.load.specs.each{|s| puts s.full_gem_path if s.name == '${1}'}"`
}

# RVM
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# 実行時間を報告する
REPORTTIME=3
# C-w で削除する時に / を区切り文字とする
WORDCHARS=${WORDCHARS:s,/,,}

