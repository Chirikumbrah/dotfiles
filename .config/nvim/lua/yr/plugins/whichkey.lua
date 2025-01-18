return {
    "folke/which-key.nvim",
    dependencies = { { "mbbill/undotree", lazy = true } },
    event = "VeryLazy",
    opts = {
        preset = "helix",
        icons = { mappings = false },
    },
    keys = {
        ---- NeoVim ----
        { "<ESC>", vim.cmd.noh, desc = "Clear highlight", mode = "n" },
        { "gn", "<cmd>bnext<CR>", desc = "Go to next buffer", mode = "n" },
        { "gp", "<cmd>bprev<CR>", desc = "Go to previous buffer", mode = "n" },
        { "<leader>e", "<cmd>25Lexplore<CR>", desc = "Open file browser", mode = "n" },
        { "<leader>y", '"+y', desc = "Copy to system clipboard", mode = { "n", "v" } },
        { "<leader>p", '"+p', desc = "Paste after from system clipboard", mode = { "n", "v" } },
        { "<leader>P", '"+P', desc = "Paste before from system clipboard", mode = { "n", "v" } },
        { "<leader>t", [[<cmd>split | term<cr>A]], desc = "Open terminal in horizontal split", mode = "n" },
        { "<leader><BS>", [[<cmd>%s/\s\+$//e<cr><cmd>noh<cr>]], desc = "Remove trailing whitespace", mode = "n" },
        { "<leader><ESC>", "<C-\\><C-n>", desc = "Use <leader>ESC to enter in terminal normal mode", mode = "t" },

        ---- Fzf ----
        { "<leader>f", require("fzf-lua").files, desc = "Open file picker", mode = "n" },
        { "<leader>B", require("fzf-lua").buffers, desc = "Open buffer picker", mode = "n" },
        { "<leader>/", require("fzf-lua").live_grep, desc = "Open live grep", mode = "n" },
        { "<leader>w", require("fzf-lua").grep_cword, desc = "Search word under cursor", mode = "n" },
        { "<leader>W", require("fzf-lua").grep_cWORD, desc = "Search WORD under cursor", mode = "n" },
        { "<leader>?", require("fzf-lua").helptags, desc = "Open command palette", mode = "n" },
        { "<leader>o", require("fzf-lua").oldfiles, desc = "Open old files picker", mode = "n" },

        ---- Snipe ----
        { "<leader>b", require("snipe").open_buffer_menu, desc = "Go to buffer", mode = "n" },

        ---- LSP ----
        { "<leader>s", require("fzf-lua").lsp_document_symbols, desc = "Open symbols picker", mode = "n" },
        {
            "<leader>S",
            require("fzf-lua").lsp_live_workspace_symbols,
            desc = "Open workspace symbols picker",
            mode = "n",
        },
        { "<leader>d", require("fzf-lua").lsp_workspace_diagnostics, desc = "Open diagnostics picker", mode = "n" },
        { "<leader>k", vim.lsp.buf.hover, desc = "Show docs for item under cursor", mode = "n" },
        { "<leader>a", vim.lsp.buf.code_action, desc = "Perform code action", mode = "n" },
        { "<leader>r", vim.lsp.buf.rename, desc = "Rename symbol", mode = "n" },
        { "]d", vim.diagnostic.goto_next, desc = "Go to next diagnostic", mode = "n" },
        { "[d", vim.diagnostic.goto_prev, desc = "Go to previous diagnostic", mode = "n" },
        { "gd", vim.lsp.buf.definition, desc = "Go to definition", mode = "n" },
        { "gD", vim.lsp.buf.declaration, desc = "Go to declaration", mode = "n" },
        { "gr", require("fzf-lua").lsp_references, desc = "Go to references", mode = "n" },
        { "gi", vim.lsp.buf.implementation, desc = "Go to implementation", mode = "n" },
        { "gy", vim.lsp.buf.type_definition, desc = "Go to type definition", mode = "n" },

        ---- Formatting ----
        { "<leader>=", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, mode = "n", desc = "Format buffer" },

        ---- Undotree ----
        { "<leader>u", vim.cmd.UndotreeToggle, mode = "n", desc = "Toggle undotree" },
    },
}
