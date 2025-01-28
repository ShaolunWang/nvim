local M = {}
M.plugins = {

	{ 'atiladefreitas/dooing', opt = true },
	{ 'OXY2DEV/markview.nvim', opt = true },
	{ 'jbyuki/venn.nvim', opt = true },
	{ 'wurli/contextindent.nvim', opt = true },
}
function M.load()
	require('lze').load({
		{
			'venn.nvim',
			before = function()
				vim.o.virtualedit = 'all'
			end,
			cmd = { 'VBox' },
		},
		{
			'markview.nvim',
			ft = 'markdown',
		},
		{
			'dooing',
			after = function()
				require('dooing').setup({
					-- your custom config here (optional)
				})
			end,
			cmd = { 'Dooing' },
		},
		{
			'contextindent.nvim',
			ft = { 'markdown' },
		},
	})
end
return M
