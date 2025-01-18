return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        vim.diagnostic.config({ virtual_text = false, severity_sort = true })
        -- lsp configs
        require("mason").setup()
        require("mason-lspconfig").setup()
        require("mason-tool-installer").setup({
            ensure_installed = {
                "bash-language-server",
                "clangd",
                "docker-compose-language-service",
                "dockerfile-language-server",
                "gofumpt",
                "goimports",
                "gopls",
                "lua-language-server",
                "prettier",
                "pyright",
                "ruff",
                "beautysh",
                "stylua",
                "yaml-language-server",
            },
        })
        -- keymaps
        vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, { desc = "Show docs for item under cursor" })
        vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Perform code action" })
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
    end,
}
