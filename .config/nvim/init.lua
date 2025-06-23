-- HELPERS {{{
local r = require

local function map(mode, key, func, desc)
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
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
-- }}}

-- OPTIONS {{{
vim.opt.colorcolumn = "80"
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.foldmethod = "marker"
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.number = true
vim.opt.path:append("**")
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
    r("mini.completion").setup()
end)
-- }}}

-- LAZY LOAD {{{
later(function()
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

    -- PLUGINS {{{
    add({
        source = "nvim-treesitter/nvim-treesitter",
        -- stylua: ignore start
        hooks = { post_checkout = function() vim.cmd("TSUpdate") end },
        -- stylua: ignore end
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

    add({ source = "stevearc/conform.nvim" })
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

    add({ source = "olexsmir/gopher.nvim" })
    r("gopher").setup({ gotag = { transform = "camelcase" } })

    add({ source = "folke/zen-mode.nvim" })

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

    r("mini.snippets").setup()
    r("mini.files").setup()
    r("mini.diff").setup()
    r("mini.pick").setup()
    r("mini.surround").setup()
    -- }}}

    -- KEYMAPS {{{
    map("n", "<ESC>", vim.cmd.noh, "Clear highlight")
    map({ "n", "v" }, "<leader>y", '"+y', 'Copy to "+')
    map({ "n", "v" }, "<leader>p", '"+p', 'Paste after from "+')
    map({ "n", "v" }, "<leader>P", '"+P', 'Paste before from "+')
    map("n", "<leader>d", vim.diagnostic.setqflist, "Diagnostics")
    map("n", "<leader>S", vim.lsp.buf.document_symbol, "LSP symbols")
    map("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = { border = "bold" } })
    end, "Next diagnostic")
    map("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = { border = "bold" } })
    end, "Previous diagnostic")
    map("n", "<leader>=", function()
        r("conform").format({ async = true, lsp_format = "fallback" })
    end, "Format")
    map("n", "<leader>t", [[<cmd>%s/\s\+$//e | noh<cr>]], "Trim whitespace")
    -- stylua: ignore start
    map("n", "<Leader>f", function()
        r("mini.pick").builtin.cli({ command = { "rg", "--files", "--hidden",
            "--no-follow", "--color=never", "--glob", "!.git/*",
            "--glob", "!node_modules/*", "--glob", "!vendor/*", }})
    end, "Files")
    map("n", "<Leader>b", "<CMD>Pick buffers<CR>", "Buffers")
    map("n", "<Leader>/", "<CMD>Pick grep_live<CR>", "Live grep")
    map("n", "<Leader>g", "<CMD>Pick grep<CR>", "Grep")
    map("n", "<Leader>h", "<CMD>Pick help<CR>", "Help")
    map("n", "<leader>w", "<CMD>Pick grep pattern='<cword>'<CR>", "Grep cword")
    map("n", "<leader>W", "<CMD>Pick grep pattern='<cWORD>'<CR>", "Grep cWORD")
    map("n", "<leader>e", function() r("mini.files").open() end, "Explorer")
    map("n", "<leader>o", r("mini.diff").toggle_overlay, "Toggle diff")
    map("n", "<leader>z", function() r("zen-mode").toggle() end, "Toggle Zen")
    -- stylua: ignore end
    -- }}}

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
            map("n", "<CR>", "<CR>" .. close, "") -- <CR>: select -> close
            map("n", "q", close, "") -- q and <Esc>: just close
            map("n", "<Esc>", close, "")
        end,
    })
    -- }}}
end)
-- }}}
