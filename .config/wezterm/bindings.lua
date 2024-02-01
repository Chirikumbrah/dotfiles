local M = {}
local wezterm = require("wezterm")
local action = wezterm.action
local helpers = require("utils/helpers")

M.default = {
	{ mods = "CMD", key = "v", action = action({ PasteFrom = "Clipboard" }) },
	{ mods = "CMD", key = "c", action = action({ CopyTo = "Clipboard" }) },
	{ mods = "CMD", key = "q", action = wezterm.action.QuitApplication },
	{ mods = "CMD", key = "=", action = "ResetFontSize", },
	{ mods = "CMD", key = "+", action = "IncreaseFontSize", },
	{ mods = "CMD", key = "-", action = "DecreaseFontSize", },
}

M.helix = {
	{ mods = "CMD",       key = "s", action = action.SendKey({ mods = "CTRL", key = "s" }) },
	{ mods = "CMD",       key = "u", action = action.SendKey({ mods = "CTRL", key = "u" }) },
	{ mods = "CMD",       key = "d", action = action.SendKey({ mods = "CTRL", key = "d" }) },
	{ mods = "CMD|SHIFT", key = "a", action = action.SendKey({ mods = "CTRL|SHIFT", key = "a" }) },
	{ mods = "CMD|SHIFT", key = "x", action = action.SendKey({ mods = "CTRL|SHIFT", key = "x" }) }, }

M.tmux = {
	-- 		k.cmd_key("q", k.multiple_actions(":qa!")),
	helpers.cmd_to_tmux_prefix("1", "1"),
	helpers.cmd_to_tmux_prefix("2", "2"),
	helpers.cmd_to_tmux_prefix("3", "3"),
	helpers.cmd_to_tmux_prefix("4", "4"),
	helpers.cmd_to_tmux_prefix("5", "5"),
	helpers.cmd_to_tmux_prefix("6", "6"),
	helpers.cmd_to_tmux_prefix("7", "7"),
	helpers.cmd_to_tmux_prefix("8", "8"),
	helpers.cmd_to_tmux_prefix("9", "9"),
	helpers.cmd_to_tmux_prefix("t", "c"),
	helpers.cmd_to_tmux_prefix("е", "c"),
	helpers.cmd_to_tmux_prefix("w", "x"),
	helpers.cmd_to_tmux_prefix("e", '"'),
	helpers.cmd_to_tmux_prefix("E", "%"),
	-- helpers.cmd_to_tmux_prefix("`", "n"),
	-- helpers.cmd_to_tmux_prefix("b", "B"),
	-- helpers.cmd_to_tmux_prefix("C", "C"),
	-- helpers.cmd_to_tmux_prefix("d", "D"),
	-- helpers.cmd_to_tmux_prefix("G", "G"),
	-- helpers.cmd_to_tmux_prefix("g", "g"),
	-- helpers.cmd_to_tmux_prefix("K", "T"),
	-- helpers.cmd_to_tmux_prefix("k", "K"),
	-- helpers.cmd_to_tmux_prefix("l", "L"),
	-- helpers.cmd_to_tmux_prefix("o", "u"),
	-- helpers.cmd_to_tmux_prefix("T", "!"),
	-- helpers.cmd_to_tmux_prefix("z", "z"),
	-- helpers.cmd_to_tmux_prefix("Z", "Z"),

	{
		mods = "CMD|SHIFT",
		key = "}",
		action = action.Multiple({
			action.SendKey({ mods = "CTRL", key = "b" }),
			action.SendKey({ key = "n" }),
		}),
	},
	{
		mods = "CMD|SHIFT",
		key = "{",
		action = action.Multiple({
			action.SendKey({ mods = "CTRL", key = "b" }),
			action.SendKey({ key = "p" }),
		}),
	},
	{
		mods = "CMD|SHIFT",
		key = "Х",
		action = action.Multiple({
			action.SendKey({ mods = "CTRL", key = "b" }),
			action.SendKey({ key = "p" }),
		}),
	},
	{
		mods = "CMD|SHIFT",
		key = "Ъ",
		action = action.Multiple({
			action.SendKey({ mods = "CTRL", key = "b" }),
			action.SendKey({ key = "n" }), }),
	},

	-- 		{
	-- 			key = "Tab",
	-- 			mods = "CTRL",
	-- 				act.SendKey({ mods = "CTRL", key = "b" }),
	-- 			action = act.Multiple({
	-- 				act.SendKey({ key = "n" }),
	-- 			}),
	-- 		},

	-- 		{
	-- 			mods = "CTRL|SHIFT",
	-- 			key = "Tab",
	-- 			action = act.Multiple({
	-- 				act.SendKey({ mods = "CTRL", key = "b" }),
	-- 				act.SendKey({ key = "n" }),
	-- 			}),
	-- 		},

	-- 		-- FIX: disable binding
	-- 		-- {
	-- 		-- 	mods = "CMD",
	-- 		-- 	key = "`",
	-- 		-- 	action = act.Multiple({
	-- 		-- 		act.SendKey({ mods = "CTRL", key = "b" }),
	-- 		-- 		act.SendKey({ key = "n" }),
	-- 		-- 	}),
	-- 		-- },

	-- 		{
	-- 			mods = "CMD",
	-- 			key = "~",
	-- 			action = act.Multiple({
	-- 				act.SendKey({ mods = "CTRL", key = "b" }),
	-- 				act.SendKey({ key = "p" }),
	-- 			}),
	-- 		},
}

function M.create_keybinds()
	return helpers.merge_lists(M.default, M.helix, M.tmux)
end

return M
