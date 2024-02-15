local opts = { noremap = true, silent = true }

-- quit
vim.keymap.set({ "n", "v" }, "<leader>q", ":q!<CR>", opts)

-- buffers navigation
vim.keymap.set({ "n", "v" }, "<leader>n", ":bn<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>p", ":bp<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>c", ":bd<CR>", opts)
