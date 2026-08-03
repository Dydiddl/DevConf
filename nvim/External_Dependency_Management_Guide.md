# Neovim 외부 의존성 관리 가이드

이 문서는 `DevConf/nvim` 설정을 새 Ubuntu 환경에서 복원할 때 필요한 **외부 실행 프로그램**을 확인하고 관리하기 위한 점검 문서다.

Neovim 설정과 플러그인은 Git으로 복원할 수 있지만, 일부 기능은 Neovim 밖에 설치된 프로그램을 호출한다. 따라서 다음 두 영역을 구분해서 관리한다.

```text
DevConf/nvim
└── Lua 설정, 키맵, 플러그인 목록, lazy-lock.json

Ubuntu 시스템
└── git, compiler, tree-sitter-cli, ripgrep, fd, node, java 등
```

---

## 1. 점검 원칙

각 의존성은 아래 순서로 확인한다.

1. 명령이 PATH에서 발견되는지 확인한다.
2. 버전을 출력해 실제 실행 가능한지 확인한다.
3. Neovim 안에서 해당 플러그인의 health check를 실행한다.
4. 문제가 있으면 설치 또는 PATH를 수정한다.
5. 설치 후 Neovim을 완전히 재시작하여 다시 검사한다.

공통 확인 명령:

```bash
command -v <명령어>
<명령어> --version
```

예시:

```bash
command -v git
git --version
```

- 경로가 출력되면 PATH에서 찾을 수 있다.
- 버전이 출력되면 실행 파일이 정상적으로 동작한다.
- `command not found`가 나오면 설치되지 않았거나 PATH에 없다.

---

# 2. 핵심 의존성

## 2.1 Git

### 역할

- `lazy.nvim` 플러그인 다운로드
- `DevConf` 저장소 pull/push
- Mason과 기타 설치 도구가 Git 저장소를 내려받을 때 사용

### 확인

```bash
command -v git
git --version
```

### 설치

```bash
sudo apt update
sudo apt install -y git
```

### 추가 확인

```bash
git config --list --show-origin
```

`delta`가 아직 설치되지 않았다면 pager 오류를 피하기 위해 다음처럼 확인한다.

```bash
GIT_PAGER=cat git config --list --show-origin
```

---

## 2.2 curl

### 역할

- 설치 스크립트와 릴리스 파일 다운로드
- 일부 플러그인 및 외부 도구 설치 과정에서 사용

### 확인

```bash
command -v curl
curl --version
```

### 설치

```bash
sudo apt install -y curl
```

---

## 2.3 tar / gzip / unzip

### 역할

Mason과 각종 설치 스크립트가 압축 파일을 해제할 때 사용한다.

### 확인

```bash
command -v tar
tar --version

command -v gzip
gzip --version

command -v unzip
unzip -v | head
```

### 설치

```bash
sudo apt install -y tar gzip unzip
```

---

## 2.4 C/C++ 컴파일 환경

### 역할

- Tree-sitter parser 컴파일
- `telescope-fzf-native.nvim` 빌드
- C 확장을 포함한 LuaRocks 패키지 빌드
- 일부 Mason 패키지 빌드

### 확인

```bash
command -v cc
cc --version

command -v gcc
gcc --version

command -v g++
g++ --version

command -v make
make --version
```

### 설치

```bash
sudo apt install -y build-essential
```

`build-essential`은 보통 `gcc`, `g++`, `make` 등 기본 빌드 도구를 함께 설치한다.

---

# 3. 검색 및 탐색 도구

## 3.1 ripgrep (`rg`)

### 역할

- Telescope `live_grep`
- 프로젝트 전체 문자열 검색

### 확인

```bash
command -v rg
rg --version
```

### 설치

```bash
sudo apt install -y ripgrep
```

### 동작 확인

```bash
cd ~/DevConf
rg "lazy.nvim"
```

검색 결과가 출력되면 정상이다.

---

## 3.2 fd

### 역할

- 파일 검색 성능 향상
- Telescope 또는 기타 탐색 플러그인에서 사용 가능

Ubuntu에서는 실행 파일 이름이 `fdfind`인 경우가 있다.

### 확인

```bash
command -v fd
command -v fdfind
fdfind --version
```

### 설치

```bash
sudo apt install -y fd-find
```

### `fd` 명령으로 사용하고 싶을 때

```bash
mkdir -p ~/.local/bin
ln -s "$(command -v fdfind)" ~/.local/bin/fd
```

확인:

```bash
command -v fd
fd --version
```

`~/.local/bin`이 PATH에 포함되어 있어야 한다.

