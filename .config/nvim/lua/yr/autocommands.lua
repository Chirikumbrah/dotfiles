-- Detect Helm templates as helm filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*/templates/*.y*ml", "*/templates/*.tpl" },
    command = "set filetype=helm",
})

-- Detect *.conf as nginx filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.conf" },
    command = "set filetype=nginx",
})

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
    command = 'silent! normal! g`"zv',
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 400 })
    end,
})

