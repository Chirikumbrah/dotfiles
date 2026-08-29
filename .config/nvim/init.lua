vim.g.mapleader = " "
vim.o.formatprg = "prettier --stdin-filepath %"
vim.o.signcolumn = "yes"
vim.o.updatetime = 50
vim.opt.path:append({ "**", "**/.*/**" })
vim.opt.wildoptions:append({ "fuzzy" })
vim.o.winborder = "bold"
vim.o.complete = "o,.,w,b,u,t"
vim.o.completeopt = "menu,menuone,popup,fuzzy,noinsert"
for _, opt in ipairs({ "shiftwidth", "tabstop", "softtabstop" }) do vim.o[opt] = 2 end
for _, opt in ipairs({ "cursorcolumn", "cursorline", "expandtab", "ignorecase", "incsearch", "list", "number",
  "shiftround", "smartcase", "smartindent", "smoothscroll", "undofile", }) do vim.o[opt] = true end
vim.o.swapfile = false

vim.cmd("packadd nvim.undotree | colorscheme habamax")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#3f3f3f", bg = "none" })

vim.filetype.add({
  pattern = { [".*/templates/.*%.tpl"] = "helm", [".*/templates/.*%.ya?ml"] = "helm",
    [".*%.ya?ml%.tmpl"] = "helm", ["helmfile.*%.ya?ml"] = "helm",
    [".*%.conf$"] = "nginx", [".*%.conf%.tmpl"] = "nginx", },
})

vim.lsp.enable({ "basedpyright", "bashls", "clangd", "dockerls", "gopls", "helm_ls", "jsonls", "lua_ls", "marksman",
  "ruff", "terraformls", "tflint", "yamlls", "taplo" })

vim.pack.add(vim.tbl_map(function(repo)
  return { src = "https://github.com/" .. repo }
end, { "romus204/tree-sitter-manager.nvim", "olexsmir/gopher.nvim", "neovim/nvim-lspconfig", "mason-org/mason.nvim",
  "owallb/mason-auto-install.nvim", "nvim-mini/mini.diff", "nvim-mini/mini.pick",
}))

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P')
vim.keymap.set({ "n", "v" }, "<leader>u", vim.cmd.Undotree, { silent = true })
vim.keymap.set("n", "<leader>t", [[<cmd>%s/\s\+$//e | noh<cr>]], { silent = true })
vim.keymap.set("n", "<leader>s", vim.lsp.buf.document_symbol, { silent = true })
vim.keymap.set("n", "<leader>S", vim.lsp.buf.workspace_symbol, { silent = true })
vim.keymap.set("n", "<leader>d", vim.diagnostic.setqflist, { silent = true })
vim.keymap.set("n", "<leader>g", require("mini.diff").toggle_overlay, { silent = true })
vim.keymap.set("n", "<leader>/", ":Pick grep_live<cr>", { silent = true })
vim.keymap.set("n", "<leader><leader>", ":Pick files<cr>", { silent = true })

vim.api.nvim_create_autocmd("TextYankPost", { callback = function() vim.hl.on_yank({ timeout = 400 }) end, })
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if vim.bo.filetype == "go" then require("gopher").setup({ gotag = { transform = "camelcase" } }) end
  end
})

require("tree-sitter-manager").setup({ auto_install = true, ensure_installed = { "gotmpl" } })
for _, mod in ipairs({ "mini.diff", "mini.pick", "mason" }) do require(mod).setup() end
require("mason-auto-install").setup { packages = { "basedpyright", "bash-language-server", "clangd",
  "docker-language-server", "json-lsp", "gopls", "helm-ls", "yaml-language-server",
  "lua-language-server", "marksman", "prettier", "ruff", "taplo", "terraform-ls", "tflint", },
}
