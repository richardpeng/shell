# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#zmodload zsh/zprof

export TERM="xterm-256color"

# ohmyzsh configuration

# Speeds up load time
DISABLE_UPDATE_PROMPT=true

# On slow systems, checking the cached .zcompdump file to see if it must be 
# regenerated adds a noticable delay to zsh startup.  This little hack restricts 
# it to once a day.  It should be pasted into your own completion file.
#
# The globbing is a little complicated here:
# - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
# - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
# - '.' matches "regular files"
# - 'mh+24' matches files (or directories or whatever) that are older than 24 hours.
autoload -Uz compinit

() {
  if [[ $# -gt 0 ]]; then
    compinit
  else
    compinit -C
  fi
} ${ZDOTDIR:-$HOME}/.zcompdump(N.mh+24)

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_IGNORE_ALL_DUPS="true"

# User configuration

# Load Antigen
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
source ~/.zsh_plugins.zsh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias gitsum='git log --pretty=format:"* %s" --author `git config user.email`'
alias timestamp="date +%s"
alias cat="bat"
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias help='tldr'
alias ping='prettyping --nolegend'
alias tmlog="log stream --style syslog --predicate 'senderImagePath contains[cd] \"TimeMachine\"' --info"

export GOPATH=$HOME
. $(brew --prefix asdf)/libexec/asdf.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(navi widget zsh)"

source ~/.zsh_plugins.post_compinit.zsh
#zprof
