vim.g.mapleader = " "
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.grepprg = "grep -HRIn $* ."
vim.o.formatexpr = "v:lua.Format()"
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.number = true
vim.opt.path:append({ "**", ".*/**", "**/.*/**" })
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.swapfile = false
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
        [".*%.ya?ml.tmpl"] = "helm",
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
    { src = "https://github.com/olexsmir/gopher.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/owallb/mason-auto-install.nvim" },
    { src = "https://github.com/nvim-mini/mini.diff" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
})

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = 'Copy to "+' })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = 'Paste after from "+' })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = 'Paste before from "+' })
vim.keymap.set({ "n", "v" }, "<leader>u", vim.cmd.Undotree, { desc = "Undotree" })
vim.keymap.set("n", "<leader>t", [[<cmd>%s/\s\+$//e | noh<cr>]], { desc = "Trim whitespace" })
vim.keymap.set("n", "<leader>s", function()
    vim.lsp.buf.document_symbol({
        on_list = function(o)
            vim.fn.setqflist(o.items); vim.cmd.copen()
        end
    })
end, { desc = "LSP symbols" })
vim.keymap.set("n", "<Leader>S", require("fzf-lua").lsp_live_workspace_symbols, { desc = "LSP workspace symbols" })
vim.keymap.set("n", "<Leader>d", vim.diagnostic.setqflist, { desc = "Workspace Diagnostics" })
vim.keymap.set("n", "<Leader><leader>", require("fzf-lua").files, { desc = "Files" })
vim.keymap.set("n", "<Leader>/", ":copen | :silent :grep ", { desc = "Grep" })
vim.keymap.set("n", "<Leader>g", require("mini.diff").toggle_overlay, { desc = "Show Diff" })

vim.api.nvim_create_autocmd("TextYankPost", { callback = function() vim.hl.on_yank({ timeout = 400 }) end, })

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        if vim.bo.filetype == "go" then require("gopher").setup({ gotag = { transform = "camelcase" } }) end
        pcall(vim.treesitter.start)
    end
})

function _G.Format()
    local s, e = vim.v.lnum, vim.v.lnum + vim.v.count - 1
    local r = vim.system({ "prettier", "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
        { stdin = table.concat(vim.api.nvim_buf_get_lines(0, s - 1, e, false), "\n") .. "\n", text = true }):wait()
    if r.code == 0 then vim.api.nvim_buf_set_lines(0, s - 1, e, false, vim.split(r.stdout, "\n", { trimempty = true })) else
        vim.lsp.buf.format() end
    return 0
end

vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        require("mini.diff").setup()
        vim.cmd.packadd("nvim.undotree")
        require("nvim-treesitter").install({ "dockerfile", "bash", "lua", "python", "go", "javascript", "json", "yaml",
            "helm", "gotmpl" })
        require("mason").setup()
        require("mason-auto-install").setup { packages = { "basedpyright", "bash-language-server", "clangd",
            "docker-language-server", "json-lsp", "gofumpt", "goimports", "golangci-lint", "gopls", "helm-ls", "shellcheck",
            "lua-language-server", "marksman", "prettier", "ruff", "taplo", "terraform-ls", "tflint", "yaml-language-server", "beautysh" },
        }
    end
})
