local M = {}
M.plugins = {
	{ 'nanotee/zoxide.vim', opt = true },
}
function M.load()
	require('lze').load({
		{
			'zoxide.vim',
			after = function()
				vim.g.zoxide_use_select = 1
			end,
			cmd = { 'Z', 'LZ', 'Zi', 'Tz', 'Lzi', 'Tzi' },
		},
	})
end

return M
