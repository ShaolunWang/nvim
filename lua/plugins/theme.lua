local M = {}
M.plugins = {
	{ 'tiagovla/scope.nvim', opt = true },
	{ 'nvchad/ui' },
	{ 'nvchad/base46', branch = 'v3.0' },
	{ 'nvzone/volt' },
}

function M.load()
	require('lze').load({
		{
			'scope.nvim',
			after = function()
				require('scope').setup()
			end,
			lazy = false,
		},
		{
			'ui',
			beforeAll = function()
				require('nvchad')
			end,
			event = 'DeferredUIEnter',
		},
		{
			'base46',
			dep_of = 'ui',
			after = function()
				require('base46').load_all_highlights()
			end,
		},

		{ 'volt', dep_of = 'ui' }, -- optional, needed for theme switcher
	})
end

return M
