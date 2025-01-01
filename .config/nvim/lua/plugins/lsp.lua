return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        require("mason-tool-installer").setup({
            ensure_installed = {
                "bash-language-server",
                "clangd",
                "docker-compose-language-service",
                "dockerfile-language-server",
                "gofumpt",
                "goimports",
                "gopls",
                "lua-language-server",
                "prettierd",
                "pyright",
                "ruff",
                "beautysh",
                "stylua",
                "yaml-language-server",
            },
        })
        require("mason").setup()
        require("mason-lspconfig").setup()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
                })
            end,
        })
    end,
}
