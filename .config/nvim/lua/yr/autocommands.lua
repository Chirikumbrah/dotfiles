-- Theese are taken from LazyVim default autocommands
-- Please visit this to take more if you want: http://www.lazyvim.org/configuration/general#auto-commands
local function augroup(name)
    return vim.api.nvim_create_augroup("yr_autocmd_" .. name, { clear = true })
end

-- Detect Helm templates as helm filetype
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*/templates/*.y*ml", "*/templates/*.tpl"},
    command = "set filetype=helm"
})
-- Define syntax and indentation for helm filetype
vim.api.nvim_create_augroup("helm_syntax", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "helm",
    callback = function()
        vim.opt_local.syntax = "yaml"
    end,
    group = "helm_syntax"
})

-- Remove Trailing whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

-- -- Function to check if a floating dialog exists and if not
-- -- then check for diagnostics under the cursor
-- function OpenDiagnosticIfNoFloat()
--     for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
--         if vim.api.nvim_win_get_config(winid).zindex then
--             return
--         end
--     end
--     -- THIS IS FOR BUILTIN LSP
--     vim.diagnostic.open_float(0, {
--         scope = "cursor",
--         focusable = false,
--         close_events = {
--             "CursorMoved",
--             "CursorMovedI",
--             "BufHidden",
--             "InsertCharPre",
--             "WinLeave",
--         },
--     })
-- end
-- -- Show diagnostics under the cursor when holding position
-- vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
--     pattern = "*",
--     command = "lua OpenDiagnosticIfNoFloat()",
--     group = "lsp_diagnostics_hold",
-- })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 400 })
    end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "neotest-output",
        "checkhealth",
        "neotest-summary",
        "neotest-output-panel",
        "dbout",
        "gitsigns.blame",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- Make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("man_unlisted"),
    pattern = { "man" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
    end,
})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "*.txt", "*.tex", "*.typ", "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = augroup("json_conceal"),
    pattern = { "json", "jsonc", "json5" },
    callback = function()
        vim.opt_local.conceallevel = 0
    end,
})
