# ==================================================
# Common Settings
# ==================================================

source "$ZDOTDIR/common.zsh"



# ==================================================
# Os Specific Settings
# ==================================================

case "$OSTYPE" in
	linux-gnu*)
		source "$ZDOTDIR/ubuntu.zsh"
		;;
	darwin*)
		source "$ZDOTDIR/macos.zsh"
		;;
esac

# 직접만든 프롬프트를 사용하려면 주석 해제
# source "$ZDOTDIR/prompt.zsh"




# ==================================================
# Plugins
# ==================================================
source "$ZDOTDIR/plugins.zsh"



# ==================================================
# Oh My Posh
# ==================================================

if command -v oh-my-posh >/dev/null 2>&1; then
    eval "$(oh-my-posh init zsh \
        --config "$HOME/DevConf/oh-my-posh/theme.omp.json")"
fi
