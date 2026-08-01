local mapKey = require("utils.keyMapper").mapKey

-- neotree toggle File Explorer
mapKey("n", "<leader>e", ":Neotree toggle<CR>")

-- pane navigation
mapKey("n", "<C-h>", "<C-w>h")
mapKey("n", "<C-j>", "<C-w>j")
mapKey("n", "<C-k>", "<C-w>k")
mapKey("n", "<C-l>", "<C-w>l")



-- Visual Mode

-- indent
mapKey("x", "<", "<gv")
mapKey("x", ">", ">gv")
-- move selected lines
mapKey("x", "J", ":move '>+1<CR>gv=gv")
mapKey("x", "K", ":move '<-2<CR>gv=gv")
