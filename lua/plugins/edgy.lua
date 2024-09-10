return {
	"folke/edgy.nvim",
	event = "VeryLazy",
	init = function()
		vim.opt.laststatus = 3
		vim.opt.splitkeep = "screen"
	end,
	opts = {
		bottom = {
			-- toggleterm / lazyterm at the bottom with a height of 40% of the screen
			"Trouble",
			{ ft = "qf", title = "QuickFix" },
			{
				ft = "help",
				size = { height = 20 },
				-- only show help buffers
				filter = function(buf) return vim.bo[buf].buftype == "help" end,
			},
			{ ft = "spectre_panel", size = { height = 0.4 } },
		},
		left = {
			-- Neo-tree filesystem always takes half the screen height
			{
				title = "Neo-Tree",
				ft = "neo-tree",
				filter = function(buf) return vim.b[buf].neo_tree_source == "filesystem" end,
				size = { height = 0.5 },
			},
			{
				title = "Neo-Tree Git",
				ft = "neo-tree",
				filter = function(buf) return vim.b[buf].neo_tree_source == "git_status" end,
				pinned = true,
				collapsed = true, -- show window as closed/collapsed on start
				open = "Neotree position=right git_status",
			},
			{
				title = "Neo-Tree Buffers",
				ft = "neo-tree",
				filter = function(buf) return vim.b[buf].neo_tree_source == "buffers" end,
				pinned = true,
				collapsed = true, -- show window as closed/collapsed on start
				open = "Neotree position=top buffers",
			},
			{
				title = function()
					local buf_name = vim.api.nvim_buf_get_name(0) or "[No Name]"
					return vim.fn.fnamemodify(buf_name, ":t")
				end,
				ft = "Outline",
				pinned = true,
				open = "SymbolsOutlineOpen",
			}, -- any other neo-tree windows
			"neo-tree",
		},
		right = {
			{
				title = "copilot-chat",
				ft = "markdown",
				direction = "vertical",
				size = { width = 0.36 },
				filter = function(buf, win) return vim.api.nvim_win_get_config(win).relative == "" end,
			},
		},
	},
}
