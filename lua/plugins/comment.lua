return {
	"numToStr/Comment.nvim",
	init = function() require("ts_context_commentstring").setup({}) end,
	config = function()
		require("Comment").setup({
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
	lazy = true,
	event = "VeryLazy",
	keys = {
		{
			"<C-_>",
			":lua require('Comment.api').toggle.linewise.current()<CR>",
			{ noremap = true, silent = true },
			desc = "",
			mode = "n",
		},
		{
			"<C-_>",
			'<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
			{ noremap = true, silent = true },
			desc = "",
			mode = "x",
		},
		{
			"<C-_>",
			":lua require('Comment.api').toggle.linewise.current() <CR>",
			{ noremap = true, silent = true },
			desc = "",
			mode = "i",
		}, -- same as above but fixes some weird issues
		{
			"<C-/>",
			":lua require('Comment.api').toggle.linewise.current()<CR>",
			{ noremap = true, silent = true },
			desc = "",
			mode = "n",
		},
		{
			"<C-/>",
			'<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
			{ noremap = true, silent = true },
			desc = "",
			mode = "x",
		},
		{
			"<C-/>",
			":lua require('Comment.api').toggle.linewise.current() <CR>",
			{ noremap = true, silent = true },
			desc = "",
			mode = "i",
		},
	},
	dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
}
