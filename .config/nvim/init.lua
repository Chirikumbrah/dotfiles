-- HELPERS {{{
local r = require

local function km(mode, key, func, desc)
    vim.keymap.set(mode, key, func, { desc = desc, silent = true })
end
-- }}}

-- GLOBALS {{{
vim.g.mapleader = " "
vim.g.matchparen_insert_timeout = 20
vim.g.matchparen_timeout = 20 -- https://vi.stackexchange.com/a/5318/7339

-- stylua: ignore start
for _, plugin in ipairs({
    "2html", "getscript", "getscriptPlugin", "gzip", "logipat", "man", "netrw",
    "netrwFileHandlers", "netrwPlugin", "netrwSettings", "remote_plugins",
    "rrhelper", "spellfile_plugin", "tar", "tarPlugin", "tutor",
    "tutor_mode_plugin", "vimball", "vimballPlugin", "zip", "zipPlugin",
}) do
    vim.g["loaded_" .. plugin] = 1
end
-- stylua: ignore end
-- }}}

-- COLORSCHEME {{{
vim.cmd.colorscheme("habamax")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#3f3f3f", bg = "none" })
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
r("mini.deps").setup({ path = { package = path_package } })

---@diagnostic disable-next-line: undefined-global
local add, later, now = MiniDeps.add, MiniDeps.later, MiniDeps.now
-- }}}

-- OPTIONS {{{
vim.opt.autoread = true
vim.opt.colorcolumn = "100"
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.foldmethod = "marker"
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.number = true
vim.opt.path:append("**")
vim.opt.iskeyword:append("-")
vim.opt.scrolloff = 8
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.smoothscroll = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 50
-- }}}

