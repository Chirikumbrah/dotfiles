vim.opt.guicursor = ""

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = true

vim.opt.smartindent = true

vim.opt.termguicolors = true
vim.opt.incsearch = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

-- vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
vim.opt.completeopt = "menu,menuone,noselect"

vim.opt.autowrite = true

vim.opt.cursorline = true
-- vim.opt.confirm = true

vim.opt.ignorecase = true

local space = "·"
vim.opt.list = true
vim.opt.listchars:append({
    -- tab = "⇥", -- this one conflicts with plugins for indent line
    eol = "↵",
    multispace = space,
    lead = space,
    trail = space,
    nbsp = space,
})

vim.opt.smoothscroll = true

-- Folding
vim.opt.foldlevel = 99
vim.opt.foldcolumn = "0"
vim.wo.foldnestmax = 4
vim.wo.foldminlines = 1
vim.opt.foldenable = false
vim.opt.foldlevelstart = 1
vim.opt.foldtext =
    [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').' ... ' . '(' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.wo.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.fillchars = {
    vert = "│", -- alternatives ▕
    fold = " ",
    eob = " ", -- suppress ~ at EndOfBuffer
    diff = "╱", -- alternatives = ⣿ ░ ─
    msgsep = "‾",
    foldopen = "▾",
    foldsep = "│",
    foldclose = "▸",
}

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
