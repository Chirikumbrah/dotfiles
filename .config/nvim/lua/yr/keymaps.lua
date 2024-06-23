-- Set the Leader Key
vim.g.mapleader = " "

-- Open Netrw Explorer
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Disable search highlight with <ESC> key
vim.keymap.set("n", "<ESC>", vim.cmd.noh)

-- Convinient buffers manipulations
vim.keymap.set("n", "<leader>bd", vim.cmd.bdelete)

