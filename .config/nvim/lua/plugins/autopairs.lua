return {
    {
        "echasnovski/mini.pairs",
        event = { "InsertEnter","VeryLazy", },
        opts = {},
        keys = {
            {
                "<leader>up",
                function()
                    vim.g.minipairs_disable = not vim.g.minipairs_disable
                end,
                desc = "Toggle auto pairs",
            },
        },
    },
}
