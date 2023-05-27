local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font('Source Code Pro')

config.colors = {
  cursor_bg = '#A7ADBA',
  cursor_fg = '#2B303B',
}

return config
