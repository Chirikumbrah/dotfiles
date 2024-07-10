vim.opt.cursorline = true
vim.opt.ignorecase = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = true

vim.opt.smartindent = true
vim.opt.path:append("**")
vim.opt.wildmenu = true

-- https://vi.stackexchange.com/a/5318/7339
vim.g.matchparen_timeout = 20
vim.g.matchparen_insert_timeout = 20

vim.opt.laststatus = 3

vim.opt.termguicolors = true
vim.opt.incsearch = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smoothscroll = true

vim.opt.updatetime = 50

-- Improve the file browser
vim.g.netrw_banner = false
vim.g.netrw_altv = true -- open splits to the right
vim.g.netrw_preview = true -- preview split to the right
vim.g.netrw_liststyle = 3 -- tree view

local space = "·"
vim.opt.list = false
vim.opt.listchars:append({
    -- tab = "⇥", -- this one conflicts with plugins for indent line
    eol = "↵",
    multispace = space,
    lead = space,
    trail = space,
    nbsp = space,
})

-- Folding
vim.opt.foldlevel = 99
vim.opt.foldcolumn = "0"
vim.wo.foldminlines = 1
vim.opt.foldenable = false
vim.opt.foldlevelstart = 1
vim.g.markdown_folding = 1
vim.opt.foldtext =
    [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').' ... ' . '(' . (v:foldend - v:foldstart + 1) . ' lines)']]
if vim.fn.has("nvim-0.10") == 1 then
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldmethod = "expr"
else
    vim.opt.foldmethod = "indent"
end
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
vim.g.mkdp_browser = "Brave Browser"
