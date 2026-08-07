local M = {}

local function transparent_bg(group)
	local hl = vim.api.nvim_get_hl(0, {
		name = group,
		link = false,
	})

	hl.bg = nil

	vim.api.nvim_set_hl(0, group, hl)
end

function M.setup()
	local groups = {
		-- ==================================================
		-- Neovim
		-- ==================================================
		"Normal",
		"NormalNC",
		"NormalFloat",

		"LineNr",
		"LineNrAbove",
		"LineNrBelow",
		"CursorLineNr",

		"SignColumn",
		"FoldColumn",

		"EndOfBuffer",

		"FloatBorder",
		"FloatTitle",

		-- ==================================================
		-- Diagnostics
		-- ==================================================
		"DiagnosticSignError",
		"DiagnosticSignWarn",
		"DiagnosticSignInfo",
		"DiagnosticSignHint",

		-- ==================================================
		-- Telescope
		-- ==================================================
		"TelescopeNormal",
		"TelescopeBorder",

		"TelescopePromptNormal",
		"TelescopePromptBorder",

		"TelescopeResultsNormal",
		"TelescopeResultsBorder",

		"TelescopePreviewNormal",
		"TelescopePreviewBorder",

		-- ==================================================
		-- mini.files
		-- ==================================================
		"MiniFilesNormal",
		"MiniFilesBorder",
		"MiniFilesBorderModified",
		"MiniFilesCursorLine",
		"MiniFilesTitle",
		"MiniFilesTitleFocused",

		-- ==================================================
		-- Statusline
		-- ==================================================
		"StatusLine",
		"StatusLineNC",
	}

	for _, group in ipairs(groups) do
		transparent_bg(group)
	end
end

return M
