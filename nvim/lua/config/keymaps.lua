local mapKey = require("utils.keyMapper").mapKey

-- -- pane navigation
-- mapKey("n", "<C-h>", "<C-w>h")
-- mapKey("n", "<C-j>", "<C-w>j")
-- mapKey("n", "<C-k>", "<C-w>k")
-- mapKey("n", "<C-l>", "<C-w>l")

-- Visual Mode

-- indent
mapKey("x", "<", "<gv")
mapKey("x", ">", ">gv")
-- move selected lines
mapKey("x", "J", ":move '>+1<CR>gv=gv")
mapKey("x", "K", ":move '<-2<CR>gv=gv")

mapKey({ "n", "x" }, "<leader>d", [["_d]], {
	desc = "Delete without overwriting register",
})

mapKey("n", "J", "mzJ`z", {
	desc = "Join lines without moving cursor",
})

-- Keep the cursor centered while scrolling.
vim.keymap.set("n", "<C-d>", "<C-d>zz", {
	desc = "Scroll down and center cursor",
})

vim.keymap.set("n", "<C-u>", "<C-u>zz", {
	desc = "Scroll up and center cursor",
})

-- Keep search results visible and centered.
vim.keymap.set("n", "n", "nzzzv", {
	desc = "Next search result and center cursor",
})

vim.keymap.set("n", "N", "Nzzzv", {
	desc = "Previous search result and center cursor",
})

mapKey(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word under cursor in current buffer" }
)

-- lua/config/keymaps.lua
mapKey("n", "<leader>fc", function()
	require("telescope.builtin").find_files({
		cwd = vim.fn.stdpath("config"),
	})
end, {
	desc = "Find Neovim config",
})

-- TODO:
-- If undo history becomes difficult to manage during large refactoring,
-- consider enabling the native undo tree.
--
-- mapKey("n", "<leader>u", function()
--     vim.cmd.packadd("nvim.undotree")
--     require("undotree").open()
-- end, { desc = "Toggle Native Undo Tree" })
