# zmodload zsh/zprof

export LC_ALL=en_US.UTF-8

autoload -Uz vcs_info
autoload -U colors && colors
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
#RPROMPT=\$vcs_info_msg_0_
PS1='%{$fg[blue]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%} ${PWD/#$HOME/~} %{$fg[green]%}${vcs_info_msg_0_}%{$reset_color%} > '
zstyle ':vcs_info:git:*' formats '%b'

if [[ ! -z $(whence vivid) ]]
then
    export LS_COLORS="$(vivid generate molokai)"
fi

if [[ ! -z $(whence kubectl) ]]
then
 autoload -Uz compinit
 compinit
 source <(kubectl completion zsh)
fi

. /opt/homebrew/opt/asdf/libexec/asdf.sh

# zprof
