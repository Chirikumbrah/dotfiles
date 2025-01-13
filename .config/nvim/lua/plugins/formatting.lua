-- if true then return {} end
return {
    "stevearc/conform.nvim",
    opts = {},
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                css = { "prettier" },
                go = { "goimports", "gofmt" },
                graphql = { "prettier" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                json = { "prettier" },
                lua = { "stylua" },
                markdown = { "prettier" },
                python = { "ruff-lsp" },
                sh = { "beautysh" },
                zsh = { "beautysh" },
                toml = { "taplo" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                yaml = { "prettier" },
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
