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
setopt BANG_HIST
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
function history-all { history -E 1 }

REPORTTIME=3

export CDPATH=.:$HOME
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

bindkey "^F" forward-word
bindkey "^B" backward-word

alias -g RD='RAILS_ENV=development'
alias -g RT='RAILS_ENV=test'
alias -g RP='RAILS_ENV=production'
alias -g CSU='| cut -d":" -f1 | sort | uniq'
alias -g SUS='| sort | uniq -c | sort -nr'
alias -g V=' 2>&1 | vim -'
alias rm="gomi"
alias b="bat --style=plain"
alias c="ctop"
alias g="git"
alias h="hivemind"
alias s="git status -sb"
alias r="bundle exec rails"
alias ru="bundle exec rackup"
alias m="bundle exec middleman"
alias rake="noglob bundle exec rake"
alias rspec="bundle exec rspec"
alias :q="exit"
alias bi="bundle install --path ~/.bundle --binstubs=~/.bundle/bin --jobs=4 --without=production"
alias cod="git checkout develop"
alias com="git checkout master"
alias cow="git checkout working"
alias my="mycli -u root"
alias tree="exa --tree -F"
alias dc="docker-compose"
alias cdr="cd \`git rev-parse --show-toplevel\`"
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

# enter したら git status
# http://qiita.com/yuyuchu3333/items/e9af05670c95e2cc5b4d
function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
      echo
      git status -sb
      echo
    fi
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter

# plenv
if which plenv > /dev/null; then
  eval "$(plenv init - zsh)"
fi

# chruby
source /usr/local/share/chruby/chruby.sh
chruby 3.1.0-dev

# ruby
export DISABLE_SPRING=1
export DISABLE_DATABASE_ENVIRONMENT_CHECK=1

# go
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin
export GO111MODULE=on

# peco
if [ -f ~/.zsh/my_peco.zsh ]; then
  source ~/.zsh/my_peco.zsh
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

# http://blog.kamipo.net/entry/2013/02/20/122225
function www() {
  if type ruby > /dev/null; then
    ruby -run -e httpd -- --port=5000 .
  elif type python > /dev/null; then
    if python -V 2>&1 | grep -qm1 'Python 3\.'; then
      python -m http.server 5000
    else
      python -m SimpleHTTPServer 5000
    fi
  elif type node > /dev/null; then
    node -e "var c=require('connect'), d=process.env.PWD; c().use(c.logger()).use(c.static(d)).use(c.directory(d)).listen(5000);"
  elif type php > /dev/null && php -v | grep -qm1 'PHP 5\.[45]\.'; then
    php -S 0.0.0.0:5000
  fi
}

# local
if [ -f ~/.zsh/local.zsh ]; then
  source ~/.zsh/local.zsh
fi
