require('lze').load({
	{
		'folke/tokyonight.nvim',
		opts = {
			style = 'night',
		},
		colorscheme = 'tokyonight',
	},
	{
		'catppuccin/nvim',
		colorscheme = 'catppuccin',
	},
	{
		'Mofiqul/vscode.nvim',
		colorscheme = 'vscode',
	},
	{
		'rebelot/kanagawa.nvim',
		colorscheme = 'kanagawa',
	},

	{
		'AlexvZyl/nordic.nvim',
		colorscheme = 'nordic',
	},
})
require('plugins.luasnip').load()
require('plugins.lsp').load()
require('plugins.completion').load()
