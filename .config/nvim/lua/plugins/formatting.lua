-- if true then return {} end
return {
    "stevearc/conform.nvim",
    opts = {},
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>=",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                css = { "prettierd" },
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
