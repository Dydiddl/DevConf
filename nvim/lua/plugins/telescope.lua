local is_windows = vim.fn.has("win32") == 1

return {
	{
		"nvim-telescope/telescope.nvim",

		event = "VeryLazy",

		dependencies = {
			"nvim-lua/plenary.nvim",

			{
				"nvim-telescope/telescope-fzf-native.nvim",

				build = "make",

				cond = function()
					return not is_windows and vim.fn.executable("make") == 1 and vim.fn.executable("cc") == 1
				end,
			},

			"nvim-telescope/telescope-ui-select.nvim",
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

		opts = function()
			return {
				defaults = {
					dynamic_preview_title = true,

					layout_config = {},

					path_display = {
						"filename_first",
					},
				},

				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			}
		end,

		config = function(_, opts)
			local telescope = require("telescope")

			telescope.setup(opts)

			if not is_windows then
				telescope.load_extension("fzf")
			end

			telescope.load_extension("ui-select")
		end,
	},
}
