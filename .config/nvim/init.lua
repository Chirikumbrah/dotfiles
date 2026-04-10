-- OPTIONS
vim.g.mapleader = " "
vim.g.undotree_WindowLayout = 4
vim.g.undotree_shortIndicators = 1
vim.g.undotree_SetFocusWhenToggle = 1
vim.opt.autoread = true
vim.opt.colorcolumn = "100"
vim.opt.confirm = true
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.grepprg = "rg --vimgrep --no-messages --smart-case"
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.number = true
vim.opt.path:append("**")
vim.opt.scrolloff = 8
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smoothscroll = true
vim.opt.softtabstop = 4
vim.opt.statusline = "[%n] %<%f %h%w%m%r%=%-14.(%l,%c%V%) %P"
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.wildoptions:append({ "fuzzy" })
vim.opt.winborder = "bold"
vim.opt.complete = "o,.,w,b,u,t"
vim.opt.completeopt = "menu,menuone,popup,fuzzy,noinsert"

-- COLORSCHEME
vim.cmd.colorscheme("habamax")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#3f3f3f", bg = "none" })

-- LSP
vim.lsp.enable({
    "basedpyright", "bashls", "clangd", "dockerls", "gopls", "helm_ls", "jsonls", "lua_ls",
    "marksman", "ruff", "terraformls", "terraform_lsp", "yamlls",
})

-- PLUGINS
vim.pack.add({
    { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/olexsmir/gopher.nvim" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-mini/mini.files" },
    { src = "https://github.com/nvim-mini/mini.diff" },
})

vim.cmd.packadd("nvim.undotree")

require("tree-sitter-manager").setup({
    ensure_installed = { "dockerfile", "bash", "lua", "python", "go", "javascript", "json", "yaml",
        "terraform", "helm" }
})

require("which-key").setup({ preset = "helix", icons = { mappings = false } })

-- KEYMAPS
local function km(m, k, f, d) vim.keymap.set(m, k, f, { desc = d, silent = true }) end

km({ "n", "v" }, "<leader>y", '"+y', 'Copy to "+')
km({ "n", "v" }, "<leader>p", '"+p', 'Paste after from "+')
km({ "n", "v" }, "<leader>P", '"+P', 'Paste before from "+')
km({ "n", "v" }, "<leader>u", vim.cmd.Undotree, "Undotree")
km("n", "<leader>=", function()
    require("conform").setup({
        formatters_by_ft = {
            css = { "prettier" },
            go = { "goimports", "gofmt" },
            graphql = { "prettier" },
            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            json = { "prettier" },
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
            prettier = {
                options = { ft_parsers = { yaml = "yaml" } },
                prepend_args = { "--tab-width", "2", "--no-semi", "--use-tabs=false", "$FILENAME" },
            },
        },
    })
    require("conform").format({ async = true, timeout = 500, lsp_format = "fallback" })
end, "Format buffer")
km("n", "<leader>t", [[<cmd>%s/\s\+$//e | noh<cr>]], "Trim whitespace")

km("n", "<leader>s", require("fzf-lua").lsp_document_symbols, "LSP symbols")
km("n", "<Leader>S", require("fzf-lua").lsp_live_workspace_symbols, "LSP workspace symbols")
km("n", "<Leader>d", require("fzf-lua").lsp_workspace_diagnostics, "Diagnostics")
km("n", "<Leader>h", require("fzf-lua").helptags, "Help")
km("n", "<Leader><leader>", require("fzf-lua").files, "Files")
-- km("n", "<Leader>b", require("fzf-lua").buffers, "Buffers")
km("n", "<Leader>/", require("fzf-lua").live_grep, "Live grep")
km("n", "<Leader>w", require("fzf-lua").grep_cword, "Grep cword")
km("n", "<Leader>W", require("fzf-lua").grep_cWORD, "Grep cWORD")

km("n", "<leader>e", require("mini.files").open, "Explorer")

-- AUTOCOMMANDS
local ac = vim.api.nvim_create_autocmd
ac({ "BufRead", "BufNewFile" }, {
    pattern = { "*/templates/*.y*ml", "*/templates/*.tpl", "Chart.y*ml" },
    command = "set filetype=helm",
})

ac("TextYankPost", { callback = function() vim.hl.on_yank({ timeout = 400 }) end, })

ac("FileType", {
    callback = function()
        if vim.bo.filetype == "go" then require("gopher").setup({ gotag = { transform = "camelcase" } }) end
    end
})

ac("BufReadPost", { callback = function() require("mini.diff").setup() end })
