local M = {}
M.plugins = {
	{ 'akinsho/toggleterm.nvim', opt = true },
}
function M.load()
	require('lze').load({
		{
			'toggleterm.nvim',
			after = function()
				require('toggleterm').setup({
					shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell' or vim.o.shell,
					open_mapping = '<c-s>',
				})
			end,
			keys = { '<c-s>' },
		},
	})
end
return M
