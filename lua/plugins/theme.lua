return {
	--[[ {
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
	}, ]]
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
		'miikanissi/modus-themes.nvim',
		event = 'VeryLazy',
	},
	{
		'olivercederborg/poimandres.nvim',
	},
	{
		'echasnovski/mini.base16',
		dependencies = {
			'echasnovski/mini.colors',
			'echasnovski/mini.hues',
		},
		lazy = true,
	},
	{
		'neanias/everforest-nvim',
		config = function()
			require('everforest').setup({
				background = 'hard',
			})
		end,
	},
	{
      'sainnhe/edge',
      priority = 1000,
      config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        vim.g.edge_enable_italic = true
        vim.cmd.colorscheme('edge')
      end
	}

}
