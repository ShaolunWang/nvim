return {
	{
		'echasnovski/mini.icons',
		opts = {},
		lazy = false,
		specs = {
			{ 'nvim-tree/nvim-web-devicons', enabled = false, optional = true },
		},
		config = function()
			require('mini.icons').setup({
				--style = 'ascii'
			})
			require('mini.icons').mock_nvim_web_devicons()
		end,
	},
	{
		'folke/todo-comments.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {
			keywords = {
				FIX = {
					icon = ' ',
					color = 'error',
					alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' },
				},
				TODO = { icon = ' ', color = 'info' },
				HACK = { icon = ' ', color = 'warning' },
				WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
				PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
				NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
				TEST = { icon = '? ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
			},
		},
		event = 'BufReadPost',
	},
	{
		'stevearc/quicker.nvim',
		opts = {
			max_filename_width = function()
				return math.floor(math.min(45, vim.o.columns / 2))
			end,
			highlight = {
				-- Use treesitter highlighting
				treesitter = true,
				-- Use LSP semantic token highlighting
				lsp = true,
				-- Load the referenced buffers to apply more accurate highlights (may be slow)
				load_buffers = false,
			},
		},

		event = 'FileType qf',
	},
	--[[ {
		'kevinhwang91/nvim-bqf',
		opts = {
			preview = { auto_preview = false },
		},
		ft = { 'qf' },
	}, ]]
	{ 'tzachar/highlight-undo.nvim', opts = {}, keys = { 'u', '<c-r>' } },
	{
		'stevearc/dressing.nvim',
		opts = {
			input = { enabled = true },
			select = {
				backend = { 'nui', 'fzf_lua', 'builtin' },
				nui = {
					buf_options = {
						filetype = 'nui',
					},
				},
			},
		},
	},
	{
		'sindrets/winshift.nvim',
		opts = {
			moving_win_options = {
				wrap = true,
				cursorline = false,
				cursorcolumn = false,
			},
		},
		cmd = { 'WinShift' },
	},
	{
		'j-hui/fidget.nvim',
		opts = {
			-- options
		},
		events = 'VeryLazy',
	},
}
