return {
	{
		'lambdalisue/vim-fern',
		dependencies = {
			'TheLeoP/fern-renderer-web-devicons.nvim',
			'lambdalisue/vim-fern-git-status',
		},
		config = function()
			vim.g['fern#renderer'] = 'nvim-web-devicons'
			vim.g['fern#hide_cursor'] = 1
			vim.g['fern#keepalt_on_edit'] = 1
			vim.g['fern#default_hidden'] = 1
			vim.g['fern#disable_default_mappings'] = 1
		end,
		cmd = { 'Fern' },
	},
}
