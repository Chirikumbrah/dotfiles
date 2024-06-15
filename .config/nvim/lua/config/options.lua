-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.wrap = true -- Enable line wrap
local space = "·"
vim.opt.listchars:append({
  -- tab = "⇥", -- this one conflicts with plugins for indent line
  eol = "↵",
  multispace = space,
  lead = space,
  trail = space,
  nbsp = space,
})

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- scrolling
vim.opt.scrolloff = 11

-- markdown preview
vim.g.mkdp_browser = "/Applications/Safari.app/Contents/MacOS/Safari"
