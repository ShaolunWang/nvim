return {
	{
		'nanozuki/tabby.nvim',
		dependencies = {
			'tiagovla/scope.nvim',
		},
		event = 'VeryLazy',
		config = function()
			vim.opt.sessionoptions = { -- required
				'buffers',
				'tabpages',
				'globals',
			}
			require('scope').setup({})
			require('tabby').setup({})
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
	{ 'yorik1984/newpaper.nvim' },
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 1000,
	},
	{
		'hiphish/rainbow-delimiters.nvim',
	},
	{
		"neanias/everforest-nvim"
	}
}
