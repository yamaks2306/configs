ulimit -n 12288

#OPTIONS
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

# SET DEFAULT EDITOR
export EDITOR=hx
export TERM=xterm-256color

# ALIASES
alias ls="ls -lah"
alias k="kubectl"
#alias kubecontext="kubectl config get-contexts"
#alias kubeswitchcontext="kubectl config use-context"
alias c="clear"
alias q="exit"
alias python=/usr/bin/python3

unalias gch 2>/dev/null

gch() {
  local branch
  branch=$(git for-each-ref refs/heads/ --format='%(refname:short)' | fzf) || return
  [ -n "$branch" ] || return
  git checkout "${branch}"
}

kubecontext() {
	local context
	context=$(kubectl config get-contexts --no-headers | tr -d '*' | awk '{print $1}' | fzf) || return
	[ -n "$context" ] || return
	kubectl config use-context "${context}"
}


#BINDKEYS
bindkey '^R' history-incremental-search-backward

#AUTOSUGGESTIONS  https://github.com/zsh-users/zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

fpath+=~/.zfunc

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

# YAZI FUNCTIONS
# Yazi shel wrapper - changing working directory when exiting Yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

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

export PATH="/opt/homebrew/bin:$PATH"
