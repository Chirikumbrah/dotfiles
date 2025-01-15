vim.g.mapleader = " "

vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.ignorecase = true

vim.opt.number = true

vim.opt.path:append("**")

-- https://vi.stackexchange.com/a/5318/7339
vim.g.matchparen_timeout = 20
vim.g.matchparen_insert_timeout = 20

vim.opt.termguicolors = true
vim.opt.incsearch = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.smartindent = true
vim.opt.expandtab = true

vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smoothscroll = true

vim.opt.updatetime = 50

vim.g.netrw_banner = false
vim.g.netrw_liststyle = 3 -- tree view
vim.g.netrw_fastbrowse = 0 -- netrw as buffer

vim.opt.list = true
vim.opt.listchars:append({ trail =  "·", nbsp =  "·" })

-- vim.opt.fillchars = {
--     vert = "│", -- alternatives ▕
--     fold = " ",
--     eob = " ", -- suppress ~ at EndOfBuffer
--     diff = "╱", -- alternatives = ⣿ ░ ─
--     msgsep = "‾",
--     foldopen = "▾",
--     foldsep = "│",
--     foldclose = "▸",
-- }

vim.cmd.colorscheme("habamax")
