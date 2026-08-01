return {
    {
        "RRethy/vim-illuminate",

        config = function()
            require("illuminate").configure({
                providers = {
                    "lsp",
                    "treesitter",
                    "regex",
                },

                delay = 100,

                filetypes_denylist = {
                    "dirbuf",
                    "dirvish",
                    "fugitive",
                    "neo-tree",
                    "TelescopePrompt",
                    "lazy",
                    "mason",
                    "help",
                },

                under_cursor = true,

                large_file_cutoff = 10000,
                large_file_overrides = nil,

                min_count_to_highlight = 1,

                case_insensitive_regex = false,

                disable_keymaps = false,
            })
        end,
    },
}
