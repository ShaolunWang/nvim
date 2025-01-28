local M = {}
M.plugins = {
	{ 'folke/tokyonight.nvim', opt = true },
	{ 'catppuccin/nvim',       opt = true },
	{ 'Mofiqul/vscode.nvim',   opt = true },
	{ 'rebelot/kanagawa.nvim', opt = true },
	{ 'AlexvZyl/nordic.nvim',  opt = true },
	{ 'tiagovla/scope.nvim',   opt = true },
	{ 'rebelot/heirline.nvim', opt = true },
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


	})
	require('lze').load({ {
		'scope.nvim',
		after = function()
			require('scope').setup()
		end,
	},
		{
			'heirline.nvim',
		},
	}, {lazy = false})
end

return M
