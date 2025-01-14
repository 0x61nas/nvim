return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	init = function()
		require("gitsigns").setup({
			attach_to_untracked = false,
			current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 200,
				ignore_whitespace = false,
				virt_text_priority = 100,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			-- current_line_blame_formatter_opts = {
			--   relative_time = false,
			-- },
		})
	end,
}
