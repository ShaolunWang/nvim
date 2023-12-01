return {
	{
		'EdenEast/nightfox.nvim',
		opts = {},
	},
	{
		'neanias/everforest-nvim',
		config = function()
			require('everforest').setup({})
		end,
	},
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
}
