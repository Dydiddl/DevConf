local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

                    Imagination
]]

return {
    "goolord/alpha-nvim",

    event = "VimEnter",

    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = vim.split(logo, "\n")

        dashboard.section.buttons.val = {
            dashboard.button(
                "f",
                "󰱼  Find file",
                "<cmd>Telescope find_files<CR>"
            ),

            dashboard.button(
                "g",
                "󰺮  Find text",
                "<cmd>Telescope live_grep<CR>"
            ),

            dashboard.button(
                "r",
                "󰄉  Recent files",
                "<cmd>Telescope oldfiles<CR>"
            ),

            dashboard.button(
                "c",
                "  Neovim Configuration",
                "<cmd>cd "
                    .. vim.fn.stdpath("config")
                    .. " | Telescope find_files<CR>"
            ),

            dashboard.button(
                "l",
                "󰒲  Lazy",
                "<cmd>Lazy<CR>"
            ),

            dashboard.button(
                "q",
                "󰅚  Quit",
                "<cmd>qa<CR>"
            ),
        }

        dashboard.section.header.opts.hl = "Title"
        dashboard.section.buttons.opts.hl = "Function"
        dashboard.section.footer.opts.hl = "Comment"

        dashboard.section.footer.val = {
            "Turning imagination into reality",
        }

        dashboard.config.opts.noautocmd = true

        alpha.setup(dashboard.config)
    end,
}
