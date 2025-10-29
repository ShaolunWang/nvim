local M = {}
M.plugins = {
	{ src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
	{ src = 'https://github.com/tiagovla/scope.nvim' },
	{ src = 'https://github.com/rebelot/heirline.nvim' },
	{ src = 'https://github.com/tiagovla/tokyodark.nvim', name = 'tokyodark' },
	{ src = 'https://github.com/WTFox/jellybeans.nvim', name = 'jellybean' },
	{ src = 'https://github.com/olimorris/onedarkpro.nvim', name = 'onedarkpro' },
	{ src = 'https://github.com/Shatur/neovim-ayu', name = 'ayu' },
	-- { 'OXY2DEV/ui.nvim', opt = true, as = 'ui_boilerplate' },
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
	})
end

return M