```bash
echo "$PATH" | tr ':' '\n' | grep "$HOME/.local/bin"
```

---

# 4. Tree-sitter 관련 의존성

## 4.1 `nvim-treesitter`

`nvim-treesitter`는 Neovim 플러그인이다. 실제 parser 설치·생성·컴파일에는 외부 도구가 추가로 필요할 수 있다.

```text
nvim-treesitter
├── parser 설치 및 관리
├── tree-sitter-cli 호출 가능
└── C compiler 호출
```

## 4.2 tree-sitter CLI

### 역할

- Tree-sitter grammar로부터 parser 소스 생성
- parser 관련 명령 실행
- 설정에 따라 `nvim-treesitter` 설치 및 갱신 과정에서 필요

### 확인

```bash
command -v tree-sitter
tree-sitter --version
```

### npm을 이용한 설치

먼저 Node.js와 npm이 있어야 한다.

```bash
node --version
npm --version
```

설치:

```bash
npm install -g tree-sitter-cli
```

설치 확인:

```bash
command -v tree-sitter
tree-sitter --version
```

### Neovim 내부 확인

```vim
:checkhealth vim.treesitter
:checkhealth nvim-treesitter
```

파서 갱신:

```vim
:TSUpdate
```

특정 언어만 갱신:

```vim
:TSUpdate lua
```

파서 설치 상태 확인은 사용 중인 `nvim-treesitter` 버전의 명령을 따른다.

---

# 5. Node.js와 npm

## 역할

- `tree-sitter-cli` 설치
- 일부 LSP, formatter, linter 설치
- Mason이 npm 패키지를 설치할 때 사용

## 확인

```bash
command -v node
node --version

command -v npm
npm --version
```

## 설치 방식

Ubuntu 기본 패키지를 사용하는 경우:

```bash
sudo apt install -y nodejs npm
```

Node 버전을 자주 바꿔야 한다면 시스템 패키지와 별개로 Node 버전 관리 도구를 사용할 수 있다. 한 환경에서는 설치 방식을 하나로 통일하는 편이 좋다.

## npm 전역 설치 경로 확인

```bash
npm prefix -g
npm bin -g 2>/dev/null || true
```

`tree-sitter`를 설치했는데 명령을 못 찾으면 다음도 확인한다.

```bash
npm list -g --depth=0
npm config get prefix
```

---

# 6. Git delta

## 역할

`.gitconfig`의 다음 설정에서 사용한다.

```ini
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only
```

`delta`가 없으면 Git 출력 과정에서 다음 오류가 날 수 있다.

```text
error: cannot run delta: No such file or directory
```

## 확인

```bash
command -v delta
delta --version
```

## Git 연동 확인

```bash
git log --oneline -5
git diff
```

오류 없이 delta 화면이 나오면 정상이다.

## 설치 전 임시 우회

```bash
GIT_PAGER=cat git log --oneline -5
```

---

# 7. Python / pip / hererocks

## 7.1 Python 3

### 역할

- Lazy.nvim이 `hererocks` 환경을 준비할 때 사용 가능
- Python 기반 LSP, formatter, linter, DAP 설치 및 실행
- Neovim Python provider가 필요한 플러그인에서 사용

### 확인

```bash
command -v python3
python3 --version
```

### 설치

```bash
sudo apt install -y python3
```

Ubuntu에는 Python 3이 기본으로 설치되어 있어도 `pip3`는 별도일 수 있다.

---

## 7.2 pip3

### 확인

```bash
command -v pip3
pip3 --version
```

### 설치

```bash
sudo apt install -y python3-pip
```

---

## 7.3 hererocks

### 역할

Lazy.nvim이 사용할 **Neovim 전용 Lua 및 LuaRocks 환경**을 만든다.

Python의 프로젝트별 `venv`와 완전히 같지는 않지만, 시스템 Lua 환경과 분리된 Neovim 전용 실행 환경이라는 점은 비슷하다.

Lazy.nvim 설정:

```lua
rocks = {
    enabled = true,
    hererocks = true,
},
```

### Lazy.nvim 관리 경로 확인

```bash
ls -la ~/.local/share/nvim/lazy-rocks
ls -la ~/.local/share/nvim/lazy-rocks/hererocks/bin
```

### 예상 실행 파일

```text
~/.local/share/nvim/lazy-rocks/hererocks/bin/lua
~/.local/share/nvim/lazy-rocks/hererocks/bin/luarocks
```

### 직접 확인

```bash
~/.local/share/nvim/lazy-rocks/hererocks/bin/lua -v
~/.local/share/nvim/lazy-rocks/hererocks/bin/luarocks --version
```

