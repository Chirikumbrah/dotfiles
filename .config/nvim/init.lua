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
-- }}}

-- OPTIMIZATIONS {{{
local disabled_built_ins = {
    "2html",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "man",
    "netrw",
    "netrwFileHandlers",
    "netrwPlugin",
    "netrwSettings",
    "remote_plugins",
    "rrhelper",
    "spellfile_plugin",
    "tar",
    "tarPlugin",
    "tutor",
    "tutor_mode_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end
-- }}}

-- COLORSCHEME {{{
vim.cmd.colorscheme("habamax")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#3f3f3f", bg = "none" })
-- }}}

-- KEYMAPS {{{
local function map(mode, key, func, desc)
    vim.keymap.set(mode, key, func, { desc = desc, silent = true })
end

map("n", "<ESC>", vim.cmd.noh, "Clear highlight")
map({ "n", "v" }, "<leader>y", '"+y', 'Copy to "+')
map({ "n", "v" }, "<leader>p", '"+p', 'Paste after from "+')
map({ "n", "v" }, "<leader>P", '"+P', 'Paste before from "+')
map("n", "<leader>t", [[<cmd>%s/\s\+$//e | noh<cr>]], "Trim whitespace")

map("n", "<leader>d", vim.diagnostic.setqflist, "Show diagnostics")
map("n", "<leader>S", vim.lsp.buf.document_symbol, "Show LSP symbols")
map("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = { border = "bold" } })
end, "Jump to next diagnostic")

map("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = { border = "bold" } })
end, "Jump to previous diagnostic")
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
vim.diagnostic.config({ virtual_text = false, severity_sort = true })
-- }}}

-- AUTOCOMMANDS {{{
local augroup = vim.api.nvim_create_augroup("yutocommands", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup,
    pattern = { "*/templates/*.y*ml", "*/templates/*.tpl", "Chart.y*ml" },
    command = "set filetype=helm",
})
vim.api.nvim_create_autocmd("TextYankPost", { -- Highlight on yank
    group = augroup,
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 400 })
    end,
})

-- close quickfix menu after selecting choice
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "qf" },
    callback = function()
        local wininfo = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
        if wininfo.loclist == 1 then
            map("n", "<CR>", "<CR>:lclose<CR>", "")
        else
            map("n", "<CR>", "<CR>:cclose<CR>", "")
        end
    end,
})
-- close quickfix on q or ESC
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        local wininfo = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
        if wininfo.loclist == 1 then -- It's a Location List window
            map("n", "q", ":lclose<CR>", "")
            map("n", "<Esc>", ":lclose<CR>", "")
        else
            map("n", "q", ":cclose<CR>", "")
            map("n", "<Esc>", ":cclose<CR>", "")
        end
    end,
})
-- }}}

-- mini.deps {{{
-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    -- stylua: ignore start
    local clone_cmd = { "git", "clone", "--filter=blob:none",
        "https://github.com/echasnovski/mini.nvim", mini_path }
    -- stylua: ignore end
    vim.fn.system(clone_cmd)
    vim.cmd("packadd mini.nvim | helptags ALL")
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })

-- helpers
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
-- }}}

-- mini.clue {{{
later(function()
    local c = require("mini.clue")
    c.setup({
        triggers = {
            -- Leader triggers
            { mode = "n", keys = "<Leader>" },
            { mode = "x", keys = "<Leader>" },

            -- Built-in completion
            { mode = "i", keys = "<C-x>" },

            -- `g` key
            { mode = "n", keys = "g" },
            { mode = "x", keys = "g" },

            -- Marks
            { mode = "n", keys = "'" },
            { mode = "n", keys = "`" },
            { mode = "x", keys = "'" },
            { mode = "x", keys = "`" },

            -- Registers
            { mode = "n", keys = '"' },
            { mode = "x", keys = '"' },
            { mode = "i", keys = "<C-r>" },
            { mode = "c", keys = "<C-r>" },

            -- Window commands
            { mode = "n", keys = "<C-w>" },

            -- `z` key
            { mode = "n", keys = "z" },
            { mode = "x", keys = "z" },

            -- Surrounding
            { mode = "n", keys = "s" },
            { mode = "x", keys = "s" },

            -- `[` and `]` key
            { mode = "n", keys = "[" },
            { mode = "n", keys = "]" },
            { mode = "x", keys = "[" },
            { mode = "x", keys = "]" },
        },

        clues = {
            -- Enhance this by adding descriptions for <Leader> mapping groups
            c.gen_clues.builtin_completion(),
            c.gen_clues.g(),
            c.gen_clues.marks(),
            c.gen_clues.registers(),
            c.gen_clues.windows(),
            c.gen_clues.z(),
            { mode = "n", keys = "<Leader>f", desc = "+ Find" },
        },
        window = { delay = 300, config = { width = "auto" } },
    })
end)
-- }}}

