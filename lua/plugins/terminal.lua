return {
	{
		'akinsho/toggleterm.nvim',
		opts = {
			shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell',
			open_mapping = '<c-\\>',
		},
		keys = { '<c-\\>' },
	},
}
