-- Experimental (Neovim 0.12+)
-- Enable the new built-in UI.
-- Uncomment after confirming it is stable for your workflow.
-- require("vim._core.ui2").enable({})

require("config.globals")
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- lazy.nvim을 초기화하고 플러그인을 불러온다.
require("config.lazy")

-- 플러그인이 로드된 뒤 현재 색상 테마를 설정한다.
require("config.colorscheme")
