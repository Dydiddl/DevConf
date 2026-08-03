return {
    "rcarriga/nvim-notify",

    config = function()
        local notify = require("notify")

        notify.setup({
            stages = "fade_in_slide_out",
            render = "compact",

            -- false이면 오른쪽 아래에서 위쪽으로 알림이 쌓인다.
            top_down = false,

            -- 기본값. 개별 알림 시간은 아래 vim.notify 래퍼에서 결정한다.
            timeout = 3000,

            max_width = function()
                return math.floor(vim.o.columns * 0.45)
            end,

            max_height = function()
                return math.floor(vim.o.lines * 0.35)
            end,
        })

        -- 알림 등급에 따라 표시 시간을 다르게 지정한다.
        vim.notify = function(message, level, opts)
            level = level or vim.log.levels.INFO
            opts = opts or {}

            if opts.timeout == nil then
                if level == vim.log.levels.ERROR then
                    opts.timeout = 10000
                elseif level == vim.log.levels.WARN then
                    opts.timeout = 6000
                else
                    opts.timeout = 3000
                end
            end

            return notify(message, level, opts)
        end

        -- 놓친 알림 기록 확인
        -- vim.keymap.set("n", "<leader>nh", "<cmd>Noice history<CR>", {
        --     desc = "Notification history",
        -- })
    end,
}
