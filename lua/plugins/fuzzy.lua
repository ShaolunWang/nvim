local M = {}
M.plugins = {
	{ 'nanotee/zoxide.vim', opt = true },
	{ '2KAbhishek/pickme.nvim', opt = true },
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
		{
			'pickme.nvim',
			on_require = { 'pickme' },
			cmd = { 'PickMe' },
			after = function()
				require('pickme').setup({
					pick_provider = 'snacks',
					add_default_keybindings = false,
				})
			end,
		},
	})
end

return M
