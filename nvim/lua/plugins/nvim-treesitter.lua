local languages = {
    -- Neovim
    "lua",
    "vim",
    "vimdoc",
    "query",
    "regex",

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

    -- Optional but useful
    "diff",
    "properties",
}

local indent_languages = {
    lua = true,
    c = true,
    java = true,
    python = true,
    json = true,
    yaml = true,
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

                local ok = pcall(
                    vim.treesitter.start,
                    args.buf,
                    language
                )

                if not ok then
                    return
                end

                -- Treesitter indentation is experimental.
                -- Enable it only for languages verified to work well.
                if indent_languages[language] then
                    vim.bo[args.buf].indentexpr =
                        "v:lua.require'nvim-treesitter'.indentexpr()"
                end

                -- Fold settings can be enabled later when needed.
                -- vim.wo.foldmethod = "expr"
                -- vim.wo.foldexpr =
                --     "v:lua.vim.treesitter.foldexpr()"
                -- vim.opt.foldlevelstart = 99
            end,
        })
    end,
}
