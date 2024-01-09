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
		'jinh0/eyeliner.nvim',
		opts = {
			highlight_on_key = true, -- show highlights only after keypress
			dim = false, -- dim all other characters if set to true (recommended!)
		},
	},
	{
		-- note: this is a modified version of grapple,
		-- see issue #72
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
		'chrisgrieser/nvim-origami',
		event = 'BufReadPost', -- later or on keypress would prevent saving folds
		opts = true, -- needed even when using default config
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
		'ggandor/leap.nvim',
		config = function()
			require('leap').opts.highlight_unlabeled_phase_one_targets = true
		end,
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
				},
			})
		end,
	},
	{
		'hauleth/asyncdo.vim',
	},
	{
		'hedyhli/outline.nvim',
		opts = {},
		cmd = { 'Outline', 'OutlineOpen' },
	},
	{ 'm-demare/hlargs.nvim', event = 'BufReadPost' },
}
