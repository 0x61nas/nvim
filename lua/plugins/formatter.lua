-- Format On Save
local formatCode = vim.api.nvim_create_augroup("formatCode ", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*" },
	command = "silent FormatWrite",
	group = formatCode,
})

-- local function prettier_tailwindcss()
--   local util = require 'formatter.util'
--   return {
--     exe = "prettier",
--     args = {
--       "--stdin-filepath", util.escape_path(util.get_current_buffer_file_path()),
--       "--plugin",
--       '~/.local/share/npm/lib/node_modules/prettier-plugin-tailwindcss/dist/index.mjs'
--     },
--     stdin = true,
--     try_node_modules = true
--   }
-- end

-- local function jinja2_formatter()
--   -- prettier-plugin-jinja-template
--   local util = require 'formatter.util'
--   return {
--     exe = "prettier",
--     args = {
--       "--stdin-filepath", util.escape_path(util.get_current_buffer_file_path()),
--       "--plugin",
--       '~/.local/share/npm/lib/node_modules/prettier-plugin-jinja-template/lib/index.js',
--       "--plugin",
--       '~/.local/share/npm/lib/node_modules/prettier-plugin-tailwindcss/dist/index.mjs'
--
--     },
--     stdin = true,
--     try_node_modules = true
--   }
-- end

-- Provides the Format and FormatWrite commands
return {
	"mhartington/formatter.nvim",
	lazy = true,
	keys = {
		{
			"<Leader>F",
			":FormatWrite<CR>",
			{ noremap = true },
			desc = "Format And Save",
		},
	},
	cmd = { "Format", "FormatWrite" },
	config = function()
		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = {
				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
					function()
						-- Ignore already configured types.
						local defined_types = require("formatter.config").values.filetype
						if defined_types[vim.bo.filetype] ~= nil then return nil end
						vim.lsp.buf.format()
					end,
				},
				c = { require("formatter.filetypes.c").clangformat },
				cpp = { require("formatter.filetypes.cpp").clangformat },
				cs = { require("formatter.filetypes.cs").clangformat },
				css = { require("formatter.filetypes.css").prettierd },
				html = { require("formatter.filetypes.html").prettierd },
				-- jinja = { jinja2_formatter },
				javascript = { require("formatter.filetypes.javascript").prettierd },
				javascriptreact = {
					require("formatter.filetypes.javascriptreact").prettier,
				},
				json = { require("formatter.filetypes.json").prettierd },
				lua = { require("formatter.filetypes.lua").luaformat },
				markdown = { require("formatter.filetypes.css").prettierd },
				nix = { require("formatter.filetypes.nix").nixpkgs_fmt },
				kotlin = { require("formatter.filetypes.kotlin").ktlint },
				python = {
					function()
						return {
							exe = "black",
							args = { "--line-length 120", "-q", "-" },
							stdin = true,
						}
					end,
				},
				rust = { require("formatter.filetypes.rust").rustfmt },
				toml = { require("formatter.filetypes.toml").taplo },
				typescript = { require("formatter.filetypes.typescript").prettierd },
				typescriptreact = {
					require("formatter.filetypes.typescriptreact").prettierd,
				},
				xml = { require("formatter.filetypes.css").prettierd },
				yaml = { require("formatter.filetypes.yaml").prettierd },
			},
		})
	end,
}
