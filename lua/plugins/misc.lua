return {
	{
		'numToStr/Comment.nvim',
		opts = function()
			local commentstring_avail, commentstring = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
			return commentstring_avail and commentstring and { pre_hook = commentstring.create_pre_hook() } or {}
		end,
		config = function()
			require('Comment').setup()
		end,
		keys = {
			{ 'gc', mode = { 'n', 'v' }, desc = 'Comment toggle linewise' },
			{ 'gb', mode = { 'n', 'v' }, desc = 'Comment toggle blockwise' },
		},
	},
	{
		'tversteeg/registers.nvim',
		config = function()
			require('registers').setup({ bind_keys = { normal = false, insert = false } })
		end,
		keys = {
			{ '"', mode = { 'n', 'v' } },
		},
		cmd = 'Registers',
	},
	{
		'kevinhwang91/nvim-bqf',
		ft = 'qf',
	},
	{
		'skywind3000/asyncrun.vim',
		config = function()
			vim.g.asyncrun_open = 10
		end,
	},
	{
		'jinh0/eyeliner.nvim',
		opts = {
			highlight_on_key = true, -- show highlights only after keypress
			dim = false, -- dim all other characters if set to true (recommended!)
		},
	},
	{
		'folke/persistence.nvim',
		event = 'BufReadPre', -- this will only start session saving when an actual file was opened
		opts = {
			-- add any custom options here
		},
		cmd = { 'Session' },
	},
	{
		'boarg/grapple.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {
			scope = 'directory',
			popup_options = {
				relative = 'editor',
				width = 60,
				height = 12,
				style = 'minimal',
				focusable = false,
				border = 'single',
			},
		},
		keys = { '<Leader>' },
	},
	{
		'AndrewRadev/bufferize.vim',
		cmd = { 'Bufferize' },
	},
	{
		'chrisgrieser/nvim-origami',
		event = 'BufReadPost', -- later or on keypress would prevent saving folds
		opts = true, -- needed even when using default config
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
