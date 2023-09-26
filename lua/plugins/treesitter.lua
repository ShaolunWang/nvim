function treesitter_setup()
	require('nvim-treesitter.configs').setup({
		ensure_installed = {
			'c',
			'cpp',
			'lua',
			'python',
			'vim',
		},
	})
end
return {
	'nvim-treesitter/nvim-treesitter',
	config = treesitter_setup,
	event = 'BufEnter',
}
