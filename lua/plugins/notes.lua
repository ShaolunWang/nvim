local M = {}
M.plugins = {

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
			after = function()
				require('markview').setup({
					markdown = {
						tables = require('markview.presets').tables.single,
					},
				})
			end,
			ft = 'markdown',
		},
		{
			'contextindent.nvim',
			ft = { 'markdown' },
		},
	})
end
return M
