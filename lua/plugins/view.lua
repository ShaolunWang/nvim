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
		'kevinhwang91/nvim-bqf',
		opts = {
			preview = {
				win_height = 999,
				win_vheight = 999,
			},
			func_enable = {
				drop = 'd',
				openc = 'o',
				split = '<C-v>',
				tabdrop = '<C-t>',
				tabc = '',
				ptogglemode = 'z,',
			},
		},
		ft = { 'qf' },
	},
	{
		'SmiteshP/nvim-navic',
		dependencies = { 'neovim/nvim-lspconfig' },
		lazy = true,
	},
	{
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
	},
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
	{
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
						row = -1,
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
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					['vim.lsp.util.convert_input_to_markdown_lines'] = true,
					['vim.lsp.util.stylize_markdown'] = true,
					['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			notify = {
				-- NOTE: If you enable messages, then the cmdline is enabled automatically.
				-- This is a current Neovim limitation.
				enabled = true, -- enables the Noice messages UI
			},
			message = {
				true,
			},
			cmdline = {
				view = 'cmdline_popup',
			},
		},
	},
}
