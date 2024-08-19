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
		event = 'BufReadPre',
	},
	{
		'neanias/everforest-nvim',
		event = 'VeryLazy',
	},
	{
		'projekt0n/github-nvim-theme',
		event = 'VeryLazy',
	},
	{
		'Mofiqul/vscode.nvim',
		event = 'VeryLazy',
	},
	{
		'miikanissi/modus-themes.nvim',
		event = 'VeryLazy',
	},

	{
		'olivercederborg/poimandres.nvim',
	},
	{
		'rose-pine/neovim',
		name = 'rose-pine',
		config = function()
			require('rose-pine').setup({
			})
		end,
	},
}
