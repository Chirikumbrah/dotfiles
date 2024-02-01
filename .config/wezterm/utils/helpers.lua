local wezterm = require("wezterm")
local M = {}

local appearance = wezterm.gui.get_appearance()

M.is_dark = function()
	return appearance:find("Dark")
end

M.get_random_entry = function(tbl)
	local keys = {}
	for key, _ in ipairs(tbl) do
		table.insert(keys, key)
	end
	local randomKey = keys[math.random(1, #keys)]
	return tbl[randomKey]
end

M.merge_lists = function(t1, t2, t3)
	local result = {}
	for _, v in pairs(t1) do
		table.insert(result, v)
	end
	for _, v in pairs(t2) do
		table.insert(result, v)
	end
	for _, v in pairs(t3) do
		table.insert(result, v)
	end
	return result
end

local wt_action = require("wezterm").action

M.multiple_actions = function(keys)
	local actions = {}
	for key in keys:gmatch(".") do
		table.insert(actions, wt_action.SendKey({ key = key }))
	end
	table.insert(actions, wt_action.SendKey({ key = "\n" }))
	return wt_action.Multiple(actions)
end

M.key_table = function(mods, key, action)
	return {
		mods = mods,
		key = key,
		action = action,
	}
end

M.cmd_key = function(key, action)
	return M.key_table("CMD", key, action)
end

M.cmd_to_tmux_prefix = function(key, tmux_key)
	return M.cmd_key(
		key,
		wt_action.Multiple({
			wt_action.SendKey({ mods = "CTRL", key = "b" }),
			wt_action.SendKey({ key = tmux_key }),
		})
	)
end

return M
