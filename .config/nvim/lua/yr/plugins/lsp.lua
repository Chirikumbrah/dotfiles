return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
    },
    config = function()
        vim.diagnostic.config({ virtual_text = false, severity_sort = true })
        -- variables
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())
        -- lsp autoinstall
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
        -- lsp configs
        require("mason").setup()
        require("mason-lspconfig").setup({
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities
                    })
                end,
            }
        })
        -- completion configs
        cmp.setup({
            completion = { autocomplete = false },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = function(fallback) if cmp.visible() then cmp.close() else cmp.complete() end end,
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-n>"] = function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end,
                ["<C-p>"] = function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end,
            }),
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
            },
        })
    end,
}
