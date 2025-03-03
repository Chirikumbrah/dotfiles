return {
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        lazy = true,
        dependencies = { "williamboman/mason.nvim" },
        cmd = "MasonToolsInstallSync",
        opts = {
            ensure_installed = {
                "bash-language-server",
                "beautysh",
                "clangd",
                "docker-compose-language-service",
                "dockerfile-language-server",
                "gofumpt",
                "goimports",
                "gopls",
                "helm-ls",
                "lua-language-server",
                "nginx-language-server",
                "prettier",
                "pyright",
                "ruff",
                "stylua",
                "yaml-language-server",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        cmd = { "LspInfo", "LspInstall", "LspUninstall" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            capabilities = require("cmp_nvim_lsp").default_capabilities(),
                        })
                    end,
                },
            })
            vim.diagnostic.config({ virtual_text = false, severity_sort = true })
            vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Perform code action" })
            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
            -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
            vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
            -- start lsp on VeryLazy event
            vim.cmd("MasonToolsInstall")
            vim.cmd("LspStart")
        end,
    },
}
