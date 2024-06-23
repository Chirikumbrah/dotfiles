return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local ignored_filetypes = {
            "lazy",
            "alpha",
            "neo-tree",
        }
        require("lualine").setup({
            options = {
                ignore_focus = ignored_filetypes,
                disabled_filetypes = ignored_filetypes,
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
            },
        })
    end,
}
