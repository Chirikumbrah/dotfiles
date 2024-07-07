return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        {
            "williamboman/mason.nvim",
            config = true
        },
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason-lspconfig").setup({
            automatic_installation = true,
        })
        require("mason-lspconfig").setup_handlers({
            function(server_name) -- default handler (optional)
                require("lspconfig")[server_name].setup({})
            end,
        })
    end,
}
