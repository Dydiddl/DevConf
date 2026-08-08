local opt = vim.opt

-- line
opt.number = true
opt.relativenumber = true

-- cursor spacing
opt.scrolloff = 10
opt.sidescrolloff = 5

-- indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.inccommand = "split"

-- search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- screen
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.wrap = false

-- file handling
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.stdpath("state") .. "/undo"
opt.undofile = true

-- split window position
opt.splitright = true
opt.splitbelow = true

-- system clipboard
opt.clipboard:append("unnamedplus")

-- etc
opt.encoding = "UTF-8"
opt.mouse:append("a")
