-- Global Settings And Remaps
require("settings")
require("keybinds")
require("autocommands")
if vim.g.neovide then require("neovide") end

vim.loader.enable()

require("core.opts")

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

require("core.utils").bootstrap(lazy_path)

return require("lazy").setup("plugins")
