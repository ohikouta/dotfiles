local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'AdventureTime'
config.window_background_opacity = 0.85
config.front_end = "Software"

local act = wezterm.action
config.keys = {
  {
    key = 'f',
    mods = 'SHIFT|META',
    action = wezterm.action.ToggleFullScreen,
  },
}

return config
