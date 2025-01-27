return {
	{
		'tiagovla/scope.nvim',
		config = function()
			require('scope').setup()
		end,
		lazy = true,
	},
	{
		'rebelot/heirline.nvim',
		dependencies = {},
		event = 'VeryLazy',
		lazy = true,
	},
	{
		'yeomfa/jetly',
		lazy = true,
	},
	{
		'folke/tokyonight.nvim',
		opts = {
			style = 'night',
		},
		lazy = true,
	},
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 1000,
		lazy = true,
	},
	{
		'hiphish/rainbow-delimiters.nvim',
		event = 'BufReadPre',
	},
	{
		'Mofiqul/vscode.nvim',
		lazy = true,
	},
	{
		'rebelot/kanagawa.nvim',
		lazy = true,
	},
	{
		'AlexvZyl/nordic.nvim',
		lazy = true,
	},
}
