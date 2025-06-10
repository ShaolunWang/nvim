local M = {}
M.plugins = {
	{ 'catppuccin/nvim', opt = true, as = 'catppuccin' },
	{ 'tiagovla/scope.nvim', opt = true },
	{ 'rebelot/heirline.nvim', opt = true },
	{ 'tiagovla/tokyodark.nvim', opt = true, as = 'tokyodark' },
	{ 'WTFox/jellybeans.nvim', opt = true, as = 'jellybeans' },
	{ 'olimorris/onedarkpro.nvim', opt = true, as = 'onedarkpro' },
	{ 'Shatur/neovim-ayu', opt = true, as = 'ayu' },
	{ 'OXY2DEV/ui.nvim', opt = true, as = 'ui_boilerplate' },
}

function M.load()
	require('lze').load({
		{
			'ayu',
			after = function()
				require('ayu').setup({
					mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
					terminal = true, -- Set to `false` to let terminal manage its own colors.
					overrides = {}, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
				})
			end,
			colorscheme = { 'ayu', 'ayu-light', 'ayu-mirage', 'ayu-dark' },
		},
		{
			'onedarkpro',
			colorscheme = { 'onedark', 'onelight', 'onedark_dark', 'onedark_vivid' },
		},
		{
			'jellybeans',
			after = function()
				require('jellybeans').setup()
			end,
			colorscheme = 'jellybeans',
		},
		{
			'catppuccin',
			colorscheme = 'catppuccin',
		},
		{
			'vscode.nvim',
			colorscheme = 'vscode',
		},
		{
			'tokyodark',
			colorscheme = 'tokyodark',
		},
	})
	require('lze').load({
		{
			'scope.nvim',
			after = function()
				require('scope').setup()
			end,
			lazy = false,
		},
		{
			'heirline.nvim',
			lazy = false,
		},
		{

			'ui_boilerplate',
			after = function()
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
			end,
		},
	})
end

return M
