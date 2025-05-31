return {
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        lazy = true,
        dependencies = { "williamboman/mason.nvim" },
        event = "VeryLazy",
        cmd = { "MasonToolsInstall", "MasonToolsInstallSync" },
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
                "terraform-ls",
                "snyk",
                "pyright",
                "ruff",
                "stylua",
                "yaml-language-server",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "saghen/blink.cmp",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            local capabilities = {
                textDocument = {
                    foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true,
                    },
                },
            }
            capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
            require("mason").setup()
            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities,
                        })
                    end,
                },
            })
            vim.diagnostic.config({ virtual_text = false, severity_sort = true })
            vim.keymap.set("n", "]d", function()
                vim.diagnostic.jump({ count = 1, float = true })
            end, { desc = "Go to next diagnostic" })
            vim.keymap.set("n", "[d", function()
                vim.diagnostic.jump({ count = -1, float = true })
            end, { desc = "Go to previous diagnostic" })
            -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
            vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
        end,
    },
}
