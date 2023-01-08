prompt bigfade "%(?.red.magenta)"
if [ -n "$AWS_PROFILE" ]; then
  prompt bigfade cyan
fi

# vcs_info
# http://yoshiko.hatenablog.jp/entry/2014/04/02/zsh%E3%81%AE%E3%83%97%E3%83%AD%E3%83%B3%E3%83%97%E3%83%88%E3%81%ABgit%E3%81%AE%E3%82%B9%E3%83%86%E3%83%BC%E3%82%BF%E3%82%B9%E3%82%92%E3%82%B7%E3%83%B3%E3%83%97%E3%83%AB%E5%8F%AF%E6%84%9B%E3%81%8F
# http://blog.uu59.org/2013-06-01-zsh-optimize.html
# http://mollifier.hatenablog.com/entry/20100906/p1
#   カレントディレクトリ
#   gitのリポジトリ名と現在のブランチ
#   変更あり、追加済み（staged）= 黄色
#   変更あり、未追加（unstaged）= 赤
#   変更なし、未追跡ファイルあり（untracked）= 水色
#   変更なし、未追跡ファイルなし（clean）= 緑
setopt PROMPT_SUBST
setopt TRANSIENT_RPROMPT
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '

aws_profile_string() {
  if [ -n "$AWS_PROFILE" ]; then
    echo "%F{1}($AWS_PROFILE)%f"
  fi
}

cruby_version_string() {
  echo "%F{3}($(chruby | grep '\*' | tr -d '* '))%f"
}

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}
RPROMPT=$'$(aws_profile_string) $(cruby_version_string) $(vcs_info_wrapper)'
