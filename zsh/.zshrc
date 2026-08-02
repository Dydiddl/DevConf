# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="passion"

plugins=(
    git
    zsh-autosuggestions
)

source "$ZSH/oh-my-zsh.sh"

# Homebrew
export HOMEBREW_NO_INSTALL_CLEANUP=TRUE

# Python
if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# Java
export JAVA_HOME="$(/usr/libexec/java_home -v 21)"
export PATH="$JAVA_HOME/bin:$PATH"

# Syntax highlighting should remain near the end
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
