local M = {}

function M.setup()
	local groups = {
		"Normal",
		"NormalNC",
		-- "NormalFloat",

		-- Number / Sign column
		"LineNr",
		-- "LineNrAbove",
		-- "LineNrBelow",
		-- "CursorLineNr",

		"SignColumn",
		"FoldColumn",

		-- Empty lines
		"EndOfBuffer",
	}

	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, { bg = "none" })
	end
end

return M
