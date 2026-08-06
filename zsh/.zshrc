# ==================================================
# Oh My Zsh
# ==================================================

export ZSH="$HOME/.local/share/oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
)

# Keep completion cache outside the Git-managed config directory
mkdir -p "$HOME/.cache/zsh"
ZSH_COMPDUMP="$HOME/.cache/zsh/.zcompdump-${ZSH_VERSION}"

source "$ZSH/oh-my-zsh.sh"


# ==================================================
# User Settings
# ==================================================

export EDITOR="nvim"
export VISUAL="nvim"
