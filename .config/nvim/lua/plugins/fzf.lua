return {
    "ibhagwan/fzf-lua",
    keys = {
        { "<leader>/", function() require("fzf-lua").live_grep() end,                  desc = "Open live grep" },
        { "<leader>h", function() require("fzf-lua").helptags() end,                   desc = "Open command picker" },
        { "<leader>k", function() require("fzf-lua").keymaps() end,                    desc = "Open keymaps picker" },
        { "<leader>S", function() require("fzf-lua").lsp_live_workspace_symbols() end, desc = "Open workspace symbols picker", },
        { "<leader>W", function() require("fzf-lua").grep_cWORD() end,                 desc = "Search WORD under cursor" },
        { "<leader>b", function() require("fzf-lua").buffers() end,                    desc = "Open buffer picker" },
        { "<leader>d", function() require("fzf-lua").lsp_workspace_diagnostics() end,  desc = "Open diagnostics picker" },
        { "<leader>f", function() require("fzf-lua").files() end,                      desc = "Open file picker" },
        { "<leader>o", function() require("fzf-lua").oldfiles() end,                   desc = "Open old files picker" },
        { "<leader>s", function() require("fzf-lua").lsp_document_symbols() end,       desc = "Open symbols picker" },
        { "<leader>w", function() require("fzf-lua").grep_cword() end,                 desc = "Search word under cursor" },
        { "gd",        function() require("fzf-lua").lsp_definitions() end,            desc = "Go to definition (jump if one, pick if multiple)" },
        -- { "gra", function() require('fzf-lua').lsp_code_actions() end, desc = "vim.lsp.buf.code_action() [fzf-lua]" },
        { "gri",       function() require('fzf-lua').lsp_implementations() end,        desc = "vim.lsp.buf.implementation() [fzf-lua]" },
        { "grr",       function() require('fzf-lua').lsp_references() end,             desc = "vim.lsp.buf.references() [fzf-lua]" },
    }
}
