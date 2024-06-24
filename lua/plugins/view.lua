return {
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
					require('fidget').notify('edgy toggle')
				end,
				desc = 'Edgy Toggle',
			},
			-- stylua: ignore
			{ "<leader>ei", function() require("edgy").select() end, desc = "Edgy Select Window" },
		},
		opts = require('utils.edgy'),
	},
	{
		'j-hui/fidget.nvim',
		config = function()
			require('fidget').setup({
				notification = {
					override_vim_notify = true,
					configs = {
						default = {
							name = '',
							icon = '',
							ttl = 5,
							group_style = 'Title',
							icon_style = 'Special',
							annote_style = 'Question',
							debug_style = 'Comment',
							warn_style = 'WarningMsg',
							error_style = 'ErrorMsg',
							debug_annote = 'DEBUG',
							info_annote = 'INFO',
							warn_annote = 'WARN',
							error_annote = 'ERROR',
						},
					},
					window = {
						border = 'rounded',
						normal_hl = '',
					},
				},
				integration = {
					['nvim-tree'] = {
						enable = false, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
					},
				},
			})
		end,
		event = 'BufReadPost',
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
	}
}
