return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        icons = {
            mappings = false,
        },
        spec = {
            { "<leader>h", group = "Harpoon" },
        },
    },
    keys = {
        ---- NeoVim ----
        { "<ESC>", vim.cmd.noh, desc = "Clear highlight", mode = "n" },
        { "gn", "<cmd>bnext<CR>", desc = "Go to next buffer", mode = "n" },
        { "gp", "<cmd>bprev<CR>", desc = "Go to previous buffer", mode = "n" },
        { "<leader>y", '"+y', desc = "Copy to system clipboard", mode = { "n", "v" } },
        { "<leader>p", '"+p', desc = "Paste after from system clipboard", mode = { "n", "v" } },
        { "<leader>P", '"+P', desc = "Paste before from system clipboard", mode = { "n", "v" } },
        { "<leader>t", [[<cmd>split | term<cr>A]], desc = "Open terminal in horizontal split", mode = "n" },
        { "<leader><ESC>", '<C-\\><C-n>', desc = "Use <leader>ESC to enter in terminal normal mode", mode = "t" },

        ---- Telescope ----
        { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Open file picker", mode = "n" },
        { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Open buffer picker", mode = "n" },
        { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Open live grep", mode = "n" },
        { "<leader>g", "<cmd>Telescope grep_string<cr>", desc = "Search word under cursor", mode = "n" },
        { "<leader>?", "<cmd>Telescope help_tags<cr>", desc = "Open command palette", mode = "n" },
        { "<leader>o", "<cmd>Telescope oldfiles<cr>", desc = "Open old files picker", mode = "n" },

        ---- Harpoon ----
        { "<leader>hh", require("harpoon.ui").toggle_quick_menu, desc = "Open menu", mode = "n" },
        { "<leader>hn", require("harpoon.ui").nav_next, desc = "Go to next file", mode = "n" },
        { "<leader>hp", require("harpoon.ui").nav_prev, desc = "Go to previous file", mode = "n" },
        { "<leader>ha", require("harpoon.mark").add_file, desc = "Add file to harpoon", mode = "n" },
        { "<leader>h1", function() require("harpoon.ui").nav_file(1) end, desc = "Go to file 1", mode = "n", },
        { "<leader>h2", function() require("harpoon.ui").nav_file(2) end, desc = "Go to file 2", mode = "n", },
        { "<leader>h3", function() require("harpoon.ui").nav_file(3) end, desc = "Go to file 3", mode = "n", },
        { "<leader>h4", function() require("harpoon.ui").nav_file(4) end, desc = "Go to file 4", mode = "n", },
        { "<leader>h5", function() require("harpoon.ui").nav_file(5) end, desc = "Go to file 5", mode = "n", },

        ---- LSP ----
        { "<leader>s", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Open symbols picker", mode = "n" },
        { "<leader>S", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Open workspace symbols picker", mode = "n" },
        { "<leader>D", vim.diagnostic.open_float, desc = "Show diagnostic message under the cursor", mode = "n" },
        { "<leader>k", vim.lsp.buf.hover, desc = "Show docs for item under cursor", mode = "n" },
        { "<leader>a", vim.lsp.buf.code_action, desc = "Perform code action", mode = "n" },
        { "<leader>r", vim.lsp.buf.rename, desc = "Rename symbol", mode = "n" },
        { "]d", vim.diagnostic.goto_next, desc = "Go to next diagnostic", mode = "n" },
        { "[d", vim.diagnostic.goto_prev, desc = "Go to previous diagnostic", mode = "n" },
        { "gd", vim.lsp.buf.definition, desc = "Go to definition", mode = "n" },
        { "gD", vim.lsp.buf.declaration, desc = "Go to declaration", mode = "n" },
        { "gr", "<cmd>Telescope lsp_references<cr>", desc = "Go to references", mode = "n" },
        { "gi", vim.lsp.buf.implementation, desc = "Go to implementation", mode = "n" },
        { "gy", vim.lsp.buf.type_definition, desc = "Go to type definition", mode = "n" },

        ---- Formatting ----
        { "<leader>=", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, mode = "", desc = "Format buffer", },
    },
}
