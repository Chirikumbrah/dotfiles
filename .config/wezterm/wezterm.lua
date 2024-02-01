-- ██║    ██║██╔════╝╚══███╔╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
-- ██╗    ██╗███████╗███████╗████████╗███████╗██████╗ ███╗   ███╗
-- ██║ █╗ ██║█████╗    ███╔╝    ██║   █████╗  ██████╔╝██╔████╔██║
-- ██║███╗██║██╔══╝   ███╔╝     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
-- ╚███╔███╔╝███████╗███████╗   ██║   ███████╗██║  ██║██║ ╚═╝ ██║
--  ╚══╝╚══╝ ╚══════╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
-- A GPU-accelerated cross-platform terminal emulator
-- https://wezfurlong.org/wezterm/

local wezterm = require("wezterm")
local bindings = require("bindings")

local config = {
	default_prog = { '/usr/local/bin/fish',
		'-l',
		'-c',
		'tmux attach || tmux new -s tmux'
	},

	line_height = 1,
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

	color_scheme = 'Dracula (Official)',

	-- window_background_opacity = 1.0,
	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 0,
	},

	-- to start WezTerm maximized set theese two parameters
	initial_cols = 200,
	initial_rows = 60,

	set_environment_variables = {
		TERM = "xterm-256color",
		LC_ALL = "en_US.UTF-8",
	},

	-- general options
	disable_default_key_bindings = true,
	debug_key_events = false,
	native_macos_fullscreen_mode = false,
	scrollback_lines = 10000,
	enable_scroll_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	enable_tab_bar = false,
	-- tab_bar_at_bottom = true,
	-- use_fancy_tab_bar = false,

	-- cursor config
	default_cursor_style = 'BlinkingBlock',
	-- animation_fps = 1,
	-- cursor_blink_ease_in = 'Constant',
	-- cursor_blink_ease_out = 'Constant',

	-- dim inactive panes
	inactive_pane_hsb = {
		saturation = 1.0,
		brightness = 0.5,
	},

	-- keys
	keys = bindings.create_keybinds(),
}

return config
