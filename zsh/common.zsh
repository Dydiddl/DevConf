# ==================================================
# Oh My Zsh
# ==================================================

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="dydid"

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


source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# 항상 마지막에 위치 시킬것
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
