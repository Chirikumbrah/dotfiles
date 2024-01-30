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

	color_scheme = 'Dracula (Official)',

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
	default_workspace = "mux",
	native_macos_fullscreen_mode = false,
	scrollback_lines = 5000,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",

	-- cursor config
	default_cursor_style = 'BlinkingBlock',
	-- animation_fps = 1,
	-- cursor_blink_ease_in = 'Constant',
	-- cursor_blink_ease_out = 'Constant',

	-- tab bar options
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	show_new_tab_button_in_tab_bar = false,
	show_tab_index_in_tab_bar = false,
	-- hide_tab_bar_if_only_one_tab = true,
	tab_max_width = 11,
	colors = {
		tab_bar = {
			active_tab = {
				bg_color = '#282a36',
				fg_color = '#bd93f9',
				intensity = 'Bold',
			},
			inactive_tab = {
				bg_color = '#282a36',
				fg_color = '#6272a4',
			},
			inactive_tab_hover = {
				bg_color = '#282a36',
				fg_color = '#6272b9',
				intensity = 'Bold',
			},
		},
	},

	-- dim inactive panes
	inactive_pane_hsb = {
		saturation = 1.0,
		brightness = 0.5,
	},

	-- keys
	keys = {

		-- convinient helix usage
		{
			mods = "CMD",
			key = "s",
			action = act.SendKey({ mods = "CTRL", key = "s" })
		},
		{
			mods = "CMD",
			key = "u",
			action = act.SendKey({ mods = "CTRL", key = "u" })
		},
		{
			mods = "CMD",
			key = "d",
			action = act.SendKey({ mods = "CTRL", key = "d" })
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

		{
			mods = "CMD|SHIFT",
			key = "t",
			action = act.ShowTabNavigator
		},
		{
			mods = "CMD|SHIFT",
			key = "w",
			action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" })
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

local process_icons = {
	['docker'] = wezterm.nerdfonts.linux_docker,
	['docker-compose'] = wezterm.nerdfonts.linux_docker,
	['psql'] = '󱤢',
	['usql'] = '󱤢',
	['kuberlr'] = wezterm.nerdfonts.linux_docker,
	['kubectl'] = wezterm.nerdfonts.linux_docker,
	['stern'] = wezterm.nerdfonts.linux_docker,
	['nvim'] = wezterm.nerdfonts.custom_vim,
	['make'] = wezterm.nerdfonts.seti_makefile,
	['vim'] = wezterm.nerdfonts.dev_vim,
	['node'] = wezterm.nerdfonts.mdi_hexagon,
	['go'] = wezterm.nerdfonts.seti_go,
	['zsh'] = wezterm.nerdfonts.dev_terminal,
	['bash'] = wezterm.nerdfonts.cod_terminal_bash,
	['btm'] = wezterm.nerdfonts.mdi_chart_donut_variant,
	['htop'] = wezterm.nerdfonts.mdi_chart_donut_variant,
	['cargo'] = wezterm.nerdfonts.dev_rust,
	['sudo'] = wezterm.nerdfonts.fa_hashtag,
	['lazydocker'] = wezterm.nerdfonts.linux_docker,
	['git'] = wezterm.nerdfonts.dev_git,
	['lua'] = wezterm.nerdfonts.seti_lua,
	['wget'] = wezterm.nerdfonts.mdi_arrow_down_box,
	['curl'] = wezterm.nerdfonts.mdi_flattr,
	['gh'] = wezterm.nerdfonts.dev_github_badge,
	['ruby'] = wezterm.nerdfonts.cod_ruby,
}

return config
