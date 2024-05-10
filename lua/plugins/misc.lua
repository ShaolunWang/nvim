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
		'hauleth/asyncdo.vim',
	},
	{ 'chrisbra/NrrwRgn' },
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
				tab_char = '│',
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					'NvimTree',
					'qf',
					'terminal',
					'fzf',
				},
			},
		},
		main = 'ibl',
		event = { 'BufReadPost' },
	},
	{
		'hedyhli/outline.nvim',
		lazy = true,
		cmd = { 'Outline', 'OutlineOpen' },
		opts = {},
	},
	{
		'NeogitOrg/neogit',
		cmd = 'Neogit',
		dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim', 'ibhagwan/fzf-lua' },
		opts = {
			auto_refresh = true,
			integrations = { diffview = true },
			kind = 'tab',
			use_magit_keybindings = true,
			disable_builtin_notifications = false,
		},
	},
}
