return {
    "nvimdev/lspsaga.nvim",
    config = function()
        require("lspsaga").setup({
            symbol_in_winbar = { enable = false },
        })
        vim.keymap.set("n", "<leader>ca", "<CMD>Lspsaga code_action<CR>")
        vim.keymap.set("n", "<leader>cr", "<CMD>Lspsaga rename<CR>")
        vim.keymap.set("n", "<leader>pd", "<CMD>Lspsaga peek_definition<CR>")
        vim.keymap.set("n", "<leader>pi", "<CMD>Lspsaga finder imp<CR>")
        vim.keymap.set("n", "<leader>t", "<CMD>Lspsaga term_toggle<CR>")
        vim.keymap.set("n", "<leader>k", "<cmd>Lspsaga hover_doc<CR>")
    end,
    event = "LspAttach",
    dependencies = {
        "nvim-treesitter/nvim-treesitter", -- optional
        "nvim-tree/nvim-web-devicons", -- optional
    },
}
