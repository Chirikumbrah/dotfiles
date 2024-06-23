return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		require("gruvbox").setup()
		vim.cmd("colorscheme gruvbox")

		-- Set transparent background
		local function set_transparent_bg(color)
			color = color or "gruvbox"
			vim.cmd.colorscheme(color)
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		end
		-- I don't need it now, so uncomment if you want :)
		-- set_transparent_bg()
	end
}
