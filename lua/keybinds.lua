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
