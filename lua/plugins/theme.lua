local M = {}
M.plugins = {
	{ src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
	{ src = 'https://github.com/tiagovla/scope.nvim' },
	{ src = 'https://github.com/thesimonho/kanagawa-paper.nvim', name = 'kanagawa-paper' },
	{ src = 'https://github.com/nvim-lualine/lualine.nvim' },
	{ src = 'https://github.com/tiagovla/tokyodark.nvim', name = 'tokyodark' },
	{ src = 'https://github.com/olimorris/onedarkpro.nvim', name = 'onedarkpro' },
	{ src = 'https://github.com/Shatur/neovim-ayu', name = 'ayu' },
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
			'catppuccin',
			colorscheme = { 'catppuccin', 'catppuccin-latte', 'catppuccin-frappe', 'catppuccin-mocha' },
		},
		{
			'tokyodark',
			colorscheme = 'tokyodark',
		},
		{
			'kanagawa-paper',
			colorscheme = { 'kanagawa-paper', 'kanagawa-paper-canvas', 'kanagawa-paper-ink' },
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
			'lualine.nvim',
			after = function()
				require('theme.line').setup()
			end,
			lazy = false,
		},
	})
end

return M
