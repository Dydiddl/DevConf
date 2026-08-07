# ==================================================
# Oh My Zsh installation (Run Once)
# ==================================================
# oh-my-zsh
# git clone https://github.com/ohmyzsh/ohmyzshgit ~/.local/share/oh-my-zsh

# ==================================================
# Oh My Zsh
# ==================================================

export ZSH="$HOME/.local/share/oh-my-zsh"

ZSH_THEME="robbyrussell"


# ==================================================
# External Plugin Installation (Run Once)
# ==================================================
#
# zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-autosuggestions \
#   "${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-autosuggestions"
#
# zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
#   "${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-syntax-highlighting"
#
# These commands are only needed once on a new machine.

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)


# # Keep completion cache outside the Git-managed config directory
# mkdir -p "$HOME/.cache/zsh"
# ZSH_COMPDUMP="$HOME/.cache/zsh/.zcompdump-${ZSH_VERSION}"

source "$ZSH/oh-my-zsh.sh"

export EDITOR="nvim"
export VISUAL="nvim"


[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"


# ==================================================
# PATH
# ==================================================
typeset -U path PATH
export PATH="$HOME/.local/bin:$PATH"
