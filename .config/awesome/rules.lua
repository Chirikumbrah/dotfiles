-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  },
  -- Floating clients.
  {
    rule_any = {
      instance = {
        "DTA",   -- Firefox addon DownThemAll.
        "copyq", -- Includes session name in class.
        "pinentry",
      },
      class = {
      -- scratchpads
      	"spterm",
        "Telegram",
      	"KeePassXC",
      	"Audacious",
      	"Galculator",
      	"Orage",
      	image_viewer, 
      	"Nm-connection-editor",
      	"blueman-manager",
      	pdf_viewer, 
      	"pcmanfm-qt",
      	"Element",
      	"Pavucontrol-qt",
      -- other
      	"feh",
      	"vlc",
      	"mpv",
      	"ffplay",
      	"QjackCtl",
      	"Blueman-manager",
      	"FeatherPad",
      	"Nitrogen",
        "Arandr",
        "Gpick",
        "Kruler",
        "MessageWin",  -- kalarm.
        "Sxiv",
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "veromix",
        "xtightvncviewer" },
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester", -- xev.
      },
      role = {
        "AlarmWindow",   -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
      }
    },
    properties = { floating = true }
  },

  -- Add titlebars to normal clients and dialogs
  {
    rule_any = { type = { "normal", "dialog" }
    },
    properties = { titlebars_enabled = false }
  },

  -- FIRST
  {
    rule = { class = "Chromium" },
    properties = { screen = 1, tag = "1" }
  },
  {
    rule = { class = "Thorium-browser-unstable" },
    properties = { screen = 1, tag = "1" }
  },
  {
    rule = { class = "qutebrowser" },
    properties = { screen = 1, tag = "1" }
  },
  {
    rule = { class = "Firefox" },
    properties = { screen = 1, tag = "1" }
  },
  {
    rule = { class = "librewolf" },
    properties = { screen = 1, tag = "1" }
  },
  {
    rule = { class = "Vieb" },
    properties = { screen = 1, tag = "1" }
  },
  -- SECOND
  {
    rule = { class = "Alacritty" },
    properties = { screen = 1, tag = "2" }
  },
  {
    rule = { class = "st" },
    properties = { screen = 1, tag = "2" }
  },
  -- THIRD
  {
    rule = { class = "ranger" },
    properties = { screen = 1, tag = "3" }
  },
  {
    rule = { class = "Localsend_app" },
    properties = { screen = 1, tag = "3" }
  },
  {
    rule = { class = "qBittorrent" },
    properties = { screen = 1, tag = "3" }
  },
  -- FOURTH
  {
    rule = { class = "Slack" },
    properties = { screen = 1, tag = "4" }
  },
  -- FIFTH
  {
    rule = { class = "Code" },
    properties = { screen = 1, tag = "5" }
  },
  {
    rule = { class = "jetbrains-pycharm-ce" },
    properties = { screen = 1, tag = "5" }
  },
  {
    rule = { class = "Lens" },
    properties = { screen = 1, tag = "5" }
  },
  {
    rule = { class = "Notesnook" },
    properties = { screen = 1, tag = "5" }
  },
  {
    rule = { class = "Joplin" },
    properties = { screen = 1, tag = "5" }
  },
  {
    rule = { class = "QOwnNotes" },
    properties = { screen = 1, tag = "5" }
  },
  -- SIXTH
  {
    rule = { class = "guitarpro7.exe" },
    properties = { screen = 1, tag = "6" }
  },
  {
    rule = { class = "transcribe.exe" },
    properties = { screen = 1, tag = "6" }
  },
  {
    rule = { class = "TuxGuitar" },
    properties = { screen = 1, tag = "6" }
  },
  {
    rule = { class = "Picard" },
    properties = { screen = 1, tag = "6" }
  },
  {
    rule = { class = "Gtick" },
    properties = { screen = 1, tag = "6" }
  },
  {
    rule = { class = "Lingot" },
    properties = { screen = 1, tag = "6" }
  },
  {
    rule = { class = "Flowblade" },
    properties = { screen = 1, tag = "6" }
  },
  {
    rule = { class = "java" },
    properties = { screen = 1, tag = "6" }
  },
  -- SEVENTH
  {
    rule = { class = "Soffice" },
    properties = { screen = 1, tag = "7" }
  },
  {
    rule = { class = "libreoffice" },
    properties = { screen = 1, tag = "7" }
  },
  {
    rule = { class = "kolourpaint" },
    properties = { screen = 1, tag = "7" }
  },
  {
    rule = { class = "Gimp" },
    properties = { screen = 1, tag = "7" }
  },
  {
    rule = { class = "DesktopEditors" },
    properties = { screen = 1, tag = "7" }
  },
  {
    rule = { class = "Rustdesk" },
    properties = { screen = 1, tag = "7" }
  },
  {
    rule = { class = "Zathura" },
    properties = { screen = 1, tag = "7" }
  },
  -- EIGHTH
  {
    rule = { class = "discord" },
    properties = { screen = 1, tag = "8" }
  },
  {
    rule = { class = "Skype" },
    properties = { screen = 1, tag = "8" }
  },
  {
    rule = { class = "zoom" },
    properties = { screen = 1, tag = "8" }
  },
  {
    rule = { class = "Jami" },
    properties = { screen = 1, tag = "8" }
  },
  {
    rule = { class = "obs" },
    properties = { screen = 1, tag = "8" }
  },
  -- NINTH
  {
    rule = { class = "htop" },
    properties = { screen = 1, tag = "9" }
  },
}
-- }}}