-- EXPLICIT LOAD {{{
now(function()
    -- AUTOCOMMANDS {{{
    local group = vim.api.nvim_create_augroup("own", { clear = true })

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        group = group,
        pattern = { "*/templates/*.y*ml", "*/templates/*.tpl", "Chart.y*ml" },
        command = "set filetype=helm",
    })

    vim.api.nvim_create_autocmd("TextYankPost", { -- Highlight on yank
        group = group,
        callback = function()
            vim.highlight.on_yank({ higroup = "Visual", timeout = 400 })
        end,
    })

    vim.api.nvim_create_autocmd("FileType", { -- close quickfix/locations list
        group = group,
        pattern = { "qf", "help" },
        callback = function()
            local wi = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
            local close
            if vim.bo.filetype == "help" then
                close = ":q<CR>" -- close help window
            else
                close = wi.loclist == 1 and ":lclose<CR>" or ":cclose<CR>"
            end
            km("n", "<CR>", "<CR>" .. close, "") -- <CR>: select -> close
            km("n", "q", close, "") -- q and <Esc>: just close
            km("n", "<Esc>", close, "")
        end,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            if client:supports_method("textDocument/completion") then
                -- stylua: ignore start
                local vc = vim.lsp.completion
                vc.enable(true, client.id, ev.buf, { autotrigger = true })
                vim.opt.completeopt = { "menu", "menuone", "noinsert",
                    "popup", "fuzzy" }
                km("i", "<C-Space>", function() vc.get() end)
                -- stylua: ignore end
            end
        end,
    })
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

    add({
        source = "nvim-treesitter/nvim-treesitter",
        hooks = {
            post_checkout = function()
                vim.cmd("TSUpdate")
            end,
        },
    })
    r("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = {
            enable = true,
            ---@diagnostic disable-next-line: unused-local
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
-- }}}

-- LAZY LOAD {{{
later(function()
    -- PLUGINS {{{
    -- stylua: ignore start
    add({ source = "stevearc/conform.nvim" })
    add({ source = "olexsmir/gopher.nvim" })
    add({ source = "folke/zen-mode.nvim" })
    add({ source = "ibhagwan/fzf-lua" })
    -- add({ source = "saghen/blink.cmp",
    -- depends = { "rafamadriz/friendly-snippets" }, })
    -- stylua: ignore end

    -- stylua: ignore start
    -- r("blink.cmp").setup({ completion = { menu = { draw = {
    --     columns={ {"label","label_description","kind",gap=1} } } } },
    --     fuzzy = { implementation = "lua" }, signature = { enabled = true }})
    -- stylua: ignore end

    r("conform").setup({
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

    r("gopher").setup({ gotag = { transform = "camelcase" } })

    r("mini.clue").setup({
        triggers = {
            { mode = "n", keys = "<Leader>" }, -- Leader triggers
            { mode = "x", keys = "<Leader>" },
            { mode = "i", keys = "<C-x>" }, -- Built-in completion
            { mode = "n", keys = "g" }, -- `g` key
            { mode = "x", keys = "g" },
            { mode = "n", keys = "'" }, -- Marks
            { mode = "n", keys = "`" },
            { mode = "x", keys = "'" },
            { mode = "x", keys = "`" },
            { mode = "n", keys = '"' }, -- Registers
            { mode = "x", keys = '"' },
            { mode = "i", keys = "<C-r>" },
            { mode = "c", keys = "<C-r>" },
            { mode = "n", keys = "<C-w>" }, -- Window commands
            { mode = "n", keys = "z" }, -- `z` key
            { mode = "x", keys = "z" },
            { mode = "n", keys = "s" }, -- Surrounding
            { mode = "x", keys = "s" },
            { mode = "n", keys = "[" }, -- `[` and `]` key
            { mode = "n", keys = "]" },
            { mode = "x", keys = "[" },
            { mode = "x", keys = "]" },
        },

        clues = {
            r("mini.clue").gen_clues.builtin_completion(),
            r("mini.clue").gen_clues.g(),
            r("mini.clue").gen_clues.marks(),
            r("mini.clue").gen_clues.registers(),
            r("mini.clue").gen_clues.windows(),
            r("mini.clue").gen_clues.z(),
            { mode = "n", keys = "<Leader>f", desc = "+ Find" },
        },
        window = { delay = 300, config = { width = "auto" } },
    })

    r("mini.hipatterns").setup({
        highlighters = {
            todo = {
                pattern = "%f[%w]()TODO()%f[%W]",
                group = "MiniHipatternsTodo",
            },
            hex_color = r("mini.hipatterns").gen_highlighter.hex_color(),
        },
    })

    r("mini.files").setup()
    r("mini.diff").setup()
    r("mini.surround").setup()
    -- }}}

    -- KEYMAPS {{{
    km("n", "<ESC>", vim.cmd.noh, "Clear highlight")
    km({ "n", "v" }, "<leader>y", '"+y', 'Copy to "+')
    km({ "n", "v" }, "<leader>p", '"+p', 'Paste after from "+')
    km({ "n", "v" }, "<leader>P", '"+P', 'Paste before from "+')
    km("n", "<leader>s", vim.lsp.buf.document_symbol, "LSP symbols")
    -- stylua: ignore start
    for _, v in ipairs({ { "]d", 1, "Next" }, { "[d", -1, "Previous" } }) do
        km("n", v[1], function()
            vim.diagnostic.jump({ count = v[2], float = { border = "bold" } })
        end, v[3] .. " diagnostic") end
    km("n", "<leader>=", function() r("conform").format({ async = true, lsp_format = "fallback" })
    end, "Format")
    km("n", "<leader>t", [[<cmd>%s/\s\+$//e | noh<cr>]], "Trim whitespace")

    local fzf = r("fzf-lua")
    km("n", "<Leader>S", function() fzf.lsp_live_workspace_symbols() end, "LSP workspace symbols")
    km("n", "<Leader>d", function() fzf.lsp_workspace_diagnostics() end, "Diagnostics")
    km("n", "<Leader>b", function() fzf.buffers() end, "Buffers")
    km("n", "<Leader>h", function() fzf.helptags() end, "Help")
    km("n", "<Leader>f", function() fzf.files() end, "Files")
    km("n", "<Leader>/", function() fzf.live_grep() end, "Live grep")
    km("n", "<Leader>w", function() fzf.grep_cword() end, "Grep cword")
    km("n", "<Leader>W", function() fzf.grep_cWORD() end, "Grep cWORD")

    km("n", "<leader>e", function() r("mini.files").open() end, "Explorer")
    km("n", "<leader>o", r("mini.diff").toggle_overlay, "Toggle diff")
    km("n", "<leader>z", function() r("zen-mode").toggle() end, "Toggle Zen")
    -- }}}
end)
-- }}}
