local M = {}
M.plugins = {

	{ src = 'https://github.com/OXY2DEV/markview.nvim' },
	{ src = 'https://github.com/jbyuki/venn.nvim' },
	{ src = 'https://github.com/wurli/contextindent.nvim' },
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
