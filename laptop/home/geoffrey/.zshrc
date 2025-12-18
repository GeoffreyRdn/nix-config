# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone git@github.com:zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add zsh plugins
zinit light zsh-users/zsh-autosuggestions.git
zinit light zsh-users/zsh-syntax-highlighting.git
zinit light zsh-users/zsh-completions.git
zinit light Aloxaf/fzf-tab

HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

zstyle ':completion*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:*:*' fzf-preview 'if [ -d "$realpath" ]; then ls --color "$realpath"; else bat -n --color=always --line-range :500 "$realpath"; fi'

export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
alias bathelp='bat --plain --language=help'

help() {
    "$@" --help 2>&1 | bathelp
}

batdiff() {
    git diff --name-only --relative --diff-filter=d "$@" | xargs bat --diff
}

alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias gd="batdiff $@"

autoload -Uz compinit
compinit

export DIRENV_LOG_FORMAT=
eval "$(direnv hook zsh)"
export PGDATA="$HOME/postgres_data"
export PGHOST="/tmp"

export EDITOR=nvim

plugins=(fzf)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

