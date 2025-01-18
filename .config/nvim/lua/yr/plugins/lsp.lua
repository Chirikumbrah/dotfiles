return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
    },
    config = function()
        vim.diagnostic.config({ virtual_text = false, severity_sort = true })
        -- lsp configs
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "helm_ls",
                "yamlls",
                "dockerls",
                "gopls",
                "pyright",
                "clangd",
                "nginx_language_server",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = vim.tbl_deep_extend(
                            "force",
                            {},
                            vim.lsp.protocol.make_client_capabilities(),
                            require("cmp_nvim_lsp").default_capabilities()
                        ),
                    })
                end,
            },
        })
        -- completion configs
        local cmp = require("cmp")
        cmp.setup({
            completion = { autocomplete = false },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-n>"] = function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end,
                ["<C-p>"] = function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end,
                ["<C-e>"] = function(fallback) if cmp.visible() then cmp.close() else cmp.complete() end end,
            }),
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
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
