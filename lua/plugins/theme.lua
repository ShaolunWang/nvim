return {
  {
    'myagko/nymph.nvim',
    config = function()
    end,
  },
	--[[ {
		'EdenEast/nightfox.nvim',
		opts = {},
    lazy = true,
	}, ]]
	{
		'freddiehaddad/feline.nvim',
    lazy = true,
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
}
