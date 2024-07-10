if true then return {} end
return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
        require("ibl").setup({
            indent = {
                char = "┃",
                smart_indent_cap = true,
            },
            scope = {
                show_start = false,
            },
        })
    end,
}
