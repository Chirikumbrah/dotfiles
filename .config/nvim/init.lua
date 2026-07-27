vim.g.mapleader = " "
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.grepprg = "grep -HRIn $* ."
vim.opt.grepformat = "%f:%l:%m"
vim.o.formatprg = "prettier --stdin-filepath %"
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.number = true
vim.opt.path:append({ "**" })
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.smartindent = true
vim.opt.smoothscroll = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.wildoptions:append({ "fuzzy" })
vim.opt.winborder = "bold"
vim.opt.complete = "o,.,w,b,u,t"
vim.opt.completeopt = "menu,menuone,popup,fuzzy,noinsert"

vim.cmd("packadd nvim.undotree | colorscheme habamax")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#3f3f3f", bg = "none" })

vim.filetype.add({
    pattern = {
        [".*/templates/.*%.tpl"] = "helm",
        [".*/templates/.*%.ya?ml"] = "helm",
        [".*%.ya?ml%.tmpl"] = "helm",
        ["helmfile.*%.ya?ml"] = "helm",
        [".*%.conf$"] = "nginx",
        [".*%.conf%.tmpl"] = "nginx",
    },
})

vim.lsp.enable({ "basedpyright", "bashls", "clangd", "dockerls", "gopls", "helm_ls", "jsonls", "lua_ls", "marksman",
    "ruff", "terraformls", "tflint", "yamlls", "taplo" })

vim.pack.add({
    { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
    { src = "https://github.com/olexsmir/gopher.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/owallb/mason-auto-install.nvim" },
    { src = "https://github.com/nvim-mini/mini.diff" },
})

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = 'Copy to "+' })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = 'Paste after from "+' })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = 'Paste before from "+' })
vim.keymap.set({ "n", "v" }, "<leader>u", vim.cmd.Undotree, { desc = "Undotree" })
vim.keymap.set("n", "<leader>t", [[<cmd>%s/\s\+$//e | noh<cr>]], { desc = "Trim whitespace" })
vim.keymap.set("n", "<leader>s", vim.lsp.buf.document_symbol, { desc = "LSP symbols" })
vim.keymap.set("n", "<Leader>S", vim.lsp.buf.workspace_symbol, { desc = "Find LSP workspace symbols" })
vim.keymap.set("n", "<Leader>d", vim.diagnostic.setqflist, { desc = "Workspace Diagnostics" })
vim.keymap.set("n", "<Leader><leader>", ":fin <C-z>", { desc = "Find file" })
vim.keymap.set("n", "<Leader>/", ":copen | :silent :grep ", { desc = "Grep" })
vim.keymap.set("n", "<Leader>g", require("mini.diff").toggle_overlay, { desc = "Show Diff" })

vim.api.nvim_create_autocmd("TextYankPost", { callback = function() vim.hl.on_yank({ timeout = 400 }) end, })

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        if vim.bo.filetype == "go" then require("gopher").setup({ gotag = { transform = "camelcase" } }) end
    end
})

require("tree-sitter-manager").setup({ auto_install = true, ensure_installed = { "gotmpl" } })
require("mini.diff").setup()
require("mason").setup()
require("mason-auto-install").setup { packages = { "basedpyright", "bash-language-server", "clangd",
    "docker-language-server", "json-lsp", "gopls", "helm-ls", "shellcheck", "yaml-language-server",
    "lua-language-server", "marksman", "prettier", "ruff", "taplo", "terraform-ls", "tflint", },
}
