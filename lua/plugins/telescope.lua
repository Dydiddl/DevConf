return {
    {
        "nvim-telescope/telescope.nvim",
        version = "*",

        dependencies = {
            "nvim-lua/plenary.nvim",

            {
                "nvim-telescope/telescope-fzf-native.nvim",

                build = table.concat({
                    "cmake -S. -B build",
                    "-G Ninja",
                    "-DCMAKE_BUILD_TYPE=Release",
                    "&& cmake --build build",
                }, " "),

                cond = function()
                    return vim.fn.executable("cmake") == 1
                        and vim.fn.executable("ninja") == 1
                end,
            },
        },

        keys = {
            {
                "<leader>ff",
                function()
                    require("telescope.builtin").find_files()
                end,
                desc = "Find files",
            },
            {
                "<leader>fg",
                function()
                    require("telescope.builtin").live_grep()
                end,
                desc = "Live grep",
            },
            {
                "<leader>fb",
                function()
                    require("telescope.builtin").buffers()
                end,
                desc = "Find buffers",
            },
            {
                "<leader>fh",
                function()
                    require("telescope.builtin").help_tags()
                end,
                desc = "Help tags",
            },
        },

        opts = {},

        config = function(_, opts)
            local telescope = require("telescope")

            telescope.setup(opts)
            pcall(telescope.load_extension, "fzf")
        end,
    },
}
