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
	{
		'echasnovski/mini.extra',
		version = false,
		config = function()
			require('mini.extra').setup()
		end,
		lazy = true
	},
	{
		'echasnovski/mini.pick',

		dependencies = { 'echasnovski/mini.extra', version = false },
		version = false,
		opts = {
			-- No need to copy this inside `setup()`. Will be used automatically.
			-- Delays (in ms; should be at least 1)
			delay = {
				-- Delay between forcing asynchronous behavior
				async = 5,

				-- Delay between computation start and visual feedback about it
				busy = 50,
			},

			-- Keys for performing actions. See `:h MiniPick-actions`.
			mappings = {
				caret_left = '<Left>',
				caret_right = '<Right>',

				choose = '<CR>',
				choose_in_split = '<C-s>',
				choose_in_tabpage = '<C-t>',
				choose_in_vsplit = '<C-v>',
				choose_marked = '<M-CR>',

				delete_char = '<BS>',
				delete_char_right = '<Del>',
				delete_left = '<C-u>',
				delete_word = '<C-w>',

				mark = '<C-x>',
				mark_all = '<C-a>',

				move_down = '<C-n>',
				move_start = '<C-g>',
				move_up = '<C-p>',

				paste = '<C-r>',

				refine = '<C-Space>',
				refine_marked = '<M-Space>',

				scroll_down = '<C-f>',
				scroll_left = '<C-h>',
				scroll_right = '<C-l>',
				scroll_up = '<C-b>',

				stop = '<Esc>',

				toggle_info = '<S-Tab>',
				toggle_preview = '<Tab>',
			},

			-- General options
			options = {
				-- Whether to show content from bottom to top
				content_from_bottom = false,

				-- Whether to cache matches (more speed and memory on repeated prompts)
				use_cache = true,
			},

			-- Source definition. See `:h MiniPick-source`.
			source = {
				items = nil,
				name = nil,
				cwd = nil,

				match = nil,
				show = nil,
				preview = nil,

				choose = nil,
				choose_marked = nil,
			},

			-- Window related options
			window = {
				-- Float window config (table or callable returning it)
				config = nil,

				-- String to use as cursor in prompt
				prompt_cursor = '▏',

				-- String to use as prefix in prompt
				prompt_prefix = '> ',
			},
		},
		config = function()
			require('mini.pick').setup(opts)
			vim.ui.select = MiniPick.ui_select
		end,
		cmd = { 'Pick' },
	},
	{
		'echasnovski/mini.ai',
		dependencies = {
			'echasnovski/mini.extra',
			version = false,
		},
		config = function()
			require("mini.ai").setup()
		end,
		version = false,
		events = { 'BufReadPost' },
	},
}
