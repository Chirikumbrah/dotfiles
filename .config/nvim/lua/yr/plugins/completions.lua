return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/nvim-cmp",
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            build = "make install_jsregexp"
        },
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "hrsh7th/cmp-buffer",
        -- "FelipeLema/cmp-async-path",
    },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
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
                -- { name = "async_path" },
            },
        })
    end,
}
