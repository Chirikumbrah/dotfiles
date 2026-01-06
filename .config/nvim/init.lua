-- HELPERS {{{
vim.g.mapleader = " "
local function km(mode, key, func, desc)
    vim.keymap.set(mode, key, func, { desc = desc, silent = true })
end
-- }}}

-- OPTIONS {{{
vim.o.autoread = true
vim.o.colorcolumn = "100"
vim.o.cursorcolumn = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.foldmethod = "marker"
vim.o.incsearch = true
vim.o.list = true
vim.o.number = true
-- vim.o.iskeyword:append("-")
vim.o.scrolloff = 8
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.signcolumn = "yes"
vim.o.smartindent = true
vim.o.smoothscroll = true
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.updatetime = 50
vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.opt.path:append("**")
-- }}}

-- COLORSCHEME {{{
vim.cmd.colorscheme("habamax")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#3f3f3f", bg = "none" })
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

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method("textDocument/completion") then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            local chars = {}
            for i = 32, 126 do
                table.insert(chars, string.char(i))
            end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})

vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
    { src = "https://github.com/nvim-mini/mini.files" },
    { src = "https://github.com/nvim-mini/mini.diff" },
    { src = "https://github.com/nvim-mini/mini.surround" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/olexsmir/gopher.nvim" },
    { src = "https://github.com/folke/zen-mode.nvim" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/folke/which-key.nvim" },
})


-- LSP {{{
-- stylua: ignore start
vim.lsp.enable({
    "luals", "clangd", "gopls", "ruff", "pyright", "bashls", "terraformlsp", "terraformls",
    "helmls", "yamlls", "jsonls", "marksman", "dockerls"
})
-- stylua: ignore end
vim.diagnostic.config({ virtual_text = false, severity_sort = true })
-- }}}

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function()
        require("nvim-treesitter").update()
    end,
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

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

-- stylua: ignore start
require("which-key").setup({ preset = "helix", icons = { mappings = false },
    spec = { { "gr", group = "+LSP/fzf-lua" } },
})

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
