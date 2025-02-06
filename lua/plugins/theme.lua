local M = {}
M.plugins = {
	{ 'folke/tokyonight.nvim', opt = true },
	{ 'catppuccin/nvim', opt = true, as = 'catppuccin' },
	{ 'Mofiqul/vscode.nvim', opt = true },
	{ 'tiagovla/scope.nvim', opt = true },
	{ 'rebelot/heirline.nvim', opt = true },
	{ 'tiagovla/tokyodark.nvim', opt = true, as = 'tokyodark' },
	{ 'nickkadutskyi/jb.nvim', opt = true, as = 'jb' },
	{ 'WTFox/jellybeans.nvim', opt = true, as = 'jellybeans' },
	{ 'olimorris/onedarkpro.nvim', opt = true, as = 'onedarkpro' },
}

function M.load()
	require('lze').load({
		{
			'onedarkpro',
			colorscheme = { 'onedark', 'onelight', 'onedark_dark', 'onedark_vivid' },
		},
		{
			'jb',
			colorscheme = 'jb',
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
