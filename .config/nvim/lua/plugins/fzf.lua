return {
    "ibhagwan/fzf-lua",
    keys = {
        { "<leader>f", function() require("fzf-lua").files() end, desc = "Open file picker" },
        { "<leader>b", function() require("fzf-lua").buffers() end, desc = "Open buffer picker" },
        { "<leader>/", function() require("fzf-lua").live_grep() end, desc = "Open live grep" },
        { "<leader>w", function() require("fzf-lua").grep_cword() end, desc = "Search word under cursor" },
        { "<leader>W", function() require("fzf-lua").grep_cWORD() end, desc = "Search WORD under cursor" },
        { "<leader>?", function() require("fzf-lua").helptags() end, desc = "Open command palette" },
        { "<leader>o", function() require("fzf-lua").oldfiles() end, desc = "Open old files picker" },
        { "<leader>s", function() require("fzf-lua").lsp_document_symbols() end, desc = "Open symbols picker" },
        { "<leader>S", function() require("fzf-lua").lsp_live_workspace_symbols() end, desc = "Open workspace symbols picker", },
        { "<leader>d", function() require("fzf-lua").lsp_workspace_diagnostics() end, desc = "Open diagnostics picker" },
        { "gr", function() require("fzf-lua").lsp_references() end, desc = "Go to references" },
        { "gd", function()
            local params = vim.lsp.util.make_position_params()
            local client = vim.lsp.get_clients({ bufnr = 0 })[1]
            if not client then
                print("No active LSP client")
                return
            end
            params.textDocument.uri = vim.uri_from_bufnr(0)
            vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result, _, _)
                if not result or vim.tbl_isempty(result) then
                    print("No definition found")
                    return
                end
                if #result == 1 then
                    vim.lsp.util.jump_to_location(result[1], client.offset_encoding or "utf-16")
                else
                    require("fzf-lua").lsp_definitions()
                end
            end)
        end, desc = "Go to definition (jump if one, pick if multiple)" }
    },
}
