-- Global Settings And Remaps
require("autocommands")
if vim.g.neovide then require("neovide") end

vim.loader.enable()

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

require("core.utils").bootstrap(lazy_path)
require("keybinds")
require("settings")

return require("lazy").setup("plugins")
