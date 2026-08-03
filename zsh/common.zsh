# ==================================================
# Oh My Zsh
# ==================================================

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
)

if [ -f "$ZSH/oh-my-zsh.sh" ]; then
	source "$ZSH/oh-my-zsh.sh"
fi

# ==================================================
# Python
# ==================================================

if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi



# ==================================================
# User Aliases
# ==================================================

# alias ll="ls -alF"
# alias gs="git status"

