return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false,
    enabled = false,

    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        require("neo-tree").setup({})

        local mapKey = require("utils.keyMapper").mapKey

        mapKey("n", "<leader>E", "<cmd>Neotree toggle<CR>", {
            desc = "Toggle Neo-tree",
        })
    end,
}