-- mini.surround {{{
later(function()
    require("mini.surround").setup({ highlight_duration = 1000 })
end)
-- }}}

-- mini.files {{{
later(function()
    local files = require("mini.files")
    files.setup()
    -- stylua: ignore start
    map("n", "<leader>e", function() files.open() end, "File browser")
    -- stylua: ignore end
end)
-- }}}

-- Treesitter {{{
later(function()
    add({
        source = "nvim-treesitter/nvim-treesitter",
        -- run update after checkout
        -- stylua: ignore start
        hooks = { post_checkout = function() vim.cmd("TSUpdate") end },
        -- stylua: ignore end
    })
    require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = {
            enable = true,
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local buf_name = vim.api.nvim_buf_get_name(buf)
                local ok, stats = pcall(vim.loop.fs_stat, buf_name)
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
        },
    })
end)
--}}}

-- conform.nvim {{{
later(function()
    add({ source = "stevearc/conform.nvim" })
    local conform = require("conform")
    conform.setup({
        formatters_by_ft = {
            css = { "prettier" },
            go = { "goimports", "gofmt" },
            graphql = { "prettier" },
            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            json = { "prettier" },
            lua = { "stylua" },
            markdown = { "prettier" },
            python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
            sh = { "beautysh" },
            zsh = { "beautysh" },
            toml = { "taplo" },
            terraform = { "terraform_fmt" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            yaml = { "prettier" },
        },
        formatters = {
            shfmt = { prepend_args = { "-i", "4", "-ci" } },
            stylua = { prepend_args = { "--indent-type", "Spaces" } },
        },
    })
    map("n", "<leader>=", function()
        conform.format({ async = true, lsp_format = "fallback" })
    end, "Format buffer")
end)
--}}}

-- blink.cmp {{{
later(function()
    add({
        source = "saghen/blink.cmp",
        depends = { "rafamadriz/friendly-snippets" },
        checkout = "1.*",
    })
    -- stylua: ignore start
    require("blink.cmp").setup({
        fuzzy = { implementation = "lua" },
        completion = { menu = { draw = { columns = {
                { "label", "label_description", "kind", gap = 1 } } } } },
        signature = { enabled = true },
    })
    -- stylua: ignore end
end)

-- }}}

-- colorizer.nvim {{{
now(function()
    add({ source = "norcalli/nvim-colorizer.lua" })
    require("colorizer").setup()
end)
-- }}}

-- gopher.nvim {{{
later(function()
    add({ source = "olexsmir/gopher.nvim" })
    require("gopher").setup({ gotag = { transform = "camelcase" } })
end)
-- }}}

-- mini.diff {{{
later(function()
    local g = require("mini.diff")
    g.setup()
    map("n", "<leader>o", g.toggle_overlay, "Togge Diff overlay")
end)
-- }}}

-- zen-mode {{{
later(function()
    add({ source = "folke/zen-mode.nvim" })
    local z = require("zen-mode")
    map("n", "<leader>z", function()
        z.toggle()
    end, "Toggle Zen")
end)
-- }}}

-- mini.pick {{{
later(function()
    local pick = require("mini.pick")
    pick.setup({})

    local function grep_cword()
        local word = vim.fn.expand("<cword>")
        pick.builtin.grep({ pattern = word })
    end

    local function grep_cWORD()
        local WORD = vim.fn.expand("<cWORD>")
        pick.builtin.grep({ pattern = WORD })
    end

    map("n", "<Leader>f", "<CMD>Pick files<CR>", "Find files")
    map("n", "<Leader>b", "<CMD>Pick buffers<CR>", "Find buffer")
    map("n", "<Leader>/", "<CMD>Pick grep_live<CR>", "Live grep")
    map("n", "<Leader>g", "<CMD>Pick grep<CR>", "Grep")
    map("n", "<Leader>h", "<CMD>Pick help<CR>", "Find help")
    map("n", "<leader>W", grep_cWORD, "Search current WORD")
    map("n", "<leader>w", grep_cword, "Search current word")
end)
-- }}}

-- startup time measure {{{
local start_time = vim.fn.reltime()
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local elapsed = vim.fn.reltimefloat(vim.fn.reltime(start_time))
        print(string.format("Startup time: %.3f ms", elapsed * 1000))
    end,
})
-- }}}
