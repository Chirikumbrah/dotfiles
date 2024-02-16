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
        dependencies =  {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("telescope").load_extension("lazygit")
            local opts = { noremap = true, silent = true }
            vim.keymap.set({ "n", "v" }, "<leader>gg", ":LazyGitCurrentFile<CR>", opts)
            vim.keymap.set({ "n", "v" }, "<leader>gl", ":Telescope lazygit<CR>", opts)
        end,
    },
}
