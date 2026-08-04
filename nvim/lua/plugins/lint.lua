return {
	{
		"mfussenegger/nvim-lint",

		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				lua = { "luacheck" },
				python = { "ruff" },
				-- java = { "checkstyle" },
				-- json = { "jsonlint" },
				-- yaml = { "yamllint" },
				markdown = { "markdownlint-cli2" },
				-- sql = { "sqlfluff" },
			}

			vim.api.nvim_create_autocmd("BufWritePost", {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
