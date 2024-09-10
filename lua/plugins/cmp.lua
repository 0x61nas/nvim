return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		-- 'hrsh7th/cmp-path',
		"https://codeberg.org/FelipeLema/cmp-async-path",
		"hrsh7th/cmp-cmdline",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
	},
	event = { "LspAttach", "InsertCharPre" },
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function(args) require("luasnip").lsp_expand(args.body) end,
			},
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-;>"] = cmp.mapping.abort(),
				["<C-k>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

				["<C-g>"] = cmp.mapping(function()
					if not cmp.visible() then cmp.complete() end
					cmp.abort()
				end, { "i", "s" }),
				["<c-y>"] = cmp.mapping(function(fallback)
					if not cmp.visible() then fallback() end
					cmp.scroll_docs(-1)
				end, { "i", "s" }),
				["<c-e>"] = cmp.mapping(function(fallback)
					if not cmp.visible() then fallback() end
					cmp.scroll_docs(1)
				end, { "i", "s" }),
				["<c-p>"] = cmp.mapping(function(fallback)
					if not cmp.visible() then fallback() end
					cmp.select_prev_item()
				end, { "i", "s" }),
				["<c-n>"] = cmp.mapping(function(fallback)
					if not cmp.visible() then fallback() end
					cmp.select_next_item()
				end, { "i", "s" }),
				["<cr>"] = cmp.mapping(function(fallback)
					if cmp.get_selected_entry() == nil then fallback() end
					cmp.confirm()
				end, { "i", "s" }),
			}),

			sources = cmp.config.sources({
				{ name = "async_path", max_item_count = 20 },
				{
					name = "nvim_lsp",
					max_item_count = 80,
				},
				{
					name = "buffer",
					max_item_count = 20,
					option = {
						get_bufnrs = function()
							return vim.tbl_map(function(win) return vim.api.nvim_win_get_buf(win) end, vim.api.nvim_list_wins())
						end,
					},
				},
				{ name = "luasnip" }, -- For luasnip users.
				-- { name = 'ultisnips' }, -- For ultisnips users.
				-- { name = 'snippy' }, -- For snippy users.
				-- { name = 'crates' },
			}),
			-- eof
		})

		-- Set configuration for specific filetype.
		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
			}, {
				{ name = "buffer" },
			}),
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})
	end,
}
