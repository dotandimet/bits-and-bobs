export LC_ALL=en_US.UTF-8
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
#RPROMPT=\$vcs_info_msg_0_
PROMPT=$PROMPT\$vcs_info_msg_0_'%# '
zstyle ':vcs_info:git:*' formats '%b'

. /opt/homebrew/opt/asdf/libexec/asdf.sh
