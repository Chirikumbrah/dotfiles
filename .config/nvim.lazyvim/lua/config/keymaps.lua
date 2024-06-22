-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- gitsigns
vim.keymap.set({ "n", "v" }, "<leader>ghl", "<cmd>Gitsigns toggle_current_line_blame<cr>",
  { desc = "Toggle Current Line Blame" })

-- telescope emoji symbols
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope symbols<cr>", { desc = "Find Emoji Symbols" })

-- diffview
vim.keymap.set({ "n", "v" }, "<leader>gdt", "<cmd>DiffviewToggleFiles<cr>", { desc = "Toggle Diffview File Tree" })
vim.keymap.set({ "n", "v" }, "<leader>gdf", "<cmd>DiffviewFocusFiles<cr>", { desc = "Focus Diffview File Tree" })
vim.keymap.set({ "n", "v" }, "<leader>gdo", "<cmd>DiffviewOpen<cr>", { desc = "Focus Diffview File Tree" })
vim.keymap.set({ "n", "v" }, "<leader>gdc", "<cmd>DiffviewClose<cr>", { desc = "Focus Diffview File Tree" })
