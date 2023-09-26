return {
	'echasnovski/mini.clue',
	config = function()
		local miniclue = require('mini.clue')
		miniclue.setup({
			window = {
				delay = 0,
				config = {
					anchor = 'SW',
					width = 'auto',
					row = 'auto',
					col = 'auto',
				},
			},
			triggers = {
				{ mode = 'n', keys = 'g' },
				{ mode = 'n', keys = '<Leader>' },
				{ mode = 'n', keys = '\\' },
				{ mode = 'n', keys = ',' },
				{ mode = 'n', keys = '[' },
				{ mode = 'n', keys = ']' },
			},
			clues = {
				{ mode = 'n', keys = '<Leader>f', desc = '+Telescope ...' },
				{ mode = 'n', keys = '<Leader>t', desc = '+Tab ...' },
				{ mode = 'n', keys = '\\', desc = '+Lsp ...' },
				{ mode = 'n', keys = 'g', desc = '+g ...' },
				{ mode = 'n', keys = ',', desc = '+unimpaired ...' },
				{ mode = 'n', keys = '[', desc = '+unimpaired ...' },
				{ mode = 'n', keys = ']', desc = '+unimpaired ...' },
			},
		})
	end,
	keys = { '<leader>', '\\', 'g', ',', '[', ']' },
}
