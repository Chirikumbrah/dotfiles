return {
    "folke/zen-mode.nvim",
    opts = {},
    keys = {
        {
            "<leader>z",
            function()
                require("zen-mode").toggle()
            end,
            desc = "Toggle zen mode",
        },
    },
}
