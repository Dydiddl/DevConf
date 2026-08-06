# Mac First Configuration

> 새로운 Mac에서 개발환경을 구축하는 순서

---

# 0. macOS 초기 설정

- [ ] macOS 업데이트
- [ ] Apple ID 로그인
- [ ] iCloud 설정
- [ ] 키보드 설정
  - 키 반복속도
  - CapsLock → Control (선택)
- [ ] 트랙패드 설정
- [ ] Finder 설정
  - 숨김파일 보기
  - 경로바 표시
  - 상태바 표시
- [ ] 개발용 폴더 생성

```bash
mkdir ~/DevConf
mkdir ~/Workspace
```

---

# 1. Xcode Command Line Tools

```bash
xcode-select --install
```

확인

```bash
xcode-select -p
clang --version
git --version
```

---

# 2. Homebrew 설치

공식 홈페이지

https://brew.sh

PATH 적용

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

확인

```bash
brew --version
brew doctor
```

---

# 3. Git

확인

```bash
git --version
```

---

# 4. SSH Key 생성

생성

```bash
ssh-keygen -t ed25519 -C "dydiddl@naver.com"
```

Agent 실행

```bash
eval "$(ssh-agent -s)"
```

등록

```bash
ssh-add ~/.ssh/id_ed25519
```

공개키 확인

```bash
cat ~/.ssh/id_ed25519.pub
```

Github 등록

Settings → SSH Keys

확인

```bash
ssh -T git@github.com
```

---

# 5. DevConf Clone

```bash
git clone git@github.com:Dydiddl/DevConf.git
```

---

# 6. Git 설정 심볼릭 링크

```bash
ln -s ~/DevConf/git/.gitconfig ~/.gitconfig
```

확인

```bash
git config --global --list
```

---

# 7. Zsh 설정

심볼릭 링크

```bash
ln -s ~/DevConf/zsh ~/.config/zsh
ln -s ~/.config/zsh/.zshenv ~/.zshenv
```

확인

```bash
echo $ZDOTDIR
```

reload

```bash
exec zsh
```

---

# 8. Ghostty 설치

```bash
brew install --cask ghostty
```

설정

```text
~/Library/Application Support/com.mitchellh.ghostty/config
```

심볼릭 링크

```bash
ln -s ~/DevConf/ghostty/config \
~/Library/Application\ Support/com.mitchellh.ghostty/config
```

---

# 9. WezTerm (선택)

```bash
brew install --cask wezterm
```

설정

```bash
ln -s ~/DevConf/wezterm ~/.config/wezterm
```

---

# 10. Nerd Font

설치

```bash
brew install --cask font-martian-mono-nerd-font
```

또는

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

확인

Ghostty에서 폰트 선택

---

# 11. tmux

```bash
brew install tmux
```

설정

```bash
ln -s ~/DevConf/tmux ~/.config/tmux
```

확인

```bash
tmux
```

---

# 12. Neovim

```bash
brew install neovim
```

설정

```bash
ln -s ~/DevConf/nvim ~/.config/nvim
```

확인

```bash
nvim
```

Lazy 설치 확인

```vim
:Lazy
```

---

# 13. 개발 도구

```bash
brew install \
ripgrep \
fd \
fzf \
tree \
bat \
eza \
zoxide \
lazygit \
git-delta
```

확인

```bash
rg --version
fd --version
fzf --version
```

---

# 14. Java

Temurin 설치

```bash
brew install --cask temurin
```

확인

```bash
java -version
javac -version
```

---

# 15. Maven

```bash
brew install maven
```

확인

```bash
mvn -version
```

---

# 16. Python

```bash
brew install python
```

확인

```bash
python3 --version
pip3 --version
```

---

# 17. Lua

```bash
brew install lua
brew install luarocks
```

확인

```bash
lua -v
luarocks --version
```

---

# 18. Treesitter

```bash
brew install tree-sitter
```

확인

```bash
tree-sitter --version
```

---

# 19. Hererocks

```bash
pip3 install hererocks
```

확인

```bash
hererocks --version
```

---

# 20. GitHub 저장소 Pull

- DevConf
- NGSP_JAVA
- NGSP_Python
- 기타 프로젝트

---

# 21. Neovim Plugin 설치

```vim
:Lazy sync
:Mason
:TSUpdate
:checkhealth
```

---

# 22. 최종 점검

```bash
brew doctor

git --version
ssh -T git@github.com

java -version
mvn -version
python3 --version

tmux
nvim
```

---

# 완료

개발환경 구축 완료.
