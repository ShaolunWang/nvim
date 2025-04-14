local M = {}
M.plugins = {
	{ 'tiagovla/scope.nvim', opt = true },
	{ 'nvchad/ui' },
	-- { 'notken12/base46-colors' },
	{ 'nvchad/base46' },
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
		-- or just use Telescope themes
	})
end

return M
