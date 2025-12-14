local M = {}
M.plugins = {
	{ src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
	{ src = 'https://github.com/tiagovla/scope.nvim' },
	{ src = 'https://github.com/sschleemilch/slimline.nvim' },
	{ src = 'https://github.com/tiagovla/tokyodark.nvim', name = 'tokyodark' },
	{ src = 'https://github.com/Shatur/neovim-ayu', name = 'ayu' },
	{ src = 'https://github.com/navarasu/onedark.nvim', name = 'onedark' },
}

function M.load()
	require('lze').load({
		{
			'ayu',
			after = function()
				require('ayu').setup({
					mirage = true,
					terminal = true,
					overrides = {},
				})
			end,
			colorscheme = { 'ayu', 'ayu-light', 'ayu-mirage', 'ayu-dark' },
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
