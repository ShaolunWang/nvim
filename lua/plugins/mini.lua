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
	{
		'echasnovski/mini.hipatterns',
		version = false,
		config = function()
			local hipatterns = require('mini.hipatterns')
			hipatterns.setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
					hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
					todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
					note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
	},
	{
		'echasnovski/mini.move',
		version = false,
		opts = {
			mappings = {
				-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
				left = '<',
				right = '<',
				down = ']e',
				up = '[e',

				-- Move current line in Normal mode
				line_left = '<',
				line_right = '>',
				line_down = ']e',
				line_up = '[e',
			},
			options = {
				-- Automatically reindent selection during linewise vertical move
				reindent_linewise = true,
			},
		},
		keys = { '[', ']', '<', '>' },
	},
}
