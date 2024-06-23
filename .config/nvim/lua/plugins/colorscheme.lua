return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,
    config = function()
        require("gruvbox").setup({
            italic = {
                strings = false,
                emphasis = false,
                comments = true,
                operators = false,
                folds = true,
            },
            overrides = {
                SignColumn = { bg = "#282828" },
                FoldColumn = { bg = "#282828" },
            },
        })
        vim.cmd("colorscheme gruvbox")
    end,
}
