return {
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
					{ mode = 'n', keys = '<C-w>' },
					{ mode = 'n', keys = 'm' },
				},
				clues = {
					{ mode = 'n', keys = '<Leader>f', desc = '+Fuzzy Search...' },
					{ mode = 'n', keys = '<Leader>t', desc = '+Tab ...' },
					{ mode = 'n', keys = '<Leader>g', desc = '+Harpoon ...' },
					{ mode = 'n', keys = '\\', desc = '+Lsp ...' },
					{ mode = 'n', keys = 'g', desc = '+g ...' },
					{ mode = 'n', keys = ',', desc = '+unimpaired ...' },
					{ mode = 'n', keys = '[', desc = '+unimpaired ...' },
					{ mode = 'n', keys = ']', desc = '+unimpaired ...' },
					miniclue.gen_clues.windows({
						submode_resize = true,
					}),
				},
			})
		end,
		keys = { '<leader>', '\\', 'g', ',', '[', ']', '<c-w>' },
	},
	{
		'echasnovski/mini.hipatterns',
		version = false,
		config = function()
			local hipatterns = require('mini.hipatterns')
			hipatterns.setup({
				highlighters = {
					hex_color = hipatterns.gen_highlighter.hex_color(),
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
					deprecated = { pattern = '%f[%w]()DEPRECATE()%f[%W]', group = 'MiniHipatternsFixme' },
					hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'Deprecation' },
					todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
					note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
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
				left = '<e',
				right = '>e',
				down = ']e',
				up = '[e',

				-- Move current line in Normal mode
				line_left = '<e',
				line_right = '>e',
				line_down = ']e',
				line_up = '[e',
			},
			options = {
				-- Automatically reindent selection during linewise vertical move
				reindent_linewise = true,
			},
		},
		keys = { '[', ']', '<e', '>e' },
	},
	{
		'echasnovski/mini.indentscope',
		version = false,
		config = function()
			vim.g.miniindentscope_disable = {
				'NvimTree',
				'Outline',
				'Tagbar',
				'lazy',
			}
			local miniscope = require('mini.indentscope')
			miniscope.setup({
				draw = {
					delay = 0,
					animation = miniscope.gen_animation.none(),
				},
				symbol = '┃',
				options = {
					border = 'both',
					indent_at_cursor = true,
					try_as_border = false,
				},
			})
		end,
	},
	{
		'echasnovski/mini.animate',
		config = function()
			local animate = require('mini.animate')
			animate.setup({ cursor = { enable = false }, scroll = { enable = false } })
		end,
		version = false,
	},
	{
		'echasnovski/mini.surround',
		opts = {
			mappings = {
				add = 'ra',
				delete = 'rd',
				find = 'rf',
				find_left = 'rF',
				highlight = 'rh',
				replace = 'rr',
				suffix_last = 'l',
				suffix_next = 'n',
				update_n_lines = 'rn',
			},
		},
		version = false,
	},
}
