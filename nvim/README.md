# NeoVim Configuration

This repository contains my Neovim configuration for Windows and macOS.

This document records the setup and workflow so I can follow the same process consistently.

## Configuration Directory

### Window

`cd $env:LOCALAPPDATA\nvim`


### macOS

`cd ~/.config/nvim`



## Basic work order

### Before work

`git pull --ff-only`

`git status`


### After work

`git diff`

`git commit -m "feat: describe configuration change"`

`git push`


### Overall work sequence

1. git pull --ff-only

2. Neovim 설정 수정

3. Neovim 실행 및 테스트

4. git status

5. git diff

6. git add .

7. git commit

8. git push


## Initialization Method

`Remove-Item "$env:LOCALAPPDATA\nvim-data" -Recurse -Force`


# Frequently Used Git Commands

| Command | Purpose |

|--------|------|

| git status | Check current status |

| git diff | Check changes |

| git add . | Staging changes |

| git commit -m "..." | Saving changes |

| git pull --ff-only | Safely fetch the latest remote content |

| git push | Upload to GitHub |

| git log --oneline | View commit history |
