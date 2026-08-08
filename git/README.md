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

# commit message rule

- feat — 새로운 기능, 플러그인, 설정 등을 추가했을 때.
- fix — 오류, 잘못된 설정, 예상과 다른 동작을 수정했을 때.
- refactor — 기능 변화 없이 코드나 설정의 구조를 정리·개선했을 때.
- docs — README, 주석, 설명 문서 등 문서만 변경했을 때.
- chore — 기능과 직접 관계없는 관리 작업이나 잡다한 유지보수 작업을 했을 때.
- style — 동작에는 영향 없이 들여쓰기, 공백, 포맷팅 등 형식만 변경했을 때.
- test — 테스트 코드를 추가하거나 수정했을 때.
- perf — 기능은 유지하면서 실행 속도나 자원 사용량 등 성능을 개선했을 때.
- build — 빌드 시스템이나 외부 의존성 관련 설정을 변경했을 때.
- ci — GitHub Actions 같은 CI/CD 설정을 변경했을 때.
- revert — 이전 커밋에서 수행한 변경사항을 되돌렸을 때.
