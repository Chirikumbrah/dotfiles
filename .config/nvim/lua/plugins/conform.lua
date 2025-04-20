return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
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
    },
    keys = {
        {
            "<leader>=",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = "n",
            desc = "Format buffer [conform]",
        },
    },
}
