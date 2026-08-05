return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				java = { "google-java-format" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				-- sql = { "sql-formatter" },
				toml = { "taplo" },
			},

			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},
}
