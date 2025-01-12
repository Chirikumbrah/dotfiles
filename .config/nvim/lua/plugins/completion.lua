return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            completion = { autocomplete = false, },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-e>"] = function(fallback) if cmp.visible() then cmp.close() else cmp.complete() end end,
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-n>"] = function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end,
                ["<C-p>"] = function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end,
            }),
            sources = {
                { name = "nvim_lsp", max_item_count = 5 },
                { name = "luasnip", max_item_count = 5 },
                { name = "vsnip", max_item_count = 5 },
            },
        })
    end,
}
