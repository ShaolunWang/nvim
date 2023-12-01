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
		'cbochs/grapple.nvim',
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
		'AndrewRadev/bufferize.vim',
		cmd = { 'Bufferize' },
	},
	{
		'chrisgrieser/nvim-origami',
		event = 'BufReadPost', -- later or on keypress would prevent saving folds
		opts = true, -- needed even when using default config
	},
}
