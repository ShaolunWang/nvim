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
	},
}
