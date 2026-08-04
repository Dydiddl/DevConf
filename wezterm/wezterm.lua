local wezterm = require("wezterm")

local config = wezterm.config_builder()

local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_macos = wezterm.target_triple:find("darwin") ~= nil

-- ==================================================
-- Common
-- ==================================================

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 13.0

config.color_scheme = "Catppuccin Mocha"

config.enable_tab_bar = true
config.use_fancy_tab_bar = false

config.window_padding = {
    left = 8,
    right = 8,
    top = 8,
    bottom = 8,
}

-- ==================================================
-- Windows
-- ==================================================

if is_windows then
    config.default_domain = "local"
    config.default_prog = { "pwsh.exe" }
end

-- ==================================================
-- macOS
-- ==================================================

if is_macos then
    config.native_macos_fullscreen_mode = true
end

config.hide_tab_bar_if_only_one_tab = true

return config
