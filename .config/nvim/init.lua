-- HELPERS {{{
vim.g.mapleader = " "
local function km(mode, key, func, desc)
    vim.keymap.set(mode, key, func, { desc = desc, silent = true })
end
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
-- vim.opt.iskeyword:append("-")
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
require("mini.deps").setup({ path = { package = path_package } })

---@diagnostic disable-next-line: undefined-global
local add, later, now = MiniDeps.add, MiniDeps.later, MiniDeps.now
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
            vim.highlight.on_yank({ timeout = 400, visual = true })
        end,
    })

    vim.api.nvim_create_autocmd("BufReadPost", { -- restore cursor last position
        callback = function(args)
            local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
            local line_count = vim.api.nvim_buf_line_count(args.buf)
            if mark[1] > 0 and mark[1] <= line_count then
                vim.api.nvim_win_set_cursor(0, mark)
                vim.schedule(function()
                    vim.cmd("normal! zz")
                end)
            end
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

    -- }}}

    -- LSP {{{
    -- stylua: ignore start
    vim.lsp.enable({
        "luals", "clangd", "gopls", "ruff", "pyright", "bashls", "terraformlsp", "terraformls",
        "helmls", "yamlls", "jsonls", "marksman", "dockerls"
    })
    -- stylua: ignore end
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
    require("nvim-treesitter.configs").setup({
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
    add({ source = "saghen/blink.cmp",
        depends = { "rafamadriz/friendly-snippets" }, })
    add({ source = "stevearc/conform.nvim" })
    add({ source = "olexsmir/gopher.nvim" })
    add({ source = "folke/zen-mode.nvim" })
    add({ source = "ibhagwan/fzf-lua" })
    add({ source = "folke/which-key.nvim" })
    -- stylua: ignore end

    -- stylua: ignore start
    require("which-key").setup({ preset = "helix", icons = { mappings = false },
        spec = { { "gr", group = "+LSP/fzf-lua" } },
    })

    require("blink.cmp").setup({ completion = { menu = { draw = {
        columns={{"label","label_description","kind",gap=1}}}}},
        fuzzy = { implementation = "lua" }, signature = { enabled = true }})
    -- stylua: ignore end

    require("conform").setup({
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
            prettier = {
                options = { ft_parsers = { yaml = "yaml" } },
                prepend_args = { "--tab-width", "2", "--no-semi", "--use-tabs=false", "$FILENAME" },
            },
        },
    })

    require("gopher").setup({ gotag = { transform = "camelcase" } })

    require("mini.files").setup()
    require("mini.diff").setup()
    require("mini.surround").setup()
    -- }}}

    -- KEYMAPS {{{
    km({ "n", "v" }, "<leader>y", '"+y', 'Copy to "+')
    km({ "n", "v" }, "<leader>p", '"+p', 'Paste after from "+')
    km({ "n", "v" }, "<leader>P", '"+P', 'Paste before from "+')
    for _, v in ipairs({ { "]d", 1, "Next" }, { "[d", -1, "Previous" } }) do
        km("n", v[1], function()
            vim.diagnostic.jump({ count = v[2], float = { border = "bold" } })
        end, v[3] .. " diagnostic")
    end
    km("n", "<leader>=", function()
        require("conform").format({ async = true, timeout = 500, lsp_format = "fallback" })
    end, "Format buffer")
    -- km("n", "<leader>=", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
    km("n", "<leader>t", [[<cmd>%s/\s\+$//e | noh<cr>]], "Trim whitespace")

    local fzf = require("fzf-lua")
    km("n", "grr", fzf.lsp_references, "LSP references")
    km("n", "<leader>s", fzf.lsp_document_symbols, "LSP symbols")
    km("n", "<Leader>S", fzf.lsp_live_workspace_symbols, "LSP workspace symbols")
    km("n", "<Leader>d", fzf.lsp_workspace_diagnostics, "Diagnostics")
    km("n", "<Leader>h", fzf.helptags, "Help")
    km("n", "<Leader>f", fzf.files, "Files")
    km("n", "<Leader>/", fzf.live_grep, "Live grep")
    km("n", "<Leader>w", fzf.grep_cword, "Grep cword")
    km("n", "<Leader>W", fzf.grep_cWORD, "Grep cWORD")

    km("n", "<leader>e", require("mini.files").open, "Explorer")
    km("n", "<leader>z", require("zen-mode").toggle, "Toggle Zen")
    -- }}}
end)
-- }}}
