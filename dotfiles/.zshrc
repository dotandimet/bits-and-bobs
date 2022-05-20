#zmodload zsh/zprof

export LC_ALL=en_US.UTF-8
export EDITOR=nvim
bindkey -e  # setting EDITOR messes with keybindings, this should restore them - https://stackoverflow.com/a/43087047/117896
# History
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY_TIME

if [[ ! -d $HOME/.zsh/site_functions ]] then
    mkdir -p $HOME/.zsh/site_functions
fi
fpath=( $HOME/.zsh/site_functions /opt/homebrew/share/zsh/site-functions "${fpath[@]}" )

mail_warning_msg=""
mail_warn() {
    mail_warning_msg=""
    if [ -n `hostname | grep platelet` -a -d .git ]
    then
        mail=$(git config user.email)
        if [[ "${mail}" != 'dotan.dimet@cytoreason.com' ]]
        then
           mail_warning_msg="${mail}"
        fi
    fi
}

autoload -Uz vcs_info
autoload -U colors && colors
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info mail_warn )
setopt prompt_subst
#RPROMPT=\$vcs_info_msg_0_
PS1='%{$fg[blue]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%} ${PWD/#$HOME/~} %{$fg[green]%}${vcs_info_msg_0_}%{$reset_color%} %{$fg[red]%}${mail_warning_msg}%{$reset_color%}> '
zstyle ':vcs_info:git:*' formats '%b'

if [[ ! -z $(whence vivid) ]]
then
    export LS_COLORS="$(vivid generate molokai)"
fi

. /opt/homebrew/opt/asdf/libexec/asdf.sh

autoload -Uz compinit && compinit

#zprof

alias kc="kubectl config get-contexts"
