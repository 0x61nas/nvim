-- I'm lazy
local opt = vim.opt

-- Nice Number Line
opt.relativenumber = true
opt.number = true

-- Tabs & Spaces
opt.expandtab = false
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
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
-- opt.guicursor = "n-v-c-sm:block,ci-ve:ver25,r-cr-o:hor20,i:underline" ..
--                     ",a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor" ..
--                     ",sm:block-blinkwait175-blinkoff150-blinkon175"

-- Window Settings
opt.splitbelow = true
opt.splitright = true
opt.lazyredraw = true
opt.showtabline = 2

-- Spelling
opt.spell = true
opt.spelloptions = "camel"

-- Other
opt.mouse = "a"
opt.showmode = false
opt.termguicolors = true
opt.hidden = true
-- opt.clipboard = "unnamedplus"
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
