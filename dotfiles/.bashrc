export LC_ALL=en_US.UTF-8
export EDITOR=nvim
# History
HISTSIZE=10000
HISTFILESIZE=10000
# append to history file instead of overwriting
shopt -s histappend
# A new shell gets the history lines from all previous shells
PROMPT_COMMAND='history -a'
# Don't put duplicate lines in the history.
export HISTCONTROL=ignoredups

mail_warn() { echo ''; }

if [[ -n `hostname | grep platelet` ]]
 then
  mail_warn() {
    mail=$(test -d .git && git config user.email)
    mail=${mail/dotan.dimet@cytoreason.com}
    if [[ -n "${mail}" ]]
    then
        echo " ${mail}"
    else
        echo ""
    fi
  };
fi

kube_config=""
get_kube_config() {
  kube_config=$(rg -i current-context ~/.kube/config | awk '{ print $NF }')
  if [[ -n "${kube_config}" ]]
  then
    echo "${kube_config} "
  else
    echo ""
  fi
}

function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) ]] && echo "*"
}

function parse_git_branch {
    branch=$(test -d .git && git branch --show-current)
    if [[ -n "${branch}" ]]
    then
        echo " ${branch}"
    else
        echo ""
    fi
}

export PS1="\[\033[38;5;221m\]\u\[\033[00m\]@\[\033[36m\]\h \[\033[35m\]\$(get_kube_config)\[\033[00m\]\w\[\033[32m\]\$(parse_git_branch)\[\033[33m\]\[\033[00m\]\[\033[38;5;196m\]\$(mail_warn)\[\033[00m\]>"

if [[ ! -z $(which vivid) ]]
then
    export LS_COLORS="$(vivid generate molokai)"
fi
# this silliness is useless unless we enable the --color option for ls:
alias ls="ls --color"

. /opt/homebrew/opt/asdf/libexec/asdf.sh

alias kc="kubectl config get-contexts"
alias kctx='kube_config=$(kubectl config get-contexts -o=name | fzf ) && kubectl config use-context $kube_config'

# poetry uses this:
export PATH="${HOME}/.local/bin:$PATH"

if [[ -d "${HOME}/google-cloud-sdk" ]]
then
  export USE_GKE_GCLOUD_AUTH_PLUGIN=True
fi

# bash completion for git on mac:
source $(xcode-select -p)/usr/share/git-core/git-completion.bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
