eval "$(/opt/homebrew/bin/brew shellenv)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dotan/google-cloud-sdk/path.bash.inc' ]; then . '/Users/dotan/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.

if [ -f '/Users/dotan/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/dotan/google-cloud-sdk/completion.bash.inc'; fi

# bash completions
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

[[ -r "${HOME}/.bashrc" ]] && . "${HOME}/.bashrc"
