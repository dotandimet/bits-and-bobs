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

kube_config=""
get_kube_config() {
  if [ -z "$kube_config" -o -n "$(fc -l -1 | rg 'kubectl config')" ]
  then
    kube_config=$(kubectl config current-context)
  fi
}

autoload -Uz vcs_info
autoload -U colors && colors
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info mail_warn get_kube_config )
setopt prompt_subst
#RPROMPT=\$vcs_info_msg_0_
PS1='%{$fg[blue]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%} %{$fg[magenta]%}${kube_config}%{$reset_color%} ${PWD/#$HOME/~} %{$fg[green]%}${vcs_info_msg_0_}%{$reset_color%} %{$fg[red]%}${mail_warning_msg}%{$reset_color%}>'
zstyle ':vcs_info:git:*' formats '%b'

if [[ ! -z $(whence vivid) ]]
then
    export LS_COLORS="$(vivid generate molokai)"
fi

. /opt/homebrew/opt/asdf/libexec/asdf.sh

autoload -Uz compinit && compinit

#zprof

alias kc="kubectl config get-contexts"
alias kctx='kube_config=$(kubectl config get-contexts -o=name | fzf ) && kubectl config use-context $kube_config'

# poetry uses this:
export PATH="${HOME}/.local/bin:$PATH"

if [[ -d "${HOME}/google-cloud-sdk" ]]
then
  source $HOME/google-cloud-sdk/completion.zsh.inc
  export USE_GKE_GCLOUD_AUTH_PLUGIN=True
fi

if [[ -d ~/.rd/bin/ ]]
then
    export PATH="${PATH}:${HOME}/.rd/bin"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
