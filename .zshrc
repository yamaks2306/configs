ulimit -n 12288
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export PATH=/Users/maksyastrebov/Library/Python/3.9/bin:$PATH
export PATH=/Users/maksyastrebov/bin:$PATH
export PATH=/opt/flutter/bin:$PATH
export PATH=/Users/maksyastrebov/Library/Android/sdk/platform-tools:$PATH
export PATH=/Users/maksyastrebov/Library/Android/sdk/cmdline-tools/latest/bin:$PATH
export PATH=/Users/maksyastrebov/Library/Android/sdk/build-tools//32.1.0-rc1:$PATH
export PATH=/Users/maksyastrebov/Library/Android/sdk/emulator/bin64:$PATH
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

alias ls="ls -lah"
alias k="kubectl"
alias kubecontext="kubectl config get-contexts"
alias kubeswitchcontext="kubectl config use-context"
alias c="clear"

bindkey '^R' history-incremental-search-backward

eval "$(starship init zsh)"



# Highlight the current autocomplete option
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Better SSH/Rsync/SCP Autocomplete
zstyle ':completion:*:(scp|rsync):*' tag-order ' hosts:-ipaddr:ip\ address hosts:-host:host files'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# Allow for autocomplete to be case insensitive
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  '+l:|?=** r:|?=**'

# Initialize the autocompletion
autoload -Uz compinit && compinit -i

