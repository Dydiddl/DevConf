return {
	"saghen/blink.cmp",

	version = "1.*",

	opts = {
		keymap = {
			preset = "default",
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			menu = {
				border = "rounded",
				max_height = 12,
				scrollbar = true,

				draw = {
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind" },
					},
				},
			},

			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,

				window = {
					border = "rounded",
				},
			},
		},

		sources = {
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
			},
		},

		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},
	},

	opts_extend = {
		"sources.default",
	},
}
