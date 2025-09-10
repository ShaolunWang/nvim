local M = {}
M.plugins = {
	{ src = 'https://github.com/chrisgrieser/nvim-origami' },
	{ src = 'https://github.com/luukvbaal/statuscol.nvim' },
}
function M.load()
	require('lze').load({
		{
			'nvim-origami',
			after = function()
				require('origami').setup()
			end,
			event = 'BufReadPost', -- later or on keypress would prevent saving folds
		},
		{
			'statuscol.nvim',
			after = function()
				local builtin = require('statuscol.builtin')
				require('statuscol').setup({
					relculright = true,
					segments = {
						{ text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
						{ text = { '%s' }, click = 'v:lua.ScSa' },
						{ text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
					},
				})
			end,
		},
	})
end
return M
