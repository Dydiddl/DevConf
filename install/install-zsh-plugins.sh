#!/usr/bin/env bash

set -euo pipefail

XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
PLUGIN_HOME="$XDG_DATA_HOME/zsh/plugins"

readonly XDG_DATA_HOME
readonly PLUGIN_HOME

log_info() {
    printf '[INFO] %s\n' "$1"
}

log_install() {
    printf '[INSTALL] %s\n' "$1"
}

log_skip() {
    printf '[SKIP] %s\n' "$1"
}

log_ok() {
    printf '[OK] %s\n' "$1"
}

log_error() {
    printf '[ERROR] %s\n' "$1" >&2
}

require_command() {
    local command_name="$1"

    if ! command -v "$command_name" >/dev/null 2>&1; then
        log_error "Required command not found: $command_name"
        return 1
    fi
}

install_plugin() {
    local repository="${1:?Repository is required}"
    local name="${2:?Plugin name is required}"
    local target="$PLUGIN_HOME/$name"
    local expected_url="https://github.com/$repository.git"
    local actual_url

    if [[ -d "$target/.git" ]]; then
        actual_url="$(
            git -C "$target" remote get-url origin 2>/dev/null || true
        )"

        if [[ "$actual_url" != "$expected_url" ]]; then
            log_error "$name is linked to an unexpected repository"
            printf '  expected: %s\n' "$expected_url" >&2
            printf '  actual:   %s\n' "${actual_url:-unknown}" >&2
            return 1
        fi

        log_skip "$name already installed"
        return
    fi

    if [[ -e "$target" ]]; then
        log_error "$target exists but is not a Git repository"
        return 1
    fi

    log_install "$name"

    git clone --depth=1 \
        "$expected_url" \
        "$target"

    if [[ ! -d "$target/.git" ]]; then
        log_error "Git repository was not created: $target"
        return 1
    fi

    log_ok "$name installed"
}

verify_file() {
    local file_path="$1"
    local description="$2"

    if [[ ! -r "$file_path" ]]; then
        log_error "Required file not found: $file_path"
        return 1
    fi

    log_ok "$description verified"
}

main() {
    require_command git

    mkdir -p "$PLUGIN_HOME"

    log_info "Plugin directory: $PLUGIN_HOME"

    install_plugin \
        "zsh-users/zsh-autosuggestions" \
        "zsh-autosuggestions"

    install_plugin \
        "zsh-users/zsh-syntax-highlighting" \
        "zsh-syntax-highlighting"

    verify_file \
        "$PLUGIN_HOME/zsh-autosuggestions/zsh-autosuggestions.zsh" \
        "zsh-autosuggestions"

    verify_file \
        "$PLUGIN_HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
        "zsh-syntax-highlighting"

    printf '\n'
    log_ok "Zsh plugin installation complete"
}

main "$@"
