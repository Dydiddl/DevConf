local wezterm = require("wezterm")

local config = wezterm.config_builder()

local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_macos = wezterm.target_triple:find("darwin") ~= nil

-- ==================================================
-- Common
-- ==================================================
-- 1 순위 : JetBrainsMono Nerd Font Mono,
--          D2CodingLigature Nerd Font Mono
-- 2 순위 : MartianMono Nerd Font Mono
-- 4 순위 : Hack Nerd Font
-- 5 순위 : UbuntuMono Nerd Font Mono
config.font = wezterm.font_with_fallback({
    "MartianMono Nerd Font Mono",
    "D2CodingLigature Nerd Font Mono",
    "Noto Color Emoji",
})

config.font_size = 13.0

-- theme
-- Harper
-- obsidian
-- JetBrains Darcula
-- Gruvbox dark, hard (base16)
-- Hipster Gree
-- cyberpunk
config.color_scheme = "cyberpunk"

-- window
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = false

-- terminal size
config.initial_cols = 140
config.initial_rows = 40
config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
}

config.window_background_opacity = 0.85
config.window_close_confirmation = "NeverPrompt"

-- cursor
config.animation_fps = 120
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 1300
config.cursor_blink_ease_in = "EaseOut"
config.cursor_blink_ease_out = "EaseOut"
config.visual_bell = {
    fade_in_duration_ms = 75,
    fade_out_duration_ms = 75,
    target = "CursorColor",
}

-- Keep these only if you prefer their rendering.
-- config.freetype_load_target = "Light"
-- config.freetype_render_target = "HorizontalLcd"

-- ==================================================
-- Windows
-- ==================================================

if is_windows then
    config.default_prog = {
        "wsl.exe",
        "-d",
        "Ubuntu-24.04",
        "--cd",
        "/home/dydid",
    }
    -- 투명도를 조절하는데 뒤가 잘 안보이게 하는 옵션
    -- config.win32_system_backdrop = "Mica"
end

-- ==================================================
-- macOS
-- ==================================================

if is_macos then
    config.native_macos_fullscreen_mode = true
end

return config
