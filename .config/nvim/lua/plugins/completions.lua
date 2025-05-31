return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    event = "InsertEnter",
    opts = {
        completion = {
            menu = {
                draw = {
                    columns = { { "label", "label_description", "kind", gap = 1 } },
                },
            },
        },

        signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
}
