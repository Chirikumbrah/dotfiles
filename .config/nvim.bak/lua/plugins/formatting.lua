return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                json = { "prettier" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                xml = { "xmlformat" },
                python = { "ruff_format" },
                toml = { "taplo" },
                dockerfile = { "shfmt" },
                sh = { "shfmt" },
                fish = { "fish_indent" },
            },
            formatters = {
                shfmt = {
                    command = "shfmt",
                    prepend_args = { "-i", "4", "-ci" },
                },
            },
        })

        vim.keymap.set("", "<leader>cf", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                quiet = false,
                timeout_ms = 3000,
            })
        end, { noremap = true, silent = true, desc = "Format file or range (in visual mode)" })
    end,
}
