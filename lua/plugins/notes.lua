return {
	{
		'jbyuki/venn.nvim',
		config = function()
			vim.o.virtualedit = 'all'
		end,
		cmd = { 'VBox' },
	},
	{
		'OXY2DEV/markview.nvim',
		ft = 'markdown',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-tree/nvim-web-devicons',
		},
	},
}
