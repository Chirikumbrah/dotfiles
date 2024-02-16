return {
    "stevearc/conform.nvim",
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
                xml = { "prettier" },
                json = { "prettier" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
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

        vim.keymap.set({ "n", "v" }, "<leader>cf", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { noremap = true, silent = true, desc = "Format file or range (in visual mode)" })
    end,
}
