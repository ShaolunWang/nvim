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
		'folke/edgy.nvim',
		lazy = true,
		keys = {
			{
				'<leader>ee',
				function()
					require('edgy').toggle()
				end,
				desc = 'Edgy Toggle',
			},
			-- stylua: ignore
			{ "<leader>ei", function() require("edgy").select() end, desc = "Edgy Select Window" },
		},
		opts = require('utils.edgy'),
	},
	{
		'stevearc/quicker.nvim',
		opts = {
			max_filename_width = function()
				return math.floor(math.min(45, vim.o.columns / 2))
			end,
		},
		ft = { 'qf' },
	},
	--[[ {
		'SmiteshP/nvim-navic',
		dependencies = { 'neovim/nvim-lspconfig' },
		lazy = true,
	}, ]]
	--[[ 	{
		'lukas-reineke/indent-blankline.nvim',
		opts = {
			indent = {
				char = '│',
			},
			scope = {
				enabled = true,
				show_start = true,
				show_end = false,
				char = '│',
				--	highlight = 'IndentBlanklineContextChar',
			},
			exclude = {
				filetypes = {
					'NvimTree',
					'qf',
					'terminal',
					'fzf',
					'Trouble',
					'UndoTree',
				},
			},
		},
		main = 'ibl',
		event = { 'BufReadPost' },
	}, ]]
	{ 'tzachar/highlight-undo.nvim', opts = {}, keys = { 'u', '<c-r>' } },
	{
		'MunifTanjim/nui.nvim',
		lazy = true,
	},
	{
		'stevearc/dressing.nvim',
		opts = {
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
	--[[ 	{
		'folke/noice.nvim',
		event = 'VeryLazy',
		dependencies = {
			'MunifTanjim/nui.nvim',
		},
		opts = {
			-- add any options here
			views = {
				cmdline_popup = {
					position = {
						row = '97%',
						col = '50%',
					},
					size = {
						width = 60,
						height = 1,
					},
					border = {
						style = 'none',
						padding = { 0, 0 },
					},
				},
			},
			lsp = {
				override = {
					['vim.lsp.util.convert_input_to_markdown_lines'] = true,
					['vim.lsp.util.stylize_markdown'] = true,
					['cmp.entry.get_documentation'] = true,
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
			notify = {
				enabled = true, -- enables the Noice messages UI
			},
			message = {
				true,
			},
			cmdline = {
				view = 'cmdline_popup',
			},
		},
	}, ]]
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
		'j-morano/buffer_manager.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {},
		keymap = { '<leader>b' },
	},
}
