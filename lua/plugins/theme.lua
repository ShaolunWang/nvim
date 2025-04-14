local M = {}
M.plugins = {
	{ 'folke/tokyonight.nvim', opt = true },
	{ 'catppuccin/nvim', opt = true, as = 'catppuccin' },
	{ 'Mofiqul/vscode.nvim', opt = true },
	{ 'tiagovla/scope.nvim', opt = true },
	{ 'rebelot/heirline.nvim', opt = true },
	{ 'tiagovla/tokyodark.nvim', opt = true, as = 'tokyodark' },
	{ 'WTFox/jellybeans.nvim', opt = true, as = 'jellybeans' },
	{ 'olimorris/onedarkpro.nvim', opt = true, as = 'onedarkpro' },
	{ 'oonamo/ef-themes.nvim', opt = true, as = 'ef' },
	{ 'Shatur/neovim-ayu', opt = true, as = 'ayu' },
	{ 'nvchad/ui' },
	{
		'nvchad/base46',
		build = function()
			require('base46').load_all_highlights()
		end,
	},
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
			'tokyonight.nvim',
			colorscheme = 'tokyonight',
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
		{
			'onedark.nvim',
			colorscheme = 'onedark',
			after = function()
				require('onedark').setup({
					style = 'cool',
				})
			end,
		},

		{
			'ef',
			colorscheme = {
				'ef-theme',
				'ef-arbutus',
				'ef-autumn',
				'ef-bio',
				'ef-cherie',
				'ef-cyprus',
				'ef-dark',
				'ef-day',
				'ef-deuteranopia-dark',
				'ef-deuteranopia-light',
				'ef-dream',
				'ef-duo-dark',
				'ef-duo-light',
				'ef-eagle',
				'ef-elea-dark',
				'ef-elea-light',
				'ef-frost',
				'ef-kassio',
				'ef-light',
				'ef-maris-dark',
				'ef-maris-light',
				'ef-melissa-dark',
				'ef-melissa-light',
				'ef-night',
				'ef-owl',
				'ef-reverie',
				'ef-rosa',
				'ef-spring',
				'ef-summer',
				'ef-symbiosis',
				'ef-trio-dark',
				'ef-trio-light',
				'ef-tritanopia-dark',
				'ef-tritanopia-light',
				'ef-winter',
			},
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
		-- 'nvim-lua/plenary.nvim',
		-- { 'nvim-tree/nvim-web-devicons', lazy = true },

		{
			'ui',
			beforeAll = function()
				require('nvchad')
			end,
		},

		{
			'base46',
			lazy = true,
			on_require = 'base46',
		},

		{ 'volt', on_require = 'volt' }, -- optional, needed for theme switcher
		-- or just use Telescope themes
	})
end

return M
