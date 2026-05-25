-- OPTIONS
vim.g.mapleader = " "
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.grepprg = "grep -HRIn $* ."
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.number = true
vim.opt.path:append({ "**", ".*/**", "**/.*/**" })
vim.opt.iskeyword:append("-")
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smoothscroll = true
vim.opt.smoothscroll = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.wildoptions:append({ "fuzzy" })
vim.opt.winborder = "bold"
vim.opt.complete = "o,.,w,b,u,t"
vim.opt.completeopt = "menu,menuone,popup,fuzzy,noinsert"

vim.cmd.colorscheme("habamax")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#3f3f3f", bg = "none" })

vim.filetype.add({
    pattern = {
        [".*/templates/.*%.tpl"] = "helm",
        [".*/templates/.*%.ya?ml"] = "helm",
        ["helmfile.*%.ya?ml"] = "helm",
        [".*%.conf$"] = "nginx",
        [".*%.conf.tmpl"] = "nginx",
    },
})

vim.lsp.enable({ "basedpyright", "bashls", "clangd", "dockerls", "gopls", "helm_ls", "jsonls", "lua_ls", "marksman",
    "ruff", "terraformls", "tflint", "yamlls", })

vim.pack.add({
    { src = "https://github.com/neovim-treesitter/treesitter-parser-registry" },
    { src = "https://github.com/neovim-treesitter/nvim-treesitter" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/olexsmir/gopher.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-mini/mini.files" },
    { src = "https://github.com/nvim-mini/mini.diff" },
})

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = 'Copy to "+' })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = 'Paste after from "+' })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = 'Paste before from "+' })
vim.keymap.set({ "n", "v" }, "<leader>u", vim.cmd.Undotree, { desc = "Undotree" })
vim.keymap.set("n", "<leader>t", [[<cmd>%s/\s\+$//e | noh<cr>]], { desc = "Trim whitespace" })
vim.keymap.set("n", "<Leader>/", ":copen | :silent :grep ", { desc = "Grep" })
vim.keymap.set("n", "<leader>s", vim.lsp.buf.document_symbol, { desc = "LSP symbols" })
vim.keymap.set("n", "<Leader>S", vim.lsp.buf.workspace_symbol, { desc = "LSP workspace symbols" })
vim.keymap.set("n", "<Leader>d", function() vim.diagnostic.setloclist({ open = true }) end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>q", "<cmd>silent! ccl | silent! lcl<cr>", { desc = "Close qf/loc window" })
vim.keymap.set("n", "<Leader>g", require("mini.diff").toggle_overlay, { desc = "Show Diff" })
vim.keymap.set("n", "<leader>e", require("mini.files").open, { desc = "Explorer" })
vim.keymap.set("n", "<leader>=", function()
    require("conform").setup({
        formatters_by_ft = {
            css = { "prettier" },
            go = { "goimports", "gofmt" },
            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
            sh = { "beautysh" },
            zsh = { "beautysh" },
            toml = { "taplo" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
        },
        formatters = { shfmt = { prepend_args = { "-i", "4", "-ci" } } },
    })
    require("conform").format({ async = true, timeout = 500, lsp_format = "fallback" })
end, { desc = "Format buffer" })

vim.api.nvim_create_autocmd("TextYankPost", { callback = function() vim.hl.on_yank({ timeout = 400 }) end, })

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        if vim.bo.filetype == "go" then require("gopher").setup({ gotag = { transform = "camelcase" } }) end
        pcall(vim.treesitter.start)
    end
})

vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        require("mini.diff").setup()
        vim.cmd.packadd("nvim.undotree")
        require("nvim-treesitter").install({ "dockerfile", "bash", "lua", "python", "go", "javascript", "json", "yaml",
            "helm", "gotmpl" })
    end
})
