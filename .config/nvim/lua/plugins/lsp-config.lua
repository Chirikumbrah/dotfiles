return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({})
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "bash-language-server",
                    "docker-compose-language-service",
                    "dockerfile-language-server",
                    "helm-ls",
                    "hadolint",
                    "html-lsp",
                    "json-lsp",
                    "lua-language-server",
                    "marksman",
                    "prettier",
                    "ruff",
                    "ruff-lsp",
                    "shfmt",
                    "sql-formatter",
                    "sqlls",
                    "stylua",
                    "taplo",
                    "tflint",
                    "typescript-language-server",
                    "yaml-language-server",
                },
                start_delay = 3000,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = {
                enabled = false,
            },
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local lspconfig = require("lspconfig")
            local servers = {
                "bashls",
                "docker_compose_language_service",
                "dockerls",
                "helm_ls",
                "html",
                "jsonls",
                "lua_ls",
                "marksman",
                "pyright",
                "ruff_lsp",
                "sqlls",
                "taplo",
                "tflint",
                "tsserver",
                "yamlls",
            }

            lspconfig.bashls.setup({
                capabilities = capabilities,
            })
            lspconfig.docker_compose_language_service.setup({
                capabilities = capabilities,
            })
            lspconfig.dockerls.setup({
                capabilities = capabilities,
            })
            lspconfig.helm_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.html.setup({
                capabilities = capabilities,
            })
            lspconfig.jsonls.setup({
                capabilities = capabilities,
            })
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.marksman.setup({
                capabilities = capabilities,
            })
            lspconfig.pyright.setup({
                capabilities = capabilities,
            })
            lspconfig.ruff_lsp.setup({
                capabilities = capabilities,
            })
            lspconfig.sqlls.setup({
                capabilities = capabilities,
            })
            -- lspconfig.tailwindcss.setup({})
            lspconfig.taplo.setup({
                capabilities = capabilities,
            })
            lspconfig.tflint.setup({
                capabilities = capabilities,
            })
            lspconfig.tsserver.setup({
                capabilities = capabilities,
            })
            lspconfig.yamlls.setup({
                capabilities = capabilities,
            })

            local opts = { noremap = true, silent = true }
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
            vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "<leader>dd", ":Telescope diagnostics<CR>", opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
        end,
    },
}