### Neovim 내부 확인

```vim
:checkhealth lazy
```

정상이라면 hererocks의 Lua와 LuaRocks가 발견되어야 한다.

---

# 8. 시스템 Lua / LuaRocks

## 역할

- 시스템 전체 또는 사용자 전체에서 Lua 패키지 설치
- Neovim 외의 Lua 프로그램에서도 사용

## 확인

```bash
command -v lua
lua -v

command -v luarocks
luarocks --version
```

## 설치

```bash
sudo apt install -y lua5.1 luarocks
```

## 설치된 rock 확인

```bash
luarocks list
```

hererocks를 사용하면 시스템 LuaRocks와 Neovim 전용 LuaRocks는 별개의 환경이다.

```text
/usr/bin/luarocks
    → 시스템 LuaRocks

~/.local/share/nvim/lazy-rocks/hererocks/bin/luarocks
    → Neovim 전용 LuaRocks
```

---

# 9. Java 개발 의존성

Java 설정을 사용할 때만 필요하다.

## 9.1 JDK

### 역할

- `jdtls` 실행
- Java 컴파일
- `java-debug-adapter` 사용
- Mason의 일부 Java 패키지 설치 스크립트에서 `jlink` 사용

### 확인

```bash
command -v java
java -version

command -v javac
javac -version

command -v jlink
jlink --version

echo "$JAVA_HOME"
```

세 명령 모두 JDK 설치를 판단하는 중요한 기준이다.

- `java`: Java 프로그램 실행
- `javac`: Java 소스 컴파일
- `jlink`: Java 런타임 이미지 구성

`java`만 있고 `javac` 또는 `jlink`가 없다면 JRE만 설치되었거나 JDK PATH가 올바르지 않을 수 있다.

## 9.2 Maven

### 확인

```bash
command -v mvn
mvn --version
```

### 역할

- Java 프로젝트 빌드
- 의존성 관리
- 테스트 실행

### 설치

```bash
sudo apt install -y maven
```

---

# 10. Mason 점검

Mason은 LSP, DAP, linter, formatter를 설치하지만, 각 패키지가 요구하는 기반 프로그램까지 모두 대신하지는 않는다.

예시:

```text
java-language-server
└── jlink 필요

tree-sitter-cli
└── node/npm 필요

일부 formatter
└── python 또는 node 필요
```

## Neovim 내부 점검

```vim
:Mason
:checkhealth mason
```

## Mason 화면에서 확인할 항목

- `Installed`: 정상 설치된 패키지
- `Failed`: 설치 실패한 패키지
- 실패 메시지의 `command not found`
- 패키지별 실행 파일 유무

## Mason 설치 경로 확인

```bash
find ~/.local/share/nvim/mason/bin -maxdepth 1 -type l -o -type f
```

Mason 실행 파일이 PATH에 직접 없어도 Neovim 내부에서는 Mason 설정을 통해 사용할 수 있다. 터미널에서도 사용하려면 PATH 구성이 별도로 필요할 수 있다.

---

# 11. Clipboard 도구

WSL과 터미널 환경에서는 Neovim의 시스템 clipboard가 별도 도구를 요구할 수 있다.

## Neovim 확인

```vim
:checkhealth vim.provider
```

또는 전체 검사:

```vim
:checkhealth
```

## 현재 clipboard provider 확인

```vim
:lua print(vim.fn.has("clipboard"))
:lua print(vim.inspect(vim.g.clipboard))
```

Windows Terminal + WSL에서는 `win32yank.exe`, `clip.exe`, PowerShell 연동 등 여러 방식이 가능하다. 사용하는 방식 하나를 선택해서 문서화한다.

---

# 12. 선택적 도구

아래 도구는 설정에 따라 필요 여부가 달라진다.

## 12.1 jq

JSON 처리 도구.

```bash
command -v jq
jq --version
```

설치:

```bash
sudo apt install -y jq
```

## 12.2 shellcheck

Shell script linter.

```bash
command -v shellcheck
shellcheck --version
```

설치:

```bash
sudo apt install -y shellcheck
```

## 12.3 shfmt

Shell formatter.

```bash
command -v shfmt
shfmt --version
```

## 12.4 stylua

Lua formatter. Mason으로 설치했다면 Mason 경로에서 관리될 수 있다.

```bash
command -v stylua
stylua --version
```

Neovim 내부에서는 formatter 플러그인 설정과 Mason 설치 상태를 함께 확인한다.

---

# 13. Neovim 내부 종합 점검

## 전체 health check

```vim
:checkhealth
```

## 주요 항목별 검사

