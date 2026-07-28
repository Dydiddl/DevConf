return {
    {
        "folke/tokyonight.nvim",

        -- Neovim 시작 시 바로 로드
        lazy = false,

        -- 다른 플러그인보다 먼저 로드
        priority = 1000,

        opts = {
	-- "storm", "moon", "night", "day"
            style = "night",
        },

        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight")
        end,
    },
}
