local M = {}

M.bootstrap = function(lazy_path)
	if not vim.loop.fs_stat(lazy_path) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
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
	if cmds[current_index] == "nonu!" then signcolumn_setting = "yes:4" end
	vim.opt.signcolumn = signcolumn_setting
end

--- Toggle inlay hints
function M.toggle_inlay_hint()
	local is_enabled = vim.lsp.inlay_hint.is_enabled()
	vim.lsp.inlay_hint.enable(not is_enabled)
end

-- Custom formatting function for Lua
function M.custom_lua_format()
	local buf = vim.api.nvim_get_current_buf()
	local filepath = vim.api.nvim_buf_get_name(buf)

	-- Save the buffer before formatting
	vim.api.nvim_command("write")

	-- Execute lua-format command
	local cmd = string.format(
		"lua-format -i --indent-width=2 --no-use-tab --keep-simple-function-one-line --keep-simple-control-block-one-line --single-quote-to-double-quote --spaces-inside-table-braces --spaces-around-equals-in-field %s",
		filepath
	)
	os.execute(cmd)

	-- Reload the buffer to reflect the changes
	vim.api.nvim_command("edit")
end

return M
