-- if true then return {} end
return {
    "stevearc/conform.nvim",
    opts = {},
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                css = { "prettierd" },
                go = { "goimports", "gofmt" },
                graphql = { "prettierd" },
                javascript = { "prettierd" },
                javascriptreact = { "prettierd" },
                json = { "prettierd" },
                lua = { "stylua" },
                markdown = { { "prettierd", "prettier" } },
                python = { "ruff-lsp" },
                sh = { "shfmt" },
                toml = { "taplo" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
                yaml = { { "prettierd", "prettier" } },
            },
            formatters = {
                shfmt = {
                    prepend_args = { "-i", "4", "-ci" },
                },
                stylua = {
                    prepend_args = { "--indent-type", "Spaces" },
                },
            },
        })
    end,
}
