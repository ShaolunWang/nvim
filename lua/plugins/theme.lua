local M = {}
M.plugins = {
	{ 'tiagovla/scope.nvim', opt = true },
	{ 'nvchad/ui' },
	-- { 'OXY2DEV/ui.nvim', as = 'ui_boilerplate' },
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
		--[[ {
			'ui_boilerplate',
			after = function()
				if not vim.g.vscode then
					require('ui').setup({
						popupmenu = {
							enable = false,
						},

						cmdline = {
							enable = true,
							styles = {
								default = {
									cursor = 'Cursor',
									filetype = 'vim',

									icon = { { 'I ', '@comment' } },
									offset = 0,

									title = nil,
									winhl = '',
								},
							},
						},
					})
				end
			end,
		}, ]]
	})
end

return M
