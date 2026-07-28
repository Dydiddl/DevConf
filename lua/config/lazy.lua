-- Bootstrap lazy.nvim
-- lazy.nvim이 설치될 경로
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- lazy.nvim.이 설치되어 있지 않으면 Git으로 자동 설치
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"

  local out = vim.fn.system({ 
	  "git", 
	  "clone", 
	  "--filter=blob:none", 
	  "--branch=stable", 
	  lazyrepo, 
	  lazypath 
  })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})

    vim.fn.getchar()
    os.exit(1)

  end
end


-- Neovim이 lazy.nvim을 찾을 수 있도록 runtime path에 추가
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
-- lua/plugins 폴더의 플러그인 설정을 불러옴
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { 
	  enabled = true,
	  notify = false,
  },
})
