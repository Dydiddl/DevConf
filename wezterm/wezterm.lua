local wezterm = require("wezterm")
local mux = wezterm.mux

local config = wezterm.config_builder()

local is_windows = wezterm.target_triple:find("windows") ~= nil

-- ==================================================
-- Events
-- ==================================================

wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():set_position(29, 50)
end)

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
config.font_size = 12.5

-- theme
-- Harper
-- obsidian
-- JetBrains Darcula
-- Gruvbox dark, hard (base16)
-- Hipster Gree
-- cyberpunk
-- vibrantInk
config.color_scheme = ""

-- window
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = false

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.window_background_opacity = 0.75
config.text_background_opacity = 0.75
config.warn_about_missing_glyphs = false
config.window_close_confirmation = "NeverPrompt"

-- terminal size
config.initial_cols = 191
config.initial_rows = 60
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}
config.window_frame = {
	border_left_width = "2px",
	border_right_width = "2px",
	border_bottom_height = "2px",
	border_top_height = "2px",

	border_left_color = "#555555",
	border_right_color = "#555555",
	border_bottom_color = "#555555",
	border_top_color = "#555555",
}
-- cursor
config.max_fps = 120
config.animation_fps = 60
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 1300
config.cursor_blink_ease_in = "EaseOut"
config.cursor_blink_ease_out = "EaseOut"
config.visual_bell = {
	fade_in_duration_ms = 75,
	fade_out_duration_ms = 75,
	target = "CursorColor",
}

-- pane
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.7,
}
-- pane & split
local act = wezterm.action
config.leader = { mods = "CTRL", key = "b", timeout_milliseconds = 2000 }
config.keys = {
	{ mods = "LEADER", key = "'", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = ";", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "x", action = act.CloseCurrentPane({ confirm = false }) },
}

-- ==================================================
-- Windows
-- ================================================t==

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

return config
