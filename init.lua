require("config.globals")
require("config.options")
require("config.keymaps")

-- lazy.nvim을 초기화하고 플러그인을 불러온다.
require("config.lazy")

-- 플러그인이 로드된 뒤 현재 색상 테마를 설정한다.
require("config.colorscheme")