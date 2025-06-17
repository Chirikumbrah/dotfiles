return {
    "echasnovski/mini.files",
    version = "*",
    keys = {
        {
            "<leader>e",
            function()
                require("mini.files").open()
            end,
            desc = "Open live grep",
        },
    },
}
