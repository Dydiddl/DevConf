return {
    "folke/noice.nvim",
    event = "VeryLazy",

    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },

    config = function()
        require("noice").setup({
            messages = {
                enabled = true,

                -- 일반 메시지와 경고는 nvim-notify로 전달한다.
                view = "notify",
                view_warn = "notify",

                -- 오류는 아래 routes에서 길이에 따라 분류한다.
                view_error = "notify",

                view_history = "messages",
                view_search = "virtualtext",
            },

            notify = {
                enabled = true,
                view = "notify",
            },

            views = {
                -- 긴 오류를 표시하는 아래쪽 split
                error_split = {
                    backend = "split",
                    relative = "editor",
                    position = "bottom",
                    size = {
                        height = 15,
                    },
                    enter = true,
                    win_options = {
                        wrap = true,
                    },
                },

                -- 짧은 오류를 표시하는 중앙 popup
                error_popup = {
                    backend = "popup",
                    relative = "editor",
                    position = {
                        row = "50%",
                        col = "50%",
                    },
                    size = {
                        width = "60%",
                        height = "auto",
                    },
                    border = {
                        style = "rounded",
                    },
                    enter = false,
                    win_options = {
                        wrap = true,
                        winblend = 0,
                    },
                },
            },

            routes = {
                -- 오류이면서 4줄 이상이면 아래쪽 split으로 보낸다.
                {
                    filter = {
                        error = true,
                        min_height = 4,
                    },
                    view = "error_split",
                    opts = {
                        stop = true,
                    },
                },

                -- 오류이면서 3줄 이하면 중앙 popup으로 보낸다.
                {
                    filter = {
                        error = true,
                        max_height = 3,
                    },
                    view = "error_popup",
                    opts = {
                        stop = true,
                    },
                },

                -- 경고는 오른쪽 아래 notify로 보내고 6초간 표시한다.
                {
                    filter = {
                        warning = true,
                    },
                    view = "notify",
                    opts = {
                        timeout = 6000,
                    },
                },

                -- 일반 notify 알림은 오른쪽 아래에서 3초간 표시한다.
                {
                    filter = {
                        event = "notify",
                        ["not"] = {
                            any = {
                                { error = true },
                                { warning = true },
                            },
                        },
                    },
                    view = "notify",
                    opts = {
                        timeout = 3000,
                    },
                },
            },

            presets = {
                bottom_search = true,
                command_palette = true,

                -- 직접 route를 만들었으므로 기본 자동 분리는 끈다.
                long_message_to_split = false,

                inc_rename = false,
                lsp_doc_border = false,
            },
        })
    end,
}
