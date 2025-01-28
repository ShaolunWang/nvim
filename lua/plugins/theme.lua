local M = {}
M.plugins = {
	{ 'folke/tokyonight.nvim', opt = true },
	{ 'catppuccin/nvim', opt = true, as = 'catppuccin' },
	{ 'Mofiqul/vscode.nvim', opt = true },
	{ 'rebelot/kanagawa.nvim', opt = true },
	{ 'AlexvZyl/nordic.nvim', opt = true },
	{ 'tiagovla/scope.nvim', opt = true },
	{ 'rebelot/heirline.nvim', opt = true },
	{ 'ClearAspect/onehalf', opt = true, as = 'onehalf' },
}

function M.load()
	require('lze').load({
		{
			'tokyonight.nvim',
			colorscheme = 'tokyonight',
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
			'kanagawa',
			colorscheme = 'kanagawa',
		},

		{
			'nordic.nvim',
			colorscheme = 'nordic',
		},
		{
			'onehalf',
			colorscheme = { 'onehalfdark', 'onehalflight' },
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
