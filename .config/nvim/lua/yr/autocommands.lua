-- Theese are taken from LazyVim default autocommands
-- Please visit this to take more if you want: http://www.lazyvim.org/configuration/general#auto-commands
local function augroup(name)
    return vim.api.nvim_create_augroup("yr_autocmd_" .. name, { clear = true })
end

-- Remove Trailing whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

-- Find Files on startup
-- vim.api.nvim_create_autocmd("VimEnter", {
--     callback = function()
--         if vim.fn.argv(0) == "" then
--             require("telescope.builtin").find_files()
--         end
--     end,
-- })

-- Set fold method
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--     callback = function()
--         if require("nvim-treesitter.parsers").has_parser() then
--             vim.opt.foldmethod = "expr"
--             vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
--         else
--             vim.opt.foldmethod = "indent"
--         end
--     end,
-- })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 400 })
    end,
})

-- Go to last loc when opening a buffer
-- vim.api.nvim_create_autocmd("BufReadPost", {
--     group = augroup("last_loc"),
--     callback = function(event)
--         local exclude = { "gitcommit" }
--         local buf = event.buf
--         if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
--             return
--         end
--         vim.b[buf].lazyvim_last_loc = true
--         local mark = vim.api.nvim_buf_get_mark(buf, '"')
--         local lcount = vim.api.nvim_buf_line_count(buf)
--         if mark[1] > 0 and mark[1] <= lcount then
--             pcall(vim.api.nvim_win_set_cursor, 0, mark)
--         end
--     end,
-- })

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
