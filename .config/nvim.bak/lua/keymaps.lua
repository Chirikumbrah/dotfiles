local opts = { noremap = true, silent = true }

-- quit
vim.keymap.set({ "n", "v" }, "<leader>q", "<cmd>q!<CR>", opts)

-- buffers navigation
vim.keymap.set({ "n", "v" }, "gn", "<cmd>bn<CR>", opts)
vim.keymap.set({ "n", "v" }, "gp", "<cmd>bp<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>x", "<cmd>bd<CR>", opts)

-- lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", opts)
