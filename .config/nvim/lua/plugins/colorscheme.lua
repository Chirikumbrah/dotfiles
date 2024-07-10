return {
    {
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
            -- vim.cmd("colorscheme gruvbox")
        end,
    },
    {
        "maxmx03/solarized.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require('solarized').setup({
                styles = {
                    comments = { italic = true, bold = false },
                    functions = { italic = false },
                    variables = { italic = false },
                    numbers = { italic = false },
                    constants = { italic = false },
                    parameters = { italic = false },
                    keywords = { italic = false },
                    types = { italic = false },
                },
            })
            vim.o.background = "dark" -- or 'light'
            vim.cmd.colorscheme("solarized")
        end,
    },
}
