# ==================================================
# Common Settings
# ==================================================

source "$ZDOTDIR/common.zsh"



# ==================================================
# Os Specific Settings
# ==================================================

case "$OSTYPE" in
	linux-gun*)
		source "$ZDOTDIR/ubuntu.zsh"
		;;
	darwin*)
		source "$ZDOTDIR/macos.zsh"
		;;
esac

source "$ZDOTDIR/prompt.zsh"

source "$ZDOTDIR/plugins.zsh"
