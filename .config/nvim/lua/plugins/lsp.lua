return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                "FelipeLema/cmp-async-path",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-vsnip",
            },
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require("cmp")
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                formatting = lsp_zero.cmp_format({ details = true }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "async_path" },
                    { name = "vsnip" },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
                    ["<C-y>"] = cmp.mapping.confirm({ select = false }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-n>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = "insert" })
                        else
                            cmp.complete()
                        end
                    end),
                    ["<C-p>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = "insert" })
                        else
                            cmp.complete()
                        end
                    end),
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
            })
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            --- if you want to know more about lsp-zero and mason.nvim
            --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                local opts = { buffer = bufnr }

                lsp_zero.default_keymaps(opts)
            end)

            require("mason-lspconfig").setup({
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,
                },
            })
            vim.diagnostic.config({
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    -- spacing = 4,
                    source = "if_many",
                    prefix = "●",
                },
                severity_sort = true,
            })
        end,
    },
    {
        "nvimdev/lspsaga.nvim",
        config = function()
            require("lspsaga").setup({
                symbol_in_winbar = { enable = false },
                lightbulb = { enable = false },
            })
            vim.keymap.set("n", "<leader>ca", "<CMD>Lspsaga code_action<CR>")
            vim.keymap.set("n", "<leader>cr", "<CMD>Lspsaga rename<CR>")
            vim.keymap.set("n", "<leader>pd", "<CMD>Lspsaga peek_definition<CR>")
            vim.keymap.set("n", "<leader>pi", "<CMD>Lspsaga finder imp<CR>")
            vim.keymap.set("n", "<leader>t", "<CMD>Lspsaga term_toggle<CR>")
            vim.keymap.set("n", "<leader>k", "<cmd>Lspsaga hover_doc<CR>")
        end,
        event = "LspAttach",
        dependencies = {
            "nvim-treesitter/nvim-treesitter", -- optional
            "nvim-tree/nvim-web-devicons", -- optional
        },
    },
}
