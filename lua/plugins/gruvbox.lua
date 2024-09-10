return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	lazy = false,
	enabled = true,
	config = function()
		require("gruvbox").setup({
			transparent_mode = false,
			-- overrides = {
			--     NvimTreeNormal = {bg = '#32302f'},
			--     NvimTreeEndOfBuffer = {fg = '#32302f'},
			--     EndOfBuffer = {fg = "#32302f"},
			--     NonText = {fg = "#5a524c"}
			-- }
		})
		vim.cmd([[colorscheme gruvbox]])
		vim.o.background = "dark" -- or "light" for light mode
	end,
}
