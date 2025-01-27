return {
	{
		'tiagovla/scope.nvim',
		config = function()
			require('scope').setup()
		end,
	},
	{
		'rebelot/heirline.nvim',
		dependencies = {},
		event = 'VeryLazy',
	},
	{
		'yeomfa/jetly',
		event = 'VeryLazy',
	},
	{
		'folke/tokyonight.nvim',
		opts = {
			style = 'night',
		},
	},
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 1000,
	},
	{
		'hiphish/rainbow-delimiters.nvim',
		event = 'BufReadPre',
	},
	{
		'Mofiqul/vscode.nvim',
		event = 'VeryLazy',
	},
	{
		'rebelot/kanagawa.nvim',
	},
	{
		'p0209p/naysayer.vim',
		priority = 1000,
	},
	{
		'MikeWelsh801/eye-cancer.nvim',
		priority = 1000,
		dependencies = { 'rebelot/kanagawa.nvim' },
	},
	{
		'AlexvZyl/nordic.nvim',
	},
}
