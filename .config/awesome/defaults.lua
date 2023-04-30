-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
gears = require("gears")
awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
wibox = require("wibox")
-- Theme handling library
beautiful = require("beautiful")
-- Notification library
naughty = require("naughty")
menubar = require("menubar")
hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

theme_path = string.format("%s/.config/awesome/theme.lua", os.getenv("HOME"))
scripts_path = string.format("%s/.scripts/system", os.getenv("HOME"))
config_path = awful.util.getdir("config")
scratch = require("scratchpads")

-- This is used later as the default terminal and editor to run.
terminal         = "alacritty"
browser          = "chromium"
image_viewer     = "qimgv"
pdf_viewer       = "qpdfview"
editor           = os.getenv("EDITOR") or "hx"
editor_cmd       = terminal .. " -e " .. editor


-- Default modkey.$HOME/.config/awesome"
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey                 = "Mod4"
alt                    = "Mod1"