```vim
:checkhealth lazy
:checkhealth mason
:checkhealth vim.lsp
:checkhealth vim.treesitter
:checkhealth nvim-treesitter
:checkhealth vim.provider
```

플러그인마다 health 이름이 다를 수 있다. 전체 `:checkhealth` 결과에서 실제 모듈 이름을 확인한다.

## 결과를 문서로 저장

```vim
:checkhealth
:w ~/DevConf/docs/health/checkhealth-ubuntu.md
```

날짜별 저장 예시:

```vim
:w ~/DevConf/docs/health/checkhealth-ubuntu-2026-08-03.md
```

---

# 14. 한 번에 확인하는 점검 스크립트

아래 내용을 `~/DevConf/install/check-nvim-dependencies.sh`로 저장할 수 있다.

```bash
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
```

실행 권한 부여:

```bash
chmod +x ~/DevConf/install/check-nvim-dependencies.sh
```

실행:

```bash
~/DevConf/install/check-nvim-dependencies.sh
```

이 스크립트는 설치 여부만 빠르게 확인한다. 각 도구의 실제 동작과 버전 호환성은 개별 `--version` 명령과 Neovim `:checkhealth`로 다시 확인한다.

---

# 15. 현재 환경 점검표

`DevConf/docs/nvim/external-dependencies.md`에서 아래 체크박스를 환경별로 관리할 수 있다.

## 공통

- [ ] Git
- [ ] curl
- [ ] tar
- [ ] gzip
- [ ] unzip
- [ ] build-essential
- [ ] ripgrep
- [ ] fd/fdfind
- [ ] delta

## Tree-sitter

- [ ] Node.js
- [ ] npm
- [ ] tree-sitter-cli
- [ ] C compiler
- [ ] `:TSUpdate` 성공
- [ ] `:checkhealth vim.treesitter` 정상

## Lua / Lazy.nvim

- [ ] Python 3
- [ ] pip3
- [ ] Lazy.nvim 설치
- [ ] `rocks.enabled = true`
- [ ] `rocks.hererocks = true`
- [ ] hererocks Lua 생성
- [ ] hererocks LuaRocks 생성
- [ ] `:checkhealth lazy` 확인

## Mason

- [ ] Mason 실행
- [ ] 실패 패키지 없음
- [ ] 각 패키지 기반 명령 확인
- [ ] `:checkhealth mason` 확인

## Java

- [ ] JDK
- [ ] `java`
- [ ] `javac`
- [ ] `jlink`
- [ ] Maven
- [ ] jdtls
- [ ] java-debug-adapter
- [ ] checkstyle
- [ ] google-java-format

---

# 16. 장애 발생 시 확인 순서

어떤 플러그인이 고장났을 때 무작정 재설치하지 말고 다음 순서로 확인한다.

```text
1. 오류 메시지에서 실행 파일 이름 확인
2. command -v <실행 파일>
3. <실행 파일> --version
4. 플러그인 health check
5. Lazy 또는 Mason 로그 확인
6. PATH 확인
7. 외부 의존성 설치
8. Neovim 완전 재시작
9. 플러그인 또는 parser 재설치
```

예시 — Tree-sitter 오류:

```text
vim.treesitter.start() 실패
    ↓
tree-sitter --version 확인
    ↓
cc --version 확인
    ↓
:checkhealth vim.treesitter
    ↓
:TSUpdate
```

예시 — Git delta 오류:

```text
error: cannot run delta
    ↓
command -v delta
    ↓
delta --version
    ↓
설치 후 git log 재확인
```

예시 — Mason Java 패키지 실패:

```text
jlink: command not found
    ↓
java -version
javac -version
jlink --version
    ↓
JRE가 아닌 JDK 설치 여부 확인
```

---

# 17. 관리 원칙

1. 설정 파일과 외부 프로그램을 구분한다.
2. 외부 의존성은 `install/` 스크립트와 이 문서에 기록한다.
3. 설치 명령보다 먼저 확인 명령을 기록한다.
4. 운영체제별 차이는 별도 섹션으로 분리한다.
5. Mason이나 Lazy가 설치한 프로그램과 시스템 패키지를 구분한다.
6. `sudo npm install -g`, `sudo pip install`, `sudo luarocks install`을 습관적으로 섞지 않는다.
7. 문제 발생 시 실제로 실행되는 경로를 `command -v`로 확인한다.
8. 버전은 `--version` 결과와 함께 기록한다.
9. 새 PC에서 복원한 뒤 `:checkhealth` 결과를 저장한다.
10. 확인된 변경은 DevConf에 커밋한다.


