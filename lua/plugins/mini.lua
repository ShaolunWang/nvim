return {
	{
		'echasnovski/mini.move',
		version = false,
		opts = {
			mappings = {
				-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
				left = '',
				right = '',
				down = ']e',
				up = '[e',

				-- Move current line in Normal mode
				line_left = '',
				line_right = '',
				line_down = ']e',
				line_up = '[e',
			},
			options = {
				-- Automatically reindent selection during linewise vertical move
				reindent_linewise = true,
			},
		},
		keys = { '[', ']' },
	},
}
