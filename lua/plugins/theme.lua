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
		lazy = false,
	},
	{
		'MikeWelsh801/eye-cancer.nvim',
		priority = 1000,
		dependencies = { 'rebelot/kanagawa.nvim' },
	},
	{
		'cdmill/neomodern.nvim',
	},
	{
		'nvchad/ui',
		config = function()
			require('nvchad')
		end,
	},

	{
		'nvchad/base46',
		lazy = true,
		build = function()
			require('base46').load_all_highlights()
		end,
	},

	{ 'nvchad/volt' }, -- optional, needed for theme switcher
}
