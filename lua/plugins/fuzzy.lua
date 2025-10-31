local M = {}
M.plugins = {
	{ src = 'https://github.com/nanotee/zoxide.vim' },
	{ src = 'https://github.com/2KAbhishek/pickme.nvim' },
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
