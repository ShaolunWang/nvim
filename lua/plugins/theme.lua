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
	{ 'pappasam/papercolor-theme-slim' },
	--[[ {
		'neanias/everforest-nvim',
		config = function()
			require('everforest').setup({
				background = 'hard',
				transparent_background_level = 0,
				italics = true,
				disable_italic_comments = false,
				ui_contract = 'high',
			})
		end,
	}, ]]
	{
		'NTBBloodbath/doom-one.nvim',
	},
	-- Lazy
	{
		'tanvirtin/monokai.nvim',
	},
}
