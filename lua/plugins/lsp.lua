return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },

    {
        "mason-org/mason-lspconfig.nvim",

        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },

        opts = {
            ensure_installed = {
                "lua_ls",
                "jdtls",
                "basedpyright",
                "jsonls",
                "marksman",
                "yamlls",
                "bashls",
                "powershell_es",
            },

            automatic_enable = true,
        },
    },
}
