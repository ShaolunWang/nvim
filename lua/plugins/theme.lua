local M = {}
M.plugins = {
	{ src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
	{ src = 'https://github.com/tiagovla/scope.nvim' },
	{ src = 'https://github.com/sschleemilch/slimline.nvim' },
	{ src = 'https://github.com/tiagovla/tokyodark.nvim', name = 'tokyodark' },
	{ src = 'https://github.com/sainnhe/edge', name = 'edge' },
	{ src = 'https://github.com/navarasu/onedark.nvim', name = 'onedark' },
	{ src = 'https://github.com/folke/tokyonight.nvim', name = 'tokyonight' },
	{ src= 'https://github.com/Mofiqul/vscode.nvim', name = 'vscode' },
	{ src = 'https://github.com/pappasam/papercolor-theme-slim', name = 'papercolor' },
}

function M.load()
	require('lze').load({
		{ 'vscode', colorscheme = { 'vscode' } },
		{ 'papercolor', colorscheme = { 'PaperColorSlim', 'PaperColorSlimLight' } },
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
		{
			'onedark',
			after = function()
				require('onedark').setup({
					-- Main options --
					style = 'deep',
					transparent = false,
					toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' },
				})
			end,
			colorscheme = { 'onedark' },
		},
		{ 'edge', colorscheme = 'edge' },
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
