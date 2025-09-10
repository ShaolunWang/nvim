local M = {}
M.plugins = {
	{ src = 'https://github.com/akinsho/toggleterm.nvim' },
}
function M.load()
	require('lze').load({
		{
			'toggleterm.nvim',
			after = function()
				require('toggleterm').setup({
					shell = vim.fn.executable('pwsh') == 1 or vim.o.shell,
					open_mapping = '<c-s>',
				})
			end,
			keys = { '<c-s>' },
		},
	})
end
return M
