return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
        require("ibl").setup({
            indent = {
                smart_indent_cap = true,
            },
            scope = {
                show_start = false,
            },
        })
    end,
}
