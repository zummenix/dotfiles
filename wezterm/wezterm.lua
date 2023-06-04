local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font('Source Code Pro')
config.font_rules = {
  {
    intensity = 'Bold',
    italic = false,
    font = wezterm.font_with_fallback({
      { family = "Source Code Pro", weight = "Bold" },
    })
  },
}

config.colors = {
  tab_bar = {
    inactive_tab_edge = '#343D46',
    active_tab = {
      bg_color = '#A3BE8C',
      fg_color = '#2B303B',
    },
    inactive_tab = {
      bg_color = '#2B303B',
      fg_color = '#A7ADBA',
    },
    inactive_tab_hover = {
      bg_color = '#2B303B',
      fg_color = '#C0C5CE',
    },
  },
}

config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.window_frame = {
  active_titlebar_bg = '#343D46',
  inactive_titlebar_bg = '#4F5B66',
}

config.color_scheme = 'Ocean (base16)'

return config
