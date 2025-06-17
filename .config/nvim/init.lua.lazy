-- OPTIONS -- {{{
vim.g.mapleader = " "
vim.opt.foldmethod = "marker"
vim.opt.colorcolumn = "80"
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
vim.opt.list = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smoothscroll = true
vim.opt.updatetime = 50
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
-- vim.g.netrw_banner = false
-- }}}

-- COLORSCHEME {{{
vim.cmd.colorscheme("habamax")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- }}}

-- KEYMAPS {{{
vim.keymap.set("n", "<ESC>", vim.cmd.noh, { desc = "Clear highlight" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste after from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste before from system clipboard" })
vim.keymap.set("n", "<leader><BS>", [[<cmd>%s/\s\+$//e<cr><cmd>noh<cr>]], { desc = "Remove trailing whitespace" })
vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Jump to next diagnostic" })
vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Jump to previous diagnostic" })
-- vim.keymap.set("n", "<leader>e", "<cmd>25Lexplore<CR>", { desc = "Open file browser" })
-- vim.keymap.set("i", "<c-space>", function()
--     vim.lsp.completion.get()
-- end)
-- }}}

-- LSP {{{
vim.lsp.enable({
    "luals",
    "clangd",
    "gopls",
    "ruff",
    "pyright",
    "bashls",
    "dockerls",
    "terraformls",
    "helmls",
    "yamlls",
})
-- vim.diagnostic.config({ virtual_text = { current_line = true } })
vim.diagnostic.config({ virtual_text = false, severity_sort = true })
-- }}}

-- AUTOCOMMANDS {{{
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { -- Detect Helm templates as helm filetype
    pattern = { "*/templates/*.y*ml", "*/templates/*.tpl", "Chart.y*ml" },
    command = "set filetype=helm",
})
vim.api.nvim_create_autocmd("TextYankPost", { -- Highlight on yank
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 400 })
    end,
})
-- }}}

-- LAZY {{{
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
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "netrw",
                "zipPlugin",
            },
        },
    },
})
-- }}}
