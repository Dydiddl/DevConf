# ==================================================
# dydid Prompt
# ==================================================

autoload -Uz add-zsh-hook
autoload -Uz vcs_info


# ==================================================
# Git Information
# ==================================================

zstyle ':vcs_info:*' enable git

# Brackets : ANSI bright black
# Branch   : ANSI blue
zstyle ':vcs_info:git:*' formats '%F{blue}   %b%f'
zstyle ':vcs_info:git:*' actionformats '%F{blue}   %b|%a%f'

# ==================================================
# Prompt Rendering
# ==================================================

_dydid_prompt_precmd() {
    local last_status=$?

    vcs_info

    local symbol_color

    if (( last_status == 0 )); then
        symbol_color="green"
    else
        symbol_color="red"
    fi

    PROMPT=""

    # First line: current path
    PROMPT+="%F{magenta}  %~%f"

    # First line: Git branch
    PROMPT+="${vcs_info_msg_0_}"

    # Second line: input symbol
    PROMPT+=$'\n'
    PROMPT+="%F{${symbol_color}}↝%f "
}


# ==================================================
# Hooks
# ==================================================

add-zsh-hook precmd _dydid_prompt_precmd
