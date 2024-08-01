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
	},
	{
		'miikanissi/modus-themes.nvim',
		priority = 1000,
		opts = {
			-- Default options
			-- Theme comes in two styles `modus_operandi` and `modus_vivendi`
			-- `auto` will automatically set style based on background set with vim.o.background
			style = 'auto',
			variant = 'tritanopia', -- Theme comes in four variants `default`, `tinted`, `deuteranopia`, and `tritanopia`
			transparent = false, -- Transparent background (as supported by the terminal)
			styles = {
				-- Style to be applied to different syntax groups
				-- Value is any valid attr-list value for `:help nvim_set_hl`
				comments = { italic = true },
				keywords = { italic = true },
				functions = {},
				variables = {},
			},
		},
	},
	{
		'NTBBloodbath/doom-one.nvim',
	},
}
