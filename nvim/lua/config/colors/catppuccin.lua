local M = {}

function M.setup()
	require("catppuccin").setup({
		flavour = "mocha",

		transparent_background = true,
		term_colors = true,

		integrations = {
			telescope = true,
			treesitter = true,
			mason = true,
			gitsigns = true,

			indent_blankline = {
				enabled = true,
			},
		},
	})
end

return M
