return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        icons = { mappings = false },
        spec = {
            { "gr", group = "+LSP/fzf-lua" },
            { "<leader>g", group = "+gitsigns" }
        }
    },
}
