return {
    {
        "mason-org/mason-lspconfig.nvim",

        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {},
            },

            "neovim/nvim-lspconfig",
        },

        opts = {
            ensure_installed = {
                -- Lua
                "lua_ls",

                -- Java
                "jdtls",

                -- Python
                "basedpyright",

                -- C
                -- "clangd",

                -- Markdown
                "marksman",

                -- Config
                "jsonls",
                "yamlls",

                -- Shell
                "bashls",
                "powershell_es",
            },

            automatic_enable = true,
        },
    },
}
