# ==================================================
# dydid Theme
# ==================================================

autoload -Uz colors
colors

autoload -Uz vcs_info

zstyle ':vcs_info:git:*' formats '%F{magenta} %b%f'
zstyle ':vcs_info:git:*' actionformats '%F{magenta} %b|%a%f'

precmd() {
    vcs_info
}

PROMPT='
%F{cyan}%~%f ${vcs_info_msg_0_}
%(?.%F{green}➜%f.%F{red}➜%f) '
