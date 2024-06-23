return {
	{ "tpope/vim-fugitive" },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require('gitsigns').setup()

			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		end
	}
}
