#!/usr/bin/env bash

set -u

commands=(
    git
    curl
    tar
    gzip
    unzip
    cc
    gcc
    g++
    make
    rg
    fdfind
    node
    npm
    tree-sitter
    delta
    python3
    pip3
    lua
    luarocks
    java
    javac
    jlink
    mvn
    jq
    shellcheck
)

printf '%-18s %-10s %s\n' "COMMAND" "STATUS" "PATH"
printf '%-18s %-10s %s\n' "------------------" "----------" "------------------------------"

for cmd in "${commands[@]}"; do
    if path=$(command -v "$cmd" 2>/dev/null); then
        printf '%-18s %-10s %s\n' "$cmd" "OK" "$path"
    else
        printf '%-18s %-10s %s\n' "$cmd" "MISSING" "-"
    fi
done

printf '\nNeovim-specific paths\n'
printf '%s\n' '---------------------'

if [[ -x "$HOME/.local/share/nvim/lazy-rocks/hererocks/bin/lua" ]]; then
    echo "hererocks lua: OK"
else
    echo "hererocks lua: MISSING"
fi

if [[ -x "$HOME/.local/share/nvim/lazy-rocks/hererocks/bin/luarocks" ]]; then
    echo "hererocks luarocks: OK"
else
    echo "hererocks luarocks: MISSING"
fi

if [[ -d "$HOME/.local/share/nvim/mason/bin" ]]; then
    echo "mason bin directory: OK"
else
    echo "mason bin directory: MISSING"
fi

# 실행권한 부여
# chmod +x ~/DevConf/install/check-nvim-dependencies.sh
# 실행
# ~/DevConf/install/check-nvim-dependencies.sh
