eval "$(/opt/homebrew/bin/brew shellenv)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dotan/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dotan/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dotan/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dotan/google-cloud-sdk/completion.zsh.inc'; fi


