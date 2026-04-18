local M = {}
M.plugins = {
	{ src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
	{ src = 'https://github.com/tiagovla/scope.nvim' },
	{ src = 'https://github.com/sschleemilch/slimline.nvim' },
	{ src = 'https://github.com/tiagovla/tokyodark.nvim', name = 'tokyodark' },
	{ src = 'https://github.com/AvengeMedia/base46', name = 'base46' },
	{ src = 'https://github.com/folke/tokyonight.nvim', name = 'tokyonight' },
	{ src = 'https://github.com/Mofiqul/vscode.nvim', name = 'vscode' },
}

function M.load()
	require('lze').load({
		{
			'base46',
			after = function()
				require("base46").setup()
			end
		},
		{ 'vscode', colorscheme = { 'vscode' } },
		{
			'tokyonight',
			colorscheme = 'tokyonight',
			after = function()
				require('tokyonight').setup()
			end,
		},
		{
			'catppuccin',
			colorscheme = { 'catppuccin', 'catppuccin-latte', 'catppuccin-frappe', 'catppuccin-mocha' },
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
			'slimline.nvim',
			after = function()
				require('slimline').setup({
					style = 'fg',
					bold = true,
					configs = {
						path = {
							hl = {
								primary = 'Label',
							},
						},
						git = {
							hl = {
								primary = 'Function',
							},
						},
						filetype_lsp = {
							hl = {
								primary = 'String',
							},
						},
					},
				})
			end,
			lazy = false,
		},
	})
end

return M
