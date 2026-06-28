local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback {
  'MesloLGS NF',
  'JetBrains Mono',
  'Symbols Nerd Font Mono',
  'Noto Color Emoji',
}
config.font_size = 12.0
config.line_height = 1.1
config.warn_about_missing_glyphs = false

config.color_scheme = 'Catppuccin Mocha'

config.window_background_opacity = 0.92
config.kde_window_background_blur = true
config.window_decorations = 'RESIZE'
config.window_padding = {
  left = 8,
  right = 8,
  top = 4,
  bottom = 4,
}

config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 28
config.scrollback_lines = 10000
config.adjust_window_size_when_changing_font_size = false
config.audible_bell = 'Disabled'
config.check_for_updates = false
config.scroll_to_bottom_on_input = true

config.default_prog = { '/usr/bin/zsh', '-l' }

return config
