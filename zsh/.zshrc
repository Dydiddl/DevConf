# ==================================================
# Common Settings
# ==================================================

source "$HOME/DevConf/zsh/common.zsh"



# ==================================================
# Os Specific Settings
# ==================================================

case "$(uname -s)" in
	Darwin)
		source "$HOME/DevConf/zsh/macos.zsh"
		;;
	Linux)
		source "$HOME/DevConf/zsh/ubuntu.zsh"
		;;
esac
