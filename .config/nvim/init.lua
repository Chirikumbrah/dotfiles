-- OPTIONS --
vim.g.mapleader = " "
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.number = true
vim.opt.path:append("**")
vim.g.matchparen_timeout = 20 -- https://vi.stackexchange.com/a/5318/7339
vim.g.matchparen_insert_timeout = 20
vim.opt.termguicolors = true
vim.opt.incsearch = true
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

-- COLORSCHEME --
vim.cmd.colorscheme("habamax")

-- KEYMAPS --
vim.keymap.set("n", "<ESC>", vim.cmd.noh, { desc = "Clear highlight" })
vim.keymap.set("n", "<leader>e", "<cmd>25Lexplore<CR>", { desc = "Open file browser" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste after from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste before from system clipboard" })
vim.keymap.set("n", "<leader>t", [[<cmd>split | term<cr>A]], { desc = "Open terminal in horizontal split" })
vim.keymap.set("n", "<leader><BS>", [[<cmd>%s/\s\+$//e<cr><cmd>noh<cr>]], { desc = "Remove trailing whitespace" })
vim.keymap.set("t", "<leader><ESC>", "<C-\\><C-n>", { desc = "Enter normal mode in terminal" })

-- AUTOCOMMANDS --
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { -- Detect Helm templates as helm filetype
    pattern = { "*/templates/*.y*ml", "*/templates/*.tpl" },
    command = "set filetype=helm",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { -- Detect *.conf as nginx filetype
    pattern = { "*.conf" },
    command = "set filetype=nginx",
})
vim.api.nvim_create_autocmd("BufReadPost", { -- Restore cursor position
    command = 'silent! normal! g`"zv',
})
vim.api.nvim_create_autocmd("TextYankPost", { -- Highlight on yank
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 400 })
    end,
})

-- LAZY --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
    change_detection = { notify = false },
    performance = { rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } } },
})
