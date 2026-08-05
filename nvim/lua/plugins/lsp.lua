local mapKey = require("utils.keyMapper").mapKey

return {
	{
		"mason-org/mason-lspconfig.nvim",

		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {},
			},

			"neovim/nvim-lspconfig",
		},

		init = function()
			local lspKeymapGroup = vim.api.nvim_create_augroup("LspKeymaps", {
				clear = true,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = lspKeymapGroup,

				callback = function(event)
					local opts = function(description)
						return {
							buffer = event.buf,
							desc = "LSP: " .. description,
						}
					end

					mapKey("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))

					mapKey("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))

					mapKey("n", "K", vim.lsp.buf.hover, opts("Hover documentation"))

					mapKey("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code Action"))
				end,
			})
		end,

		opts = {
			ensure_installed = {
				-- Lua
				"lua_ls",

				-- Java
				"jdtls",

				-- Python
				"basedpyright",

				-- C
				"clangd",

				-- Markdown
				"marksman",

				-- Config
				"jsonls",
				"yamlls",

				-- Shell
				"bashls",
				"powershell_es",
			},

			automatic_enable = {
				exclude = {
					"stylua",
				},
			},
		},
	},
}
