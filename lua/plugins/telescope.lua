return {
	"nvim-telescope/telescope.nvim",
	lazy = false,
	keys = {
		{
			"<Leader>ff",
			":lua require('telescope.builtin').find_files()<CR>",
			{ noremap = true, silent = true },
			desc = "Find Files",
		},
		{
			"<Leader>bb",
			":lua require('telescope.builtin').buffers()<CR>",
			{ noremap = true, silent = true },
			desc = "Buffers",
		},
		{
			"<Leader>g",
			":lua require('telescope.builtin').live_grep()<CR>",
			{ noremap = true, silent = true },
			desc = "Live Grep",
		},
		{
			"<Leader>h",
			":lua require('telescope.builtin').help_tags()<CR>",
			{ noremap = true, silent = true },
			desc = "Help Tags",
		},
		{
			"<Leader>ss",
			":lua require('telescope.builtin').spell_suggest()<CR>",
			{ noremap = true, silent = true },
			desc = "Spell Suggest",
		},
		{
			"<Leader>k",
			":lua require('telescope.builtin').keymaps()<CR>",
			{ noremap = true, silent = true },
			desc = "Show Key Maps",
		},
		{
			"<Leader>vo",
			":lua require('telescope.builtin').vim_options()<CR>",
			{ noremap = true, silent = true },
			desc = "Neovim Options",
		},
		{
			"<Leader>D",
			":lua require('telescope.builtin').diagnostics()<CR>",
			{ noremap = true, silent = true },
			desc = "Diagnostics",
		},
		{
			"<Leader>cs",
			":lua require('telescope.builtin').git_status()<CR>",
			{ noremap = true, silent = true },
			desc = "Git Status",
		},
	},
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim" },
		-- ripgrep needs to be installed on the system 'pacman -S ripgrep'
	},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = { mappings = { i = { ["<esc>"] = actions.close } } },
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})
	end,
}
