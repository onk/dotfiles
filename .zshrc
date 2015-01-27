alias g="git"
alias s="git status -sb -uno"
function v() {vi ${${=*/:/ +}/:*}}

# gopath
if [ -z "${GOPATH:-}" ]; then
  export GOPATH=$HOME/go
  PATH=$PATH:$GOPATH/bin
fi
