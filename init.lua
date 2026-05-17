-- ============================================================================
--    ___                            _     
--   / _ | ___  ___ ____   ___ _  __(_)_ _ 
--  / __ |/ _ \/ _ `(_-<_ / _ \ |/ / /  ' \
-- /_/ |_/_//_/\_,_/___(_)_//_/___/_/_/_/_/
--
-- ============================================================================

-- ============================================================================
-- BOOTSTRAP LAZY. NVIM (Plugin Manager)
-- ============================================================================
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazy_path,
  })
end
vim.opt.rtp: prepend(lazy_path)
-- ============================================================================
-- CORE SETTINGS
-- ============================================================================
vim.loader.enable()

-- I'm lazy
local opt = vim.opt

-- Nice Number Line
opt.relativenumber = true
opt.number = true

-- Tabs & Spaces
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.autoindent = true

-- Searching
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Column Settings
opt.signcolumn = "yes"
opt.colorcolumn = "120"
opt.wrap = false

-- Cursor Settings
opt.cursorline = true
opt.cursorcolumn = true
-- opt.guicursor =
-- "n-v-c-sm:block,ci-ve:ver25,r-cr-o:hor20,i:block-blinkoff1-blinkon1"

-- Window Settings
opt.splitbelow = true
opt.splitright = true
opt.lazyredraw = true
opt.showtabline = 0

-- Spelling
opt.spell = true
opt.spelloptions = "camel"

-- Other
opt.mouse = "a"
opt.showmode = false
opt.termguicolors = true
opt.hidden = true
opt.clipboard = "unnamedplus"
opt.formatoptions = "cjql"
opt.laststatus = 3
opt.completeopt = { "menu", "menuone", "preview" }
opt.conceallevel = 2
opt.concealcursor = ""
-- opt.updatetime = 100

-- Backup -- I have power issues :/
opt.backup = true
opt.swapfile = true
opt.undodir = os.getenv("HOME") .. "/.cache/undodir"
opt.undofile = true

-- arabic support
opt.encoding = "utf-8"
opt.termbidi = true

vim.opt.list = true
vim.opt.listchars = { eol = "$" }

vim.api.nvim_set_hl(0, "NonText", { fg = "#5c6370" })

-- ============================================================================
-- UTILITY FUNCTIONS
-- ============================================================================
local M = {}

M.bootstrap = function(lazy_path)
  if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazy_path,
    })
  end
  vim.opt.rtp:prepend(lazy_path)
end

local cmds = { "nu!", "rnu!", "nonu!" }
local current_index = 1

function M.toggle_numbering()
  current_index = current_index % #cmds + 1
  vim.cmd("set " .. cmds[current_index])
  local signcolumn_setting = "auto"
  if cmds[current_index] == "nonu!" then signcolumn_setting = "yes: 4" end
  vim.opt.signcolumn = signcolumn_setting
end

function M.custom_lua_format()
  local buf = vim.api.nvim_get_current_buf()
  local filepath = vim.api.nvim_buf_get_name(buf)
  vim.api.nvim_command("write")
  local cmd = string.format(
    "lua-format -i --indent-width=2 --no-use-tab --keep-simple-function-one-line --keep-simple-control-block-one-line --single-quote-to-double-quote --spaces-inside-table-braces --spaces-around-equals-in-field %s",
    filepath
  )
  os.execute(cmd)
  vim.api.nvim_command("edit")
end

-- ============================================================================
-- KEYBINDINGS
-- ============================================================================

local map = vim.keymap.set
local cmd = vim.cmd

-- Easy wq
cmd(":command! WQ wq")
cmd(":command! WQ wq")
cmd(":command! Wq wq")
cmd(":command! Wqa xall")
cmd(":command! Waq xall")
cmd(":command! WA wa")
cmd(":command! Wa wa")
cmd(":command! W w")
cmd(":command! Q q")

-- Set up <Space> to be the leader key
map("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.g.mapleader = " "

-- Easy :
map("n", ";", ":", { noremap = true })

-- Easy Resize
map("n", "<M-c>", ":vertical resize -2<CR>", { noremap = true })
map("n", "<M-k>", ":resize +2<CR>", { noremap = true })
-- map("n", "<M-k>", ":resize -2<CR>", {noremap = true})
map("n", "<M-d>", ":vertical resize +2<CR>", { noremap = true })

-- Easy Capitalization
map("n", "<F7>", "<Esc>V:s/\\v<(.)(\\w*)/\\u\\1\\L\\2/g<CR>:noh<CR>", {})
map("v", "<F7>", "<Esc>V:s/\\v<(.)(\\w*)/\\u\\1\\L\\2/g<CR>:noh<CR>", {})
map("i", "<F7>", "<Esc>V:s/\\v<(.)(\\w*)/\\u\\1\\L\\2/g<CR>:noh<CR>i", {})

-- The Best Thing In vscode But Better
map("v", "U", ":m '<-2<CR>gv=gv")
map("v", "Y", ":m '>+1<CR>gv=gv")

-- Replace The Current Word
-- map.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- The BEST MAP
map("x", "<Leader>p", '"_dP')

-- STOP USING THE ARROW KEYS !!
-- map('n', '<Up>', [[:echoerr "Do not do that!!"<cr>]], {noremap = true})
-- map('n', '<Down>', [[:echoerr "Do not do that!!"<cr>]], {noremap = true})
-- map('n', '<Left>', [[:echoerr "Do not do that!!"<cr>]], {noremap = true})
-- map('n', '<Right>', [[:echoerr "Do not do that!!"<cr>]], {noremap = true})

-- I use Dvorak layout, so.. no hjkl :|
-- Instead, I will use  -kcd
local modes = { "n", "v", "s", "o" } -- Normal, visual, select, operator-pending
local keys = { { "h", "-" }, { "j", "c" }, { "l", "d" } }
for _, mode in ipairs(modes) do
  for _, key in ipairs(keys) do
    map(mode, key[1], key[2], { noremap = true })
    map(mode, key[2], key[1], { noremap = true })
  end
end

-- Keybinds Reloading Init Files
map("n", "<Leader>vr", "<Cmd>luafile $MYVIMRC<CR>", { noremap = true })

-- Deleting Words With <C-Bs>
map("i", "", "<C-w>", { noremap = true, silent = true })
map("c", "", "<C-w>", { noremap = true, silent = true })
map("i", "<C-BS>", "<C-w>", { noremap = true, silent = true })
map("c", "<C-BS>", "<C-w>", { noremap = true })

-- Better Indent/Unintend Lines And Blocks Of Text
map("n", ">", ">>", { noremap = true, silent = true })
map("n", "<", "<<", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })
map("v", "<", "<gv", { noremap = true, silent = true })

-- Make Y Actually Make Sense
map("n", "Y", "yg$", { noremap = true, silent = true })

-- Buffer Navigation
map("n", "<Leader><Tab>", ":bn<CR>", { noremap = true, silent = true })
map("n", "<Leader><S-Tab>", ":bp<CR>", { noremap = true, silent = true })

-- Buffer Deletion
map("n", "<Leader>bd", ":bd<CR>", { noremap = true, silent = true })

-- Window Navigation
map("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
map("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
map("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
map("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Ctrl + W Close The Window
-- map('n', '<C-w>', ':bd!<CR>', { noremap = true, silent = true })
-- map('i', '<C-w>', ':bd!<CR>', { noremap = true, silent = true })

-- split
map("n", "<leader>wv", ":vsplit<CR>", { noremap = true })
map("n", "<leader>ws", ":split<CR>", { noremap = true })

-- Other
map("n", "<Leader>l", ":noh<CR>", { noremap = true }) -- Clear highlights
map("n", "<leader>o", ":pu =''<CR>", { noremap = true }) -- Insert a newline and back to normal mode
map("n", "<leader>O", ":pu! =''<CR>", { noremap = true }) -- Insert a newline and back to normal mode

-- Auto close parenthesis
local autopairs = {
  ["("] = ")",
  ["["] = "]",
  ["{"] = "}",
  ["<"] = ">",
}
for open, close in pairs(autopairs) do
  vim.keymap.set("i", open, function()
    return open .. close .. "<Left>"
  end, { expr = true, noremap = true })
end

-- ============================================================================
-- PLUGINS
-- ============================================================================
local plugins = {
  -- ========== Color Scheme ==========
  -- {
  --   "ptdewey/darkearth-nvim",
  --   priority = 1000,
  --   lazy = false,
  --   enabled = true,
  --   config = function()
  --     vim.cmd.colorscheme("darkearth")
  --   end,
  -- },
  -- ========== Completion ==========
   {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("snippets")
    end,
   },
   {
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
    },

  -- ========== UI & Navigation ==========
    {
      "nvim-lualine/lualine.nvim",
      opts = {
        options = {
          icons_enabled = true,
          theme = "gruvbox-material",
          component_separators = { left = "|", right = "|" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "NvimTree", "packer" },
          always_divide_middle = true,
          globalstatuses = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
            "diff",
          },
          lualine_c = { { "filename", file_status = true, path = 1 } },
          lualine_x = { "filetype" },
          lualine_y = { "%p%%", "location" },
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { "filename", file_status = true, path = 1 } },
          lualine_x = { "filetype" },
          lualine_y = { "%p%%", "location" },
          lualine_z = {},
        },
        tabline = {},
        extensions = { "fugitive", "fzf", "nvim-tree" },
      },
    },
  -- Neovim file explorer: edit your filesystem like a buffer
   {
      "stevearc/oil.nvim",
      opts = {},
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
      config = function()
        require("oil").setup({
          default_file_explorer = true,
          view_options = {
            show_hidden = true,
          },
          keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-s>"] = {
              "actions.select",
              opts = { vertical = true },
              desc = "Open the entry in a vertical split",
            },
            ["<C-h>"] = {
              "actions.select",
              opts = { horizontal = true },
              desc = "Open the entry in a horizontal split",
            },
            ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
            ["<C-p>"] = "actions.preview",
            ["q"] = "actions.close",
            ["<C-l>"] = "actions.refresh",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
            ["gs"] = "actions.change_sort",
            ["gx"] = "actions.open_external",
            ["g."] = "actions.toggle_hidden",
            ["g\\"] = "actions.toggle_trash",
          },
          float = {
            padding = 3,
            border = "rounded",
          },
        })
      end,
    },
    --
    {
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
   },
  -- ========== Linting ==========
  -- Lightweight yet powerful formatter plugin for Neovim
   {
      "stevearc/conform.nvim",
      lazy = true,
      -- event = { "BufWritePre" },
      cmd = { "ConformInfo" },
      keys = {
        {
          "<leader>cf",
          function() require("conform").format({ async = true }) end,
          mode = "",
          desc = "Format buffer",
        },
      },
      opts = {
        -- Map of filetype to formatters
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          go = { "goimports", "gofmt" },
          -- You can also customize some of the format options for the filetype
          rust = { "rustfmt", lsp_format = "fallback" },
          -- You can use a function here to determine the formatters dynamically
          python = function(bufnr)
            if require("conform").get_formatter_info("ruff_format", bufnr).available then
              return { "ruff_format" }
            else
              return { "isort", "black" }
            end
          end,
          nix = { "nixfmt" },
          ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
          ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
          -- Use the "*" filetype to run formatters on all filetypes.
          -- ["*"] = { "codespell" },
          -- Use the "_" filetype to run formatters on filetypes that don't
          -- have other format
          ["_"] = { "trim_whitespace" },
        },
        -- Set this to change the default values when calling conform.format()
        -- This will also affect the default values for format_on_save/format_after_save
        default_format_opts = { lsp_format = "fallback" },
        -- If this is set, Conform will run the formatter asynchronously after save.
        -- It will pass the table to conform.format().
        -- This can also be a function that returns the table.
        -- format_after_save = { lsp_format = "fallback" },
        -- Set the log level. Use `:ConformInfo` to see the location of the log file.
        log_level = vim.log.levels.ERROR,
        -- Conform will notify you when a formatter errors
        notify_on_error = true,
        -- Conform will notify you when no formatters are available for the buffer
        notify_no_formatters = true,
        -- Custom formatters and overrides for built-in formatters
        formatters = {
          stylua = {
            prepend_args = {
              "--call-parentheses",
              "Always",
              "--collapse-simple-statement",
              "Always",
              "--indent-type",
              "Tabs",
              "--indent-width",
              "2",
              "--sort-requires",
            },
          },
          ["markdown-toc"] = {
            condition = function(_, ctx)
              for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
                if line:find("<!%-%- toc %-%->") then return true end
              end
            end,
          },
          ["markdownlint-cli2"] = {
            condition = function(_, ctx)
              local diag = vim.tbl_filter(function(d) return d.source == "markdownlint" end, vim.diagnostic.get(ctx.buf))
              return #diag > 0
            end,
          },
        },
      },
   },

  -- ========== Navigation & Motion ==========
  {
    "ggandor/leap.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
    dependencies = { "tpope/vim-repeat" },
  },

  {
    "ggandor/flit.nvim",
    keys = function()
      local ret = {}
      for _, key in ipairs({ "f", "F", "t", "T" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
    dependencies = { "ggandor/leap.nvim" },
  },

  -- ========== Git & Tools ==========
  {
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
},
  --  Git source for nvim-cmp
  {
  "petertriho/cmp-git",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  init = function() table.insert(require("cmp").get_config().sources, { name = "git" }) end,
  config = function()
    local format = require("cmp_git.format")
    local sort = require("cmp_git.sort")

    require("cmp_git").setup({
      -- defaults
      filetypes = { "gitcommit", "octo" },
      remotes = { "upstream", "origin", "github", "gitlab", "codeberg" }, -- in order of most to least prioritized
      enableRemoteUrlRewrites = false, -- enable git url rewrites, see https://git-scm.com/docs/git-config#Documentation/git-config.txt-urlltbasegtinsteadOf
      git = {
        commits = {
          limit = 100,
          sort_by = sort.git.commits,
          format = format.git.commits,
        },
      },
      github = {
        hosts = {}, -- list of private instances of github
        issues = {
          fields = { "title", "number", "body", "updatedAt", "state" },
          filter = "all", -- assigned, created, mentioned, subscribed, all, repos
          limit = 100,
          state = "open", -- open, closed, all
          sort_by = sort.github.issues,
          format = format.github.issues,
        },
        mentions = {
          limit = 100,
          sort_by = sort.github.mentions,
          format = format.github.mentions,
        },
        pull_requests = {
          fields = { "title", "number", "body", "updatedAt", "state" },
          limit = 100,
          state = "open", -- open, closed, merged, all
          sort_by = sort.github.pull_requests,
          format = format.github.pull_requests,
        },
      },
      gitlab = {
        hosts = {}, -- list of private instances of gitlab
        issues = {
          limit = 100,
          state = "opened", -- opened, closed, all
          sort_by = sort.gitlab.issues,
          format = format.gitlab.issues,
        },
        mentions = {
          limit = 100,
          sort_by = sort.gitlab.mentions,
          format = format.gitlab.mentions,
        },
        merge_requests = {
          limit = 100,
          state = "opened", -- opened, closed, locked, merged
          sort_by = sort.gitlab.merge_requests,
          format = format.gitlab.merge_requests,
        },
      },
      trigger_actions = {
        {
          debug_name = "git_commits",
          trigger_character = ":",
          action = function(sources, trigger_char, callback, params, git_info)
            return sources.git:get_commits(callback, params, trigger_char)
          end,
        },
        {
          debug_name = "gitlab_issues",
          trigger_character = "#",
          action = function(sources, trigger_char, callback, params, git_info)
            return sources.gitlab:get_issues(callback, git_info, trigger_char)
          end,
        },
        {
          debug_name = "gitlab_mentions",
          trigger_character = "@",
          action = function(sources, trigger_char, callback, params, git_info)
            return sources.gitlab:get_mentions(callback, git_info, trigger_char)
          end,
        },
        {
          debug_name = "gitlab_mrs",
          trigger_character = "!",
          action = function(sources, trigger_char, callback, params, git_info)
            return sources.gitlab:get_merge_requests(callback, git_info, trigger_char)
          end,
        },
        {
          debug_name = "github_issues_and_pr",
          trigger_character = "#",
          action = function(sources, trigger_char, callback, params, git_info)
            return sources.github:get_issues_and_prs(callback, git_info, trigger_char)
          end,
        },
        {
          debug_name = "github_mentions",
          trigger_character = "@",
          action = function(sources, trigger_char, callback, params, git_info)
            return sources.github:get_mentions(callback, git_info, trigger_char)
          end,
        },
      },
    })
  end,
},
  -- ========== Language Support ==========
  {
    "NoahTheDuke/vim-just",
    ft = { "just" },
  },

  {
    "https://codeberg.org/ziglang/zig.vim",
    ft = { "zig" },
    init = function()
      vim.g.zig_fmt_autosave = 0
    end,
  },
  
  -- ========== Cosmetics & Utilities ==========
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    lazy = false,
    opts = {
      signs = true, -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        IMPORTANT = { icon = " ", color = "default", alt = { "IMPORT" } },
      },
      gui_style = {
        fg = "NONE", -- The gui style to use for the fg highlight group.
        bg = "BOLD", -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        multiline = true, -- enable multine todo comments
        multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 5, -- extra lines that will be re-evaluated when changing a line
        before = "", -- "fg" or "bg" or empty
        keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg", -- "fg" or "bg" or empty
        -- INFO: pattern or table of pattern to match
        -- INFO (anas): this
        pattern = [[.*<(KEYWORDS)\s*(.*)*\s*:]],
        -- pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
      },
      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" },
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      {
        "<leader>xT",
        "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
        desc = "Todo/Fix/Fixme (Trouble)",
      },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },
  -- Multiple cursors plugin for vim/neovim 
  {
    "mg979/vim-visual-multi",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-m>",
        ["Find Subword Under"] = "<C-m>",
      }
    end,
  },
  {
    "ggandor/leap.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
    dependencies = { "tpope/vim-repeat" },
  },
  {
    "mbbill/undotree",
    lazy = true,
    keys = {
      { "<Leader>u", ":UndotreeToggle<CR>", { noremap = true }, desc = "", mode = "n" },
    },
  },
  {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts_extend = { "spec" },
      opts = {
        defaults = {},
        spec = {
          {
            mode = { "n", "v" },
            { "<leader>b", group = "buffer" },
            { "<leader>bb", desc = "List buffers" },
            { "<leader>bd", desc = "Delete buffer" },
            { "<leader><Tab>", desc = "Next buffer" },
            { "<leader><S-Tab>", desc = "Previous buffer" },

            { "<leader>c", group = "code" },
            { "<leader>cf", desc = "Format buffer" },
            { "<leader>cs", desc = "Git status" },

            { "<leader>f", group = "find" },
            { "<leader>ff", desc = "Find files" },

            { "<leader>s", group = "search" },
            { "<leader>ss", desc = "Spell suggest" },

            { "<leader>v", group = "neovim" },
            { "<leader>vo", desc = "Options" },
            { "<leader>vr", desc = "Reload config" },

            { "<leader>w", group = "window", proxy = "<c-w>",
              expand = function() return require("which-key.extras").expand.win() end },
            { "<leader>wv", desc = "Vertical split" },
            { "<leader>ws", desc = "Horizontal split" },

            { "<leader>D", desc = "Diagnostics" },
            { "<leader>g", desc = "Live grep" },
            { "<leader>h", desc = "Help tags" },
            { "<leader>k", desc = "Keymaps" },
            { "<leader>l", desc = "Clear highlights" },
            { "<leader>o", desc = "Blank line below" },
            { "<leader>O", desc = "Blank line above" },
            { "<leader>p", desc = "Paste without yanking", mode = "x" },
            { "<leader>u", desc = "Undotree toggle" },
            { "<leader>?", desc = "Buffer keymaps" },

            { "[", group = "prev" },
            { "]", group = "next" },
            { "g", group = "goto" },
            { "gs", group = "leap/surround" },
            { "z", group = "fold" },
            { "s", desc = "Leap forward to" },
            { "S", desc = "Leap backward to" },
            { "gx", desc = "Open with system app" },
          },
        },
      },
      keys = {
        {
          "<leader>?",
          function() require("which-key").show({ global = false }) end,
          desc = "Buffer Keymaps (which-key)",
        },
        {
          "<c-w><space>",
          function() require("which-key").show({ keys = "<c-w>", loop = true }) end,
          desc = "Window Hydra Mode (which-key)",
        },
      },
      config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        if not vim.tbl_isempty(opts.defaults) then
          vim.notify("which-key: opts.defaults is deprecated. Please use opts.spec instead.", "error")
          wk.register(opts.defaults)
        end
      end,
  },
  "tpope/vim-fugitive",
  "ellisonleao/glow.nvim",
}

require("lazy").setup(plugins, {
  defaults = { lazy = false },
})

-- Theme
require("gruvbox").setup({
  transparent_mode = false,
})
vim.cmd.colorscheme("gruvbox")
vim.o.background = "dark"

-- We have comments.nvim at home
local comments = {
  lua = { line = "-- " },
  python = { line = "# " },
  sh = { line = "# " },
  bash = { line = "# " },
  zsh = { line = "# " },
  c = { line = "// " },
  cpp = { line = "// " },
  java = { line = "// " },
  javascript = { line = "// " },
  typescript = { line = "//" },
  rust = { line = "// " },
  css = { block = { "/* ", " */" } },
  html = { block = { "<!-- ", " -->" } },
  xml = { block = { "<!-- ", " -->" } },
  just = { line = "# " },
  tex = { line = "% " },
  zig = { line = "// " },
}

local function toggle_comment(s, e)
  if s > e then s, e = e, s end
  local cfg = comments[vim.bo.filetype]
  if not cfg then return end
  local p = cfg.line
  if not p then return end

  local all = true
  for i = s, e do
    local t = vim.fn.getline(i):match("^%s*(.-)%s*$")
    if t ~= "" and t:sub(1, #p) ~= p then all = false; break end
  end

  for i = s, e do
    local line = vim.fn.getline(i)
    local t = line:match("^%s*(.-)%s*$")
    if t ~= "" then
      local indent = line:match("^%s*")
      if all then
        local rest = line:match("^%s*" .. vim.pesc(p) .. "(.*)$") or ""
        vim.fn.setline(i, indent .. rest)
      elseif t:sub(1, #p) ~= p then
        local sp = p:match("%s$") and "" or " "
        vim.fn.setline(i, indent .. p .. sp .. line:sub(#indent + 1))
      end
    end
  end
end

vim.keymap.set("n", "<C-_>", function()
  toggle_comment(vim.fn.line("."), vim.fn.line("."))
end)

_G.ToggleComment = function()
  local s = vim.api.nvim_buf_get_mark(0, "<")[1]
  local e = vim.api.nvim_buf_get_mark(0, ">")[1]
  if s > 0 and e > 0 then toggle_comment(s, e) end
end

vim.keymap.set("x", "<C-_>", "<ESC><CMD>lua _G.ToggleComment()<CR>")

-- ============================================================================
-- NEOVIDE CONFIGURATION
-- ============================================================================
if vim.g.neovide then
  vim.o.guifont = "JetBrains_Mono,Noto_Color_Emoji,Noto_Kufi_Arabic: h10"
end

-- ============================================================================
-- AUTOCOMMANDS
-- ============================================================================
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api. nvim_create_autocmd

-- Groff
local groff = augroup("groff", {})
autocmd("BufWritePost", {
  pattern = { "*.ms" },
  command = "silent ! pdfroff -ms % -e -t -p > %: r.pdf",
  group = groff,
})

-- Indentation
local indention = augroup("indentaion", {})
autocmd("FileType", {
  pattern = {
    "html",
    "htmldjango",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "nix",
    "typescriptreact",
    "lua",
    "markdown",
    "jinja",
    "html. mustache",
    "html.handlebars",
    "prisma",
  },
  command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2",
  group = indention,
})

-- Highlight yanked text
local highlightYank = augroup("highlightYank", {})
autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank({ higroup = "Visual", timeout = 300 }) end,
  group = highlightYank,
})

-- Center Screen On Insert
local centerScreen = augroup("centerScreen", {})
autocmd("InsertEnter", { pattern = "*", command = "norm zz", group = centerScreen })

-- Opens PDF/Media files in PDFVIWER/BROWSER instead of viewing binary
local openMediaFiles = augroup("openMediaFiles", {})
autocmd("BufReadPost", {
  pattern = { "*.pdf" },
  callback = function()
    local command
    if pcall(os.getenv("PDFVIWER")) then
      command = os.getenv("PDFVIWER")
    else
      command = os.getenv("BROWSER")
    end
    vim.fn.jobstart(string.format("%s '%s'", command, vim.fn.expand("%")), { detach = true })
    vim.api.nvim_buf_delete(0, {})
  end,
  group = openMediaFiles,
})

autocmd("BufReadPost", {
  pattern = { "*.png", "*.webp", "*.jpg", "*. jpeg", "*.mp4" },
  callback = function()
    local command = os.getenv("BROWSER")
    vim.fn.jobstart(string. format("%s '%s'", command, vim.fn.expand("%")), { detach = true })
    vim.api.nvim_buf_delete(0, {})
  end,
  group = openMediaFiles,
})

-- restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, { row, col })
    end
  end,
})

-- make sure viminfo/shada is enabled
vim.opt.shada = "!,'100,<50,s10,h"

-- EOF
