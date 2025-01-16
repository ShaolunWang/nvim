return {
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		opts = {
			ensure_installed = {
				'c',
				'cpp',
				'lua',
				'python',
				'vim',
				'vimdoc',
			},
			highlight = { enable = true },
			matchup = { enable = true },
			textobjects = {
				select = {

					enable = true,
					keymaps = {
						['iv'] = { query = '@parameter.inner', desc = 'inner parameter' },
					},
				},
			},
		},

		config = function(_, opts)
			require('nvim-treesitter.configs').setup(opts)
			require('nvim-treesitter.install').compilers = { 'gcc' }
		end,
		event = { 'BufReadPre' },
	},
	{
		'chrisgrieser/nvim-various-textobjs',
		event = 'BufReadPre',
		opts = { keymaps = { useDefault = true } },
	},
	{
		'mizlan/iswap.nvim',
		opts = {},
		keys = { '\\s' },
		cmd = { 'ISwapWith', 'IMove', 'ISwap' }
	},
}
