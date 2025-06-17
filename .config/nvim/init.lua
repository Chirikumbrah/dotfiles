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
-- vim.g.netrw_banner = false
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
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#5f5f5f", bg = "none" })
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

-- mini.deps {{{
-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/echasnovski/mini.nvim",
        mini_path,
    }
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
    require("mini.clue").setup({
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

            -- `[` and `]` key
            { mode = "n", keys = "[" },
            { mode = "n", keys = "]" },
            { mode = "x", keys = "[" },
            { mode = "x", keys = "]" },
        },

        clues = {
            -- Enhance this by adding descriptions for <Leader> mapping groups
            require("mini.clue").gen_clues.builtin_completion(),
            require("mini.clue").gen_clues.g(),
            require("mini.clue").gen_clues.marks(),
            require("mini.clue").gen_clues.registers(),
            require("mini.clue").gen_clues.windows(),
            require("mini.clue").gen_clues.z(),
            { mode = "n", keys = "<Leader>f", desc = "+ Find" },
        },
        window = {
            delay = 300,
            config = { width = "auto" },
        },
    })
end)
-- }}}

-- mini.pick {{{
later(function()
    local pick = require("mini.pick")
    pick.setup({})
    require("mini.fuzzy").setup()

    local function grep_cword()
        local word = vim.fn.expand("<cword>")
        pick.builtin.grep({ pattern = word })
    end

    local function grep_cWORD()
        local WORD = vim.fn.expand("<cWORD>")
        pick.builtin.grep({ pattern = WORD })
    end

    vim.keymap.set("n", "<Leader>f", ":Pick files<CR>", { desc = "Find Files", silent = true })
    vim.keymap.set("n", "<Leader>b", ":Pick buffers<CR>", { desc = "Find Buffer", silent = true })
    vim.keymap.set("n", "<leader>w", grep_cword, { desc = "Search word under cursor", silent = true })
    vim.keymap.set("n", "<leader>W", grep_cWORD, { desc = "Search WORD under cursor", silent = true })
end)
-- }}}

-- mini.files {{{
later(function()
    local files = require("mini.files")
    files.setup()

    vim.keymap.set("n", "<leader>e", function()
        files.open()
    end, { desc = "File browser" })
end)
-- }}}

-- Treesitter {{{
later(function()
    add({
        source = "nvim-treesitter/nvim-treesitter",
        -- run update after checkout
        hooks = {
            post_checkout = function()
                vim.cmd("TSUpdate")
            end,
        },
    })
    require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = {
            enable = true,
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
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
    add({
        source = "stevearc/conform.nvim",
    })
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
            shfmt = {
                prepend_args = { "-i", "4", "-ci" },
            },
            stylua = {
                prepend_args = { "--indent-type", "Spaces" },
            },
        },
    })
    vim.keymap.set("n", "<leader>=", function()
        conform.format({ async = true, lsp_format = "fallback" })
    end, { desc = "Format buffer [conform]", silent = true })
end)
--}}}

-- blink.cmp {{{
later(function()
    add({
        source = "saghen/blink.cmp",
        depends = { "rafamadriz/friendly-snippets" },
        checkout = "1.*",
    })
    require("blink.cmp").setup({
        fuzzy = { implementation = "lua" },
        completion = {
            menu = {
                draw = {
                    columns = {
                        { "label", "label_description", "kind", gap = 1 },
                    },
                },
            },
        },
        signature = { enabled = true },
    })
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

-- gitsigns {{{
later(function()
    add({ source = "lewis6991/gitsigns.nvim" })
    local g = require("gitsigns")
    vim.keymap.set("n", "<leader>gn", function()
        g.next_hunk()
    end, { desc = "Go to next git hunk [gitsigns]" })
    vim.keymap.set("n", "<leader>gp", function()
        g.prev_hunk()
    end, { desc = "Go to previous git hunk [gitsigns]" })
    vim.keymap.set({ "n", "v" }, "<leader>gs", function()
        g.stage_hunk()
    end, { desc = "Stage hunk [gitsigns]" })
    vim.keymap.set("n", "<leader>gl", function()
        g.toggle_current_line_blame()
    end, { desc = "Toggle current line blame [gitsigns]" })
end)

-- }}}

-- zen-mode {{{
later(function()
    add({ source = "folke/zen-mode.nvim" })
    vim.keymap.set("n", "<leader>z", function()
        require("zen-mode").toggle()
    end, { desc = "Toggle zen mode" })
end)
-- }}}

-- fzf.lua {{{
-- later(function()
--     add({ source = "ibhagwan/fzf-lua" })
--     local f = require("fzf-lua")
--
--     vim.keymap.set("n", "<leader>/", function()
--         f.live_grep()
--     end, { desc = "Open live grep" })
--     vim.keymap.set("n", "<leader>h", function()
--         f.helptags()
--     end, { desc = "Open command picker" })
--     vim.keymap.set("n", "<leader>k", function()
--         f.keymaps()
--     end, { desc = "Open keymaps picker" })
--     vim.keymap.set("n", "<leader>S", function()
--         f.lsp_live_workspace_symbols()
--     end, { desc = "Open workspace symbols picker" })
--     vim.keymap.set("n", "<leader>W", function()
--         f.grep_cWORD()
--     end, { desc = "Search WORD under cursor" })
--     vim.keymap.set("n", "<leader>b", function()
--         f.buffers()
--     end, { desc = "Open buffer picker" })
--     vim.keymap.set("n", "<leader>d", function()
--         f.lsp_workspace_diagnostics()
--     end, { desc = "Open diagnostics picker" })
--     vim.keymap.set("n", "<leader>f", function()
--         f.files()
--     end, { desc = "Open file picker" })
--     vim.keymap.set("n", "<leader>o", function()
--         f.oldfiles()
--     end, { desc = "Open old files picker" })
--     vim.keymap.set("n", "<leader>s", function()
--         f.lsp_document_symbols()
--     end, { desc = "Open symbols picker" })
--     vim.keymap.set("n", "<leader>w", function()
--         f.grep_cword()
--     end, { desc = "Search word under cursor" })
--     vim.keymap.set("n", "gd", function()
--         f.lsp_definitions()
--     end, { desc = "Go to definition (jump if one, pick if multiple)" })
--     vim.keymap.set("n", "gri", function()
--         f.lsp_implementations()
--     end, { desc = "vim.lsp.buf.implementation() [fzf-lua]" })
--     vim.keymap.set("n", "grr", function()
--         f.lsp_references()
--     end, { desc = "vim.lsp.buf.references() [fzf-lua]" })
-- end)
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
