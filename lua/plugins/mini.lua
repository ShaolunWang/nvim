return {
	{
		'echasnovski/mini.sessions',
		opts = {

			autowrite = true,
			file = '.localsession.vim',
			verbose = { read = false, write = true, delete = true },
		},
	},
	{
		'echasnovski/mini.clue',
		config = function()
			local miniclue = require('mini.clue')
			miniclue.setup({
				window = {
					delay = 500,
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
					{ mode = 'n', keys = '<Leader>f', desc = '+Fuzzy Search...' },
					{ mode = 'n', keys = '<Leader>t', desc = '+Tab ...' },
					{ mode = 'n', keys = '<Leader>g', desc = '+Grapple ...' },
					{ mode = 'n', keys = '\\', desc = '+Lsp ...' },
					{ mode = 'n', keys = 'g', desc = '+g ...' },
					{ mode = 'n', keys = ',', desc = '+unimpaired ...' },
					{ mode = 'n', keys = '[', desc = '+unimpaired ...' },
					{ mode = 'n', keys = ']', desc = '+unimpaired ...' },
				},
			})
		end,
		keys = { '<leader>', '\\', 'g', ',', '[', ']' },
	},
	{
		'echasnovski/mini.starter',
		version = false,
		lazy = true,
	},
}
