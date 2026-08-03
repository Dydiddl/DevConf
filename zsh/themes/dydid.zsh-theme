# ==================================================
# dydid Theme
# Catppuccin Mocha
# ==================================================

autoload -Uz add-zsh-hook


# ==================================================
# Catppuccin Mocha Palette
# ==================================================

DYDID_ROSEWATER="#f5e0dc"
DYDID_FLAMINGO="#f2cdcd"
DYDID_PINK="#f5c2e7"
DYDID_MAUVE="#cba6f7"

DYDID_RED="#f38ba8"
DYDID_MAROON="#eba0ac"
DYDID_PEACH="#fab387"
DYDID_YELLOW="#f9e2af"

DYDID_GREEN="#a6e3a1"
DYDID_TEAL="#94e2d5"
DYDID_SKY="#89dceb"
DYDID_SAPPHIRE="#74c7ec"
DYDID_BLUE="#89b4fa"
DYDID_LAVENDER="#b4befe"

DYDID_TEXT="#cdd6f4"
DYDID_SUBTEXT1="#bac2de"
DYDID_SUBTEXT0="#a6adc8"

DYDID_OVERLAY2="#9399b2"
DYDID_OVERLAY1="#7f849c"
DYDID_OVERLAY0="#6c7086"


# ==================================================
# Prompt State
# ==================================================

DYDID_LAST_STATUS=0
DYDID_COMMAND_STARTED_AT=0
DYDID_EXECUTION_TIME=""


# ==================================================
# Command Execution Time
# ==================================================

_dydid_preexec() {
    DYDID_COMMAND_STARTED_AT=$EPOCHREALTIME
}

_dydid_update_execution_time() {
    local finished_at=$EPOCHREALTIME
    local elapsed_ms=0

    if [[ -n "$DYDID_COMMAND_STARTED_AT" ]] &&
        (( DYDID_COMMAND_STARTED_AT > 0 )); then

        elapsed_ms=$(
            printf "%.0f" \
                "$(( (finished_at - DYDID_COMMAND_STARTED_AT) * 1000 ))"
        )
    fi

    if (( elapsed_ms < 1000 )); then
        DYDID_EXECUTION_TIME="${elapsed_ms}ms"
    else
        DYDID_EXECUTION_TIME=$(
            printf "%.2fs" "$(( elapsed_ms / 1000.0 ))"
        )
    fi

    DYDID_COMMAND_STARTED_AT=0
}


# ==================================================
# Git Information
# ==================================================

_dydid_git_prompt() {
    command git rev-parse --is-inside-work-tree \
        >/dev/null 2>&1 || return

    local branch
    local upstream_status
    local working_count
    local staging_count
    local ahead
    local behind

    branch=$(
        command git symbolic-ref \
            --quiet \
            --short HEAD 2>/dev/null
    )

    if [[ -z "$branch" ]]; then
        branch=$(
            command git rev-parse \
                --short HEAD 2>/dev/null
        )
    fi

    # feature/name -> name
    # fix/name     -> name
    branch="${branch#feature/}"
    branch="${branch#fix/}"
    branch="${branch#hotfix/}"
    branch="${branch#bugfix/}"

    working_count=$(
        command git status \
            --porcelain 2>/dev/null |
            awk '
                substr($0, 2, 1) != " " {
                    count++
                }
                END {
                    print count + 0
                }
            '
    )

    staging_count=$(
        command git status \
            --porcelain 2>/dev/null |
            awk '
                substr($0, 1, 1) != " " &&
                substr($0, 1, 1) != "?" {
                    count++
                }
                END {
                    print count + 0
                }
            '
    )

    ahead=0
    behind=0

    if command git rev-parse \
        --abbrev-ref \
        --symbolic-full-name '@{upstream}' \
        >/dev/null 2>&1; then

        local counts

        counts=$(
            command git rev-list \
                --left-right \
                --count \
                HEAD...'@{upstream}' 2>/dev/null
        )

        ahead="${counts%%[[:space:]]*}"
        behind="${counts##*[[:space:]]}"
    fi

    print -n "%F{$DYDID_BLUE}%f   "
    print -n "%F{$DYDID_LAVENDER}[ ${branch} ]%f"

    if (( ahead > 0 )); then
        print -n " %F{$DYDID_SKY}↑${ahead}%f"
    fi

    if (( behind > 0 )); then
        print -n " %F{$DYDID_SKY}↓${behind}%f"
    fi

    if (( working_count > 0 )); then
        print -n " %F{$DYDID_RED} ${working_count}%f"
    fi

    if (( staging_count > 0 )); then
        print -n " %F{$DYDID_GREEN} ${staging_count}%f"
    fi
}


# ==================================================
# Prompt Rendering
# ==================================================

_dydid_precmd() {
    DYDID_LAST_STATUS=$?

    _dydid_update_execution_time

    local git_info
    local status_color

    git_info="$(_dydid_git_prompt)"

    if (( DYDID_LAST_STATUS == 0 )); then
        status_color="$DYDID_TEXT"
    else
        status_color="$DYDID_RED"
    fi

    PROMPT=""

    # Line 1: current path
    PROMPT+="%F{$DYDID_MAUVE}%f   "
    PROMPT+="%F{$DYDID_MAUVE}[ %~ ]%f"

    # Line 2: Git and execution time
    if [[ -n "$git_info" ]]; then
        PROMPT+=$'\n'
        PROMPT+="$git_info"
    fi

    if [[ -n "$DYDID_EXECUTION_TIME" ]]; then
        if [[ -z "$git_info" ]]; then
            PROMPT+=$'\n'
        fi

        PROMPT+=" %F{$DYDID_OVERLAY2}"
        PROMPT+="󰔟 ${DYDID_EXECUTION_TIME}"
        PROMPT+="%f"
    fi

    # Line 3: input prompt
    PROMPT+=$'\n'
    PROMPT+="%F{${status_color}}❱❱❱%f "
}


# ==================================================
# Hooks
# ==================================================

add-zsh-hook preexec _dydid_preexec
add-zsh-hook precmd _dydid_precmd
