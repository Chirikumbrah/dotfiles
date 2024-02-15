return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()

            local opts = { noremap = true, silent = true }
            vim.keymap.set({ "n", "v" }, "<leader>gp", ":Gitsigns preview_hunk<CR>", opts)
            vim.keymap.set({ "n", "v" }, "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", opts)
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function ()
            local opts = { noremap = true, silent = true }
            vim.keymap.set({ "n", "v" }, "<leader>gg", ":LazyGitCurrentFile<CR>", opts)
        end
    },
}
