autoload -Uz compinit
autoload -Uz promptinit
autoload -Uz colors
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz is-at-least
autoload -Uz history-search-end
compinit
promptinit
colors

# 色設定
eval `dircolors ~/.colorrc`

# ディレクトリ名だけで cd
setopt auto_cd
# プロンプト中の変数を展開する
setopt prompt_subst
# 実行後に右プロンプトを削除する
setopt transient_rprompt
# 移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧
setopt auto_pushd
setopt pushd_ignore_dups
# コマンド履歴
HISTFILE=$HOME/.zsh-history
HISTSIZE=1000000
SAVEHIST=1000000
setopt extended_history
function history-all { history -E 1 }

# 実行時間を報告する
REPORTTIME=3
# C-w で削除する時に /_ を区切り文字とするように
WORDCHARS='*?-.[]~=&;!#$%^(){}<>'

# 他の画面とコマンド履歴を共有
setopt share_history

# 補完
setopt list_packed      # 補完候補をつめて表示する
setopt auto_menu        # TAB で順に補完候補を切り替える
setopt auto_list        # 複数の補完候補があったときに、そのリストを自動的に表示
setopt complete_in_word # 補完開始時にカーソルは単語の終端になくても良い。
setopt list_types       # 種類を示すマーク表示をつける(ls -fと同じもの)
setopt auto_param_keys  # カッコの対応などを自動的に補完
setopt auto_param_slash # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt no_complete_aliases # 補完の解釈前にエイリアスを展開する

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

# @see http://d.hatena.ne.jp/mollifier/20100906/p1
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:svn:*' branchformat '%b:r%r'
if is-at-least 4.3.10; then
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
  zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
  zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
  zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'
fi
function _update_vcs_info_msg() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
RPROMPT="%1(v|%F{green}%1v%f|)"

# @see http://subtech.g.hatena.ne.jp/secondlife/20110222/1298354852
if is-at-least 4.3.10; then
  bindkey '^R' history-incremental-pattern-search-backward
  bindkey '^S' history-incremental-pattern-search-forward
fi

# ^b, ^f は1文字ではなく1単語ずつ移動
bindkey '^b' backward-word
bindkey '^f' forward-word

# cd したら ls
function chpwd() {
  ls -v -F -l --color=auto
}
# bandle + cd
function cdb() {
  cd `ruby -e "require 'rubygems';gem 'bundler';require 'bundler';Bundler.load.specs.each{|s| puts s.full_gem_path if s.name == '${1}'}"`
}

export GREP_OPTIONS='--color=auto --exclude-dir=".svn"'
export PATH=./bin:$PATH

export CDPATH=$HOME

alias ll='ls -alpv --color'
alias cp="cp -i"
alias mv="mv -i"
alias vi="vi -p"
alias :q='exit'
alias -g V='| vim -R -'
alias -g T='| tail'
alias -g H='| head'
alias -g RD='RAILS_ENV=development'
alias -g RT='RAILS_ENV=test'
alias -g RP='RAILS_ENV=production'
alias r="rails"
alias g="git"
alias sup="svn up --ignore-externals"
alias sst="svn st --ignore-externals"
alias sdie="svn diff --depth empty"
alias sres="svn resolve --accept working"
function v() {vi ${${=*/:/ +}/:*}}

prompt fire

# RVM
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

