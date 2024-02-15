return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({})
        end
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require('mason-tool-installer').setup({
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
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require('lspconfig')
            lspconfig.bashls.setup({})
            lspconfig.docker_compose_language_service.setup({})
            lspconfig.dockerls.setup({})
            lspconfig.helm_ls.setup({})
            lspconfig.html.setup({})
            lspconfig.jsonls.setup({})
            lspconfig.lua_ls.setup({})
            lspconfig.marksman.setup({})
            lspconfig.ruff_lsp.setup({})
            lspconfig.sqlls.setup({})
            -- lspconfig.tailwindcss.setup({})
            lspconfig.taplo.setup({})
            lspconfig.tflint.setup({})
            lspconfig.tsserver.setup({})
            lspconfig.yamlls.setup({})

            local opts = { noremap = true, silent = true }
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '<leader>dd', ':Telescope diagnostics<CR>', opts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
        end
    },

}

