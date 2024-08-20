local wezterm = require 'wezterm'

local config = wezterm.config_builder()
config.font = wezterm.font 'Operator Mono SSm'
config.font_size = 14
config.color_scheme = 'Bluloco Zsh Light (Gogh)'
config.initial_cols = 160
config.initial_rows = 80

return config