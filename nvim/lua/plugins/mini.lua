return {
	{
		"nvim-mini/mini.nvim",
		version = false,

		config = function()
			require("mini.icons").setup()

			require("mini.pairs").setup()

			require("mini.ai").setup()

			require("mini.surround").setup()

			local files = require("mini.files")
			local mapKey = require("utils.keyMapper").mapKey

			files.setup({
				mappings = {
					go_in = "<CR>",
					go_in_plus = "L",
					go_out = "-",
					go_out_plus = "H",
					close = "q",
					show_help = "g?",
				},

				options = {
					use_as_default_explorer = false,
				},
			})

			mapKey("n", "<leader>e", function()
				local current_file = vim.api.nvim_buf_get_name(0)
				local path = current_file ~= "" and current_file or vim.uv.cwd()

				files.open(path, false)
			end, {
				desc = "Open mini.files at current file",
			})

			mapKey("n", "<leader>-", function()
				files.open(vim.uv.cwd(), false)
			end, {
				desc = "Open mini.files at project root",
			})
		end,
	},
}
