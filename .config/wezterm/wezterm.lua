--
-- ██╗    ██╗███████╗███████╗████████╗███████╗██████╗ ███╗   ███╗
-- ██║    ██║██╔════╝╚══███╔╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
-- ██║ █╗ ██║█████╗    ███╔╝    ██║   █████╗  ██████╔╝██╔████╔██║
-- ██║███╗██║██╔══╝   ███╔╝     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
-- ╚███╔███╔╝███████╗███████╗   ██║   ███████╗██║  ██║██║ ╚═╝ ██║
--  ╚══╝╚══╝ ╚══════╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
-- A GPU-accelerated cross-platform terminal emulator
-- https://wezfurlong.org/wezterm/

local h = require("utils/helpers")
local k = require("utils/keys")

local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

local config = {
	colors = {
		background = "#282a36"
	},

	line_height = 1.1,
	font = wezterm.font 'JetBrainsMono Nerd Font',
	font_rules = {
		{
			intensity = 'Bold',
			italic = false,
			font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold", stretch = "Normal", style = "Normal" })
		},
		{
			intensity = 'Bold',
			italic = true,
			font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold", stretch = "Normal", style = "Italic" })
		},
	},
	font_size = 15,

	color_scheme = 'Dracula',

	-- window_background_opacity = 1.0,
	window_padding = {
		left = 30,
		right = 30,
		top = 20,
		bottom = 10,
	},

	-- to start WezTerm maximized set theese two parameters
	initial_cols = 200,
	initial_rows = 50,

	set_environment_variables = {
		TERM = "xterm-256color",
		LC_ALL = "en_US.UTF-8",
	},

	-- general options
	adjust_window_size_when_changing_font_size = false,
	disable_default_key_bindings = false,
	debug_key_events = false,
	enable_tab_bar = true,
	tab_bar_at_bottom = true,
	native_macos_fullscreen_mode = false,
	scrollback_lines = 5000,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",

	-- keys
	keys = {

		-- convinient helix usage
		{
			mods = "CMD",
			key = "s",
			action = act.SendKey({ mods = "CTRL", key = "s" })
		},
		{
			mods = "CMD|SHIFT",
			key = "a",
			action = act.SendKey({ mods = "CTRL|SHIFT", key = "a" })
		},
		{
			mods = "CMD|SHIFT",
			key = "x",
			action = act.SendKey({ mods = "CTRL|SHIFT", key = "x" })
		},

		-- split panes
		{
			mods = "CMD",
			key = "e",
			action = act.SplitVertical
		},
		{
			mods = "CMD|SHIFT",
			key = "e",
			action = act.SplitHorizontal
		},

		-- switch between panes
		{
			mods = "CMD",
			key = "LeftArrow",
			action = act.ActivatePaneDirection("Left")
		},
		{
			mods = "CMD",
			key = "RightArrow",
			action = act.ActivatePaneDirection("Right")
		},
		{
			mods = "CMD",
			key = "UpArrow",
			action = act.ActivatePaneDirection("Up")
		},
		{
			mods = "CMD",
			key = "DownArrow",
			action = act.ActivatePaneDirection("Down")
		},

		-- resize panes
		{
			mods = "CMD|SHIFT",
			key = "LeftArrow",
			action = act.AdjustPaneSize({ "Left", 5 })
		},
		{
			mods = "CMD|SHIFT",
			key = "RightArrow",
			action = act.AdjustPaneSize({ "Right", 5 })
		},
		{
			mods = "CMD|SHIFT",
			key = "UpArrow",
			action = act.AdjustPaneSize({ "Up", 2 })
		},
		{
			mods = "CMD|SHIFT",
			key = "DownArrow",
			action = act.AdjustPaneSize({ "Down", 2 })
		},

	},
}

return config
