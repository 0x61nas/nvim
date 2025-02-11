return {
	"saecki/crates.nvim",
	tag = "stable",
	event = { "BufRead Cargo.toml" },
	config = function()
		require("crates").setup()
		vim.api.nvim_create_autocmd("BufRead", {
			group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
			pattern = "Cargo.toml",
			callback = function() cmp.setup.buffer({ sources = { { name = "crates" } } }) end,
		})
	end,
}
