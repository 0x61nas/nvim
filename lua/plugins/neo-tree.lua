return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	keys = {
		{
			"<leader>fe",
			function() require("neo-tree.command").execute({ toggle = true }) end,
			desc = "Explorer NeoTree (Root Dir)",
		},
		{
			"<leader>fE",
			function()
				require("neo-tree.command").execute({
					toggle = true,
					dir = vim.uv.cwd(),
				})
			end,
			desc = "Explorer NeoTree (cwd)",
		},
		{
			"<leader>e",
			"<leader>fe",
			desc = "Explorer NeoTree (Root Dir)",
			remap = true,
		},
		{
			"<leader>E",
			"<leader>fE",
			desc = "Explorer NeoTree (cwd)",
			remap = true,
		},
		{
			"<leader>ge",
			function()
				require("neo-tree.command").execute({
					source = "git_status",
					toggle = true,
				})
			end,
			desc = "Git Explorer",
		},
		{
			"<leader>be",
			function()
				require("neo-tree.command").execute({
					source = "buffers",
					toggle = true,
				})
			end,
			desc = "Buffer Explorer",
		},
	},
	deactivate = function() vim.cmd([[Neotree close]]) end,
	init = function()
		-- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
		-- because `cwd` is not set up properly.
		vim.api.nvim_create_autocmd("BufEnter", {
			group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
			desc = "Start Neo-tree with directory",
			once = true,
			callback = function()
				if package.loaded["neo-tree"] then
					return
				else
					local stats = vim.uv.fs_stat(vim.fn.argv(0))
					if stats and stats.type == "directory" then require("neo-tree") end
				end
			end,
		})
	end,
	opts = {
		sources = { "filesystem", "buffers", "git_status" },
		open_files_do_not_replace_types = {
			"terminal",
			"Trouble",
			"trouble",
			"qf",
			"Outline",
		},
		filesystem = {
			filtered_items = {
				visible = false, -- when true, they will just be displayed differently than normal items
				hide_dotfiles = false,
				hide_gitignored = true,
				hide_hidden = true, -- only works on Windows for hidden files/directories
				hide_by_name = {
					"node_modules",
				},
				hide_by_pattern = { -- uses glob style patterns
					-- "*.meta",
					-- "*/src/*/tsconfig.json",
				},
				always_show = { -- remains visible even if other settings would normally hide it
					".gitignored",
					".justfile",
				},
				-- uses glob style patterns
				always_show_by_pattern = { ".env*" },
				-- remains hidden even if visible is toggled to true, this overrides always_show
				never_show = {
					".DS_Store",
				},
			},
			follow_current_file = {
				enabled = false, -- This will find and focus the file in the active buffer every time
				--               -- the current file is changed while the tree is open.
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			},
			group_empty_dirs = true, -- when true, empty folders will be grouped together
			hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
			-- in whatever position is specified in window.position
			-- "open_current",  -- netrw disabled, opening a directory opens within the
			-- window like netrw would, regardless of window.position
			-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
			use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
		},
		enable_git_status = true,
		enable_diagnostics = true,
		window = {
			mappings = {
				["l"] = "open",
				["h"] = "close_node",
				["<space>"] = "none",
				["Y"] = {
					function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						vim.fn.setreg("+", path, "c")
						vim.notify("Path copyie to the system's clipboard")
					end,
					desc = "Copy Path to Clipboard",
				},
				["O"] = {
					function(state) require("lazy.util").open(state.tree:get_node().path, { system = true }) end,
					desc = "Open with System Application",
				},
				["P"] = { "toggle_preview", config = { use_float = false } },
			},
		},
		default_component_configs = {
			indent = {
				with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
			git_status = { symbols = { unstaged = "󰄱", staged = "󰱒" } },
		},
	},
	config = function(_, opts)
		local function on_move(data) vim.lsp.on_rename(data.source, data.destination) end

		local events = require("neo-tree.events")
		opts.event_handlers = opts.event_handlers or {}
		vim.list_extend(opts.event_handlers, {
			{ event = events.FILE_MOVED, handler = on_move },
			{ event = events.FILE_RENAMED, handler = on_move },
		})
		require("neo-tree").setup(opts)
		vim.api.nvim_create_autocmd("TermClose", {
			pattern = "*lazygit",
			callback = function()
				if package.loaded["neo-tree.sources.git_status"] then require("neo-tree.sources.git_status").refresh() end
			end,
		})
	end,
}
