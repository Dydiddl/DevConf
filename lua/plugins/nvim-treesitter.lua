local languages = {
    "lua",
    "java",
    "python",
    "json",
    "markdown",
    "markdown_inline",
    "yaml",
    "bash",
}

return {
    {
        "nvim-treesitter/nvim-treesitter",

        branch = "main",
        lazy = false,
        build = ":TSUpdate",

        config = function()
            local treesitter = require("nvim-treesitter")

            -- 기본 설치 경로를 사용한다.
            treesitter.setup()

            vim.treesitter.language.register("json", "jsonc")

            -- 필요한 parser와 query를 설치한다.
            treesitter.install(languages)

            -- 해당 파일 형식을 열었을 때 Treesitter 강조를 시작한다.
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "lua",
                    "java",
                    "python",
                    "json",
                    "jsonc",
                    "markdown",
                    "yaml",
                    "bash",
                    "sh",
                    "sql",
                },

                callback = function(args)
                    local filetype = vim.bo[args.buf].filetype
                    local language = vim.treesitter.language.get_lang(filetype)

                    if language then
                        pcall(vim.treesitter.start, args.buf, language)
                    end
                end,
            })
        end,
    },
}
