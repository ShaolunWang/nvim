return {
	{
		'rebelot/kanagawa.nvim',
		opts = {
			compile = true,
		},
	},
	{ 'jacoborus/tender.vim' },
	{ 'EdenEast/nightfox.nvim' },
	{ 'nyoom-engineering/oxocarbon.nvim' },
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
		'rose-pine/neovim'
	}
}
