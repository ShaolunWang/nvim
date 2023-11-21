return {
	'nvim-treesitter/nvim-treesitter',
	opts = {
		ensure_installed = {
			'c',
			'cpp',
			'lua',
			'python',
			'vim',
		},
		highlight = { enable = true },
	},

	config = function(_, opts)
		require('nvim-treesitter.configs').setup(opts)
	end,
	event = { 'BufReadPre' },
}
