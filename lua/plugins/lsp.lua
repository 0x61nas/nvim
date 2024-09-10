return {
	"neovim/nvim-lspconfig",
	opts = { inlay_hints = { enable = true } },
	lazy = false,
	keys = {
		{
			"gD",
			vim.lsp.buf.declaration,
			{ noremap = true, silent = true },
			desc = "Go To Declaration",
			mode = "n",
		},
		{
			"gd",
			vim.lsp.buf.definition,
			{ noremap = true, silent = true },
			desc = "Go To Definition",
			mode = "n",
		},
		{
			"gi",
			vim.lsp.buf.implementation,
			{ noremap = true, silent = true },
			desc = "Go To Implementation",
			mode = "n",
		},
		{ "K", vim.lsp.buf.hover, { silent = true }, desc = "Show Info", mode = "n" },
		{
			"<leader>ck",
			vim.lsp.buf.signature_help,
			{ silent = true, noremap = true },
			desc = "Show Signature",
			mode = "n",
		},
		{
			"<leader>r",
			vim.lsp.buf.rename,
			{ silent = true, noremap = true },
			desc = "Rename symbol",
			mode = "n",
		}, -- {
		--         "<leader>cf",
		--         vim.lsp.buf.format,
		--         {silent = true, noremap = true},
		--         desc = "Format",
		--         mode = "n"
		--     },
		{
			"<Leader>gr",
			vim.lsp.buf.references,
			{ noremap = true, silent = true },
			desc = "Go To References",
			mode = "n",
		},
		{
			"<Leader>D",
			vim.lsp.buf.type_definition,
			{ noremap = true, silent = true },
			desc = "Show Type Definition",
			mode = "n",
		},
		{
			"<Leader>ca",
			vim.lsp.buf.code_action,
			{ noremap = true, silent = true },
			desc = "Code actions",
		},
	},
	config = function()
		-- Setup language servers.
		local lspconfig = require("lspconfig")
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		-- Rust
		lspconfig.rust_analyzer.setup({
			capabilities = capabilities,
			autostart = true,
			settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
						loadOutDirsFromCheck = true,
						buildScripts = { enable = true },
					},
					assist = {
						-- Whether to insert #[must_use] when generating as_ methods for enum variants.
						emitMustUse = true,
					},
					imports = { group = { enable = false } },
					completion = { postfix = { enable = false } },
					-- Add clippy lints for Rust.
					checkOnSave = {
						allFeatures = true,
						command = "clippy",
						extraArgs = { "--no-deps" },
					},
					procMacro = {
						enable = true,
						ignored = {
							["async-trait"] = { "async_trait" },
							["napi-derive"] = { "napi" },
							["async-recursion"] = { "async_recursion" },
						},
					},
					hint = { enable = true },
				},
			},
		})

		-- assembly
		lspconfig.asm_lsp.setup({
			capabilities = capabilities,
			filetypes = { "asm", "vmasm", "nasm" },
			autostart = true,
			single_file_support = true,
			-- formatting
		})

		-- nix
		lspconfig.nil_ls.setup({
			capabilities = capabilities,
			autostart = true,
			settings = { ["nil"] = { formatting = { command = { "nixpkgs-fmt" } } } },
		})

		-- lua
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			autostart = true,
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					completion = { callSnippet = "Replace" },
					diagnostics = { globals = { "vim" } },
					format = { enable = false },
					hint = { enable = true },
				},
			},
		})

		lspconfig.gopls.setup({
			capabilities = capabilities,
			autostart = true,
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			single_file_support = true,
		})

		-- python
		lspconfig.ruff.setup({
			capabilities = capabilities,
			autostart = true,
			init_options = {
				settings = {
					lineLength = 120,
					lint = {
						enable = true,
						preview = true,
					},
					format = {
						preview = true,
					},
				},
			},
			single_file_support = true,
		})

		lspconfig.tsserver.setup({
			capabilities = capabilities,
			autostart = true,
			cmd = { "typescript-language-server", "--stdio" },
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
			init_options = { hostInfo = "neovim" },
			single_file_support = true,
		})

		lspconfig.gleam.setup({
			capabilities = capabilities,
			autostart = true,
			cmd = { "gleam", "lsp" },
			filetypes = { "gleam" },
			root_dir = lspconfig.util.root_pattern("gleam.toml", ".git"),
		})

		lspconfig.nil_ls.setup({
			capabilities = capabilities,
			autostart = true,
			cmd = { "nil" },
			filetypes = { "nix" },
			root_pattern = { "flake.nix", ".git" },
			single_file_support = true,
		})

		-- Zig
		lspconfig.zls.setup({
			capabilities = capabilities,
			autostart = true,
			cmd = { "zls" },
			filetypes = { "zig", "zir" },
			single_file_support = true,
		})

		-- Java
		-- lspconfig.java_language_server.setup {
		--   capabilities = capabilities,
		--
		--   autostart = true,
		--   single_file_support = true
		-- }
		lspconfig.jdtls.setup({
			capabilities = capabilities,
			autostart = true,
			single_file_support = true,
		})

		-- C/C++
		lspconfig.clangd.setup({
			capabilities = capabilities,
			autostart = true,
			single_file_support = true,
		})

		-- Kotlin
		lspconfig.kotlin_language_server.setup({
			capabilities = capabilities,
			autostart = true,
			single_file_support = true,
		})

		-- Bash LSP
		local configs = require("lspconfig.configs")
		if not configs.bash_lsp and vim.fn.executable("bash-language-server") == 1 then
			configs.bash_lsp = {
				capabilities = capabilities,
				autostart = true,
				default_config = {
					cmd = { "bash-language-server", "start" },
					filetypes = { "sh" },
					root_dir = require("lspconfig").util.find_git_ancestor,
					init_options = { settings = { args = {} } },
				},
			}
		end
		if configs.bash_lsp then lspconfig.bash_lsp.setup({}) end

		-- Grammar
		lspconfig.ltex.setup({
			capabilities = capabilities,
			autostart = true,
			filetypes = {
				"bib",
				"gitcommit",
				"markdown",
				"org",
				"plaintex",
				"rst",
				"rnoweb",
				"tex",
				"pandoc",
				"quarto",
				"rmd",
				"context",
				"html",
				"xhtml",
				"mail",
				"text",
			},
			single_file_support = true,
		})

		-- Dockerfile
		lspconfig.dockerls.setup({
			capabilities = capabilities,
			settings = {
				docker = {
					languageserver = { formatter = { ignoreMultilineInstructions = true } },
				},
			},
		})

		-- Docker compose
		lspconfig.docker_compose_language_service.setup({
			capabilities = capabilities,
			autostart = true,
			single_file_support = true,
			filetypes = { "yaml", "yaml.docker-compose" },
		})

		-- enable inlay hints
		vim.lsp.inlay_hint.enable()
	end,
}