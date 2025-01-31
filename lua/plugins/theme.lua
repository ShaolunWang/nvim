local M = {}
M.plugins = {
	{ 'folke/tokyonight.nvim', opt = true },
	{ 'catppuccin/nvim', opt = true, as = 'catppuccin' },
	{ 'Mofiqul/vscode.nvim', opt = true },
	{ 'tiagovla/scope.nvim', opt = true },
	{ 'rebelot/heirline.nvim', opt = true },
	{ 'navarasu/onedark.nvim', opt = true },
	{ 'tiagovla/tokyodark.nvim', opt = true, as = 'tokyodark' },
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
