-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- gitsigns
vim.keymap.set({ "n", "v" }, "<leader>ghl", "<cmd>Gitsigns toggle_current_line_blame<cr>",
  { desc = "Toggle Current Line Blame" })
