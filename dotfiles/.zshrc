#zmodload zsh/zprof

export LC_ALL=en_US.UTF-8
export EDITOR=nvim
# History
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY_TIME

if [[ ! -d $HOME/.zsh/site_functions ]] then
    mkdir -p $HOME/.zsh/site_functions
fi
fpath=( $HOME/.zsh/site_functions /opt/homebrew/share/zsh/site-functions "${fpath[@]}" )
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

. /opt/homebrew/opt/asdf/libexec/asdf.sh

autoload -Uz compinit && compinit

#zprof
