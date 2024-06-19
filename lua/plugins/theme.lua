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
	{ 'rebelot/heirline.nvim', event = 'VeryLazy' },
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
	{ 'pappasam/papercolor-theme-slim' },
	{
		'nyoom-engineering/oxocarbon.nvim',
	},
}
