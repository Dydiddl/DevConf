local languages = {
    -- Neovim
    "lua",
    "vim",
    "vimdoc",
    "query",

    -- Programming
    "c",
    "java",
    "python",

    -- Shell
    "bash",
    "powershell",

    -- Database
    "sql",

    -- Documentation
    "markdown",
    "markdown_inline",

    -- Configuration
    "json",
    "yaml",
    "toml",
    "xml",

    -- Git
    "git_config",
    "git_rebase",
    "gitcommit",
    "gitignore",
}
return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",

    config = function()
        local treesitter = require("nvim-treesitter")

        treesitter.install(languages)

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local filetype = vim.bo[args.buf].filetype
                local language = vim.treesitter.language.get_lang(filetype)

                if not language then
                    return
                end

                local ok = pcall(vim.treesitter.start, args.buf, language)

                if not ok then
                    return
                end

                vim.wo.foldmethod = "expr"
                vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

                vim.bo[args.buf].indentexpr =
                    "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
