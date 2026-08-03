# ==================================================
# Java
# ==================================================

if command -v java >/dev/null 2>&1; then
	JAVA_BIN="$(readlink -f "$(command -v java)")"

	export JAVA_HOME="${JAA_BIN%/bin/java}"
	export PATH="$JAVA_HOME/bin:$PATH"
fi


# ==================================================
# Ubuntu Aliases
# ==================================================

# alias update="sudo apt update && sudo apt upgrade"
