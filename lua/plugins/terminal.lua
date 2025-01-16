return {
	{
		'akinsho/toggleterm.nvim',
		opts = {
			shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell' or vim.o.shell,
			open_mapping = '<c-s>',
		},
		keys = { '<c-s>' },
	},
}
