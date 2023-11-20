return {
	'nvim-treesitter/nvim-treesitter',
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
	},

	config = function(_, opts)
		require('nvim-treesitter.configs').setup(opts)
		require('nvim-treesitter.install').compilers = { 'gcc' }
	end,
	event = { 'BufReadPre' },
}
