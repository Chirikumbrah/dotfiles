-- Set the mapleader
vim.g.mapleader = " "

-- Open Netrw Explorer
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Disable search highlight with <ESC> key
vim.keymap.set("n", "<ESC>", vim.cmd.noh)

-- Convinient buffers manipulations
vim.keymap.set("n", "<leader>bd", "<Cmd>:bd!<CR>")
vim.keymap.set("n", "<leader>bn", vim.cmd.bnext)
vim.keymap.set("n", "<leader>bp", vim.cmd.bprev)

-- Convinient lines moving in the Visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Make cursor to be always in the center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Registers remaps
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("n", "<leader>p", "\"_dP")
vim.keymap.set("v", "<leader>p", "\"_dP")

-- vim.keymap.set("n", "<leader>y", "\"+y")
-- vim.keymap.set("v", "<leader>y", "\"+y")
-- vim.keymap.set("n", "<leader>Y", "\"+Y")

