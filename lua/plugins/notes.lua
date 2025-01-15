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
		ft = 'md',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-tree/nvim-web-devicons',
			'wurli/contextindent.nvim'
		},
	},
	{
		'atiladefreitas/dooing',
		config = function()
			require('dooing').setup({
				-- your custom config here (optional)
			})
		end,
		cmd = { 'Dooing' },
	},
}
