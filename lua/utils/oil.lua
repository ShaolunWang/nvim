_G.oil_win_id = nil
_G.oil_source_win = nil
function _G.get_oil_winbar()
	local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
	local dir = require('oil').get_current_dir(bufnr)
	if dir then
		return vim.fn.fnamemodify(dir, ':~')
	else
		-- If there is no current directory (e.g. over ssh), just show the buffer name
		return vim.api.nvim_buf_get_name(0)
	end
end

-- Function to toggle Oil in left vertical split
function _G.toggle_oil_split()
	if _G.oil_win_id and vim.api.nvim_win_is_valid(_G.oil_win_id) then
		vim.api.nvim_set_current_win(_G.oil_win_id)
		require('oil.actions').close.callback()
		vim.api.nvim_win_close(_G.oil_win_id, false)
		_G.oil_win_id = nil
	else
		_G.oil_source_win = vim.api.nvim_get_current_win()

		local width = math.floor(vim.o.columns * 0.2)
		vim.cmd('topleft ' .. width .. 'vsplit')
		_G.oil_win_id = vim.api.nvim_get_current_win()
		require('oil').open()
	end
end
