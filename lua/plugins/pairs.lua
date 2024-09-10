return {
	"steelsojka/pears.nvim",
	lazy = false,
	config = function()
		require("pears").setup(function(conf)
			conf.preset("tag_matching")
			conf.expand_on_enter(true)
			conf.on_enter(function(pears_handle)
				if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
					vim.cmd([[:startinsert | call feedkeys("\<c-y>")]])
				else
					pears_handle()
				end
			end)
		end)
	end,
}
