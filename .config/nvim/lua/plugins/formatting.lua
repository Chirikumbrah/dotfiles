if true then return {} end
return {
    "stevearc/conform.nvim",
    opts = {},
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>cf",
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
                lua = { "stylua" },
                python = { "ruff-lsp" },
                javascript = { { "prettierd", "prettier" } },
                yaml = { { "prettierd", "prettier" } },
                markdown = { { "prettierd", "prettier" } },
                sh = { "shfmt" },
                toml = { "taplo" },
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
