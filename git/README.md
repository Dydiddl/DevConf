# OS 에서 처음 깃을 사용할 경우 SSH 키 만들기

ssh-keygen -t ed25519 -C "dydiddl@naver.com"

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519.pub

## GitHub에 공개키를 등록한 뒤

ssh -T git@github.com

cd ~/DevConf
git remote set-url origin git@github.com:Dydiddl/DevConf.git
git add .
git commit -m "edit message"
git push
