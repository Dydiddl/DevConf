local autocmd = vim.api.nvim_create_autocmd

-- Highlight copied text
autocmd("TextYankPost", {
    desc = "Highlight when yankig (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})

