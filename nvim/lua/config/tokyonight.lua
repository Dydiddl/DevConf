local M = {}

function M.setup()
	require("tokyonight").setup({
		style = "night",
		transparent = false,
		terminal_colors = true,
		styles = {
			comments = { italic = true },
			keywords = { italic = true },
			functions = {},
			variables = {},
			sidebars = "transparent",
			floats = "transparent",
		},
		dim_incative = false,
		lualine_bold = false,
	})
end

return M
