# Mac 포맷 후 작업

0. 개발 tool 설치

1. Git 설치

2. Homebrew 설치

3. Git SSH key 생성

- ssh-keygen -t ed25519 -C “dydiddl@naver.com”

- eval "$(ssh-agent -s)"

- ssh-add ~/.ssh/id_ed25519

- cat ~/.ssh/id_ed25519.pub

4. 확인

ssh -T git@github.com

5. 설정파일 클론

git clone git@github.com:Dydiddl/DevConf.git

6. .gitconfig -> 심볼릭 링크 만들기

ln -s ~/DevConf/git/.gitconfig ~/.gitconfig

정상 적용 됬는지 확인

git config —global —lsit

# git 설정 완료

# 터미널 설치

지금은 Ghostty 설치 해볼예정
