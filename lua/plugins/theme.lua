return {
	{
		'myagko/nymph',
		branch = 'Neovim',
		config = function() end,
	},
	{
		'freddiehaddad/feline.nvim',
		lazy = true,
	},
	{
		'EdenEast/nightfox.nvim',
		opts = {},
	},
	{
		'freddiehaddad/feline.nvim',
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
