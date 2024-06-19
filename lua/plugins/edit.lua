return {
	{
		'mbbill/undotree',
		config = function()
			vim.g.undotree_DiffCommand = 'difft'
			vim.g.undotree_WindowLayout = 4
		end,
		cmd = { 'UndotreeToggle' },
	},
	{
		'kevinhwang91/nvim-fundo',
		requires = 'kevinhwang91/promise-async',
		build = function()
			require('fundo').install()
		end,
		config = function()
			require('fundo').setup()
		end,
		event = { 'BufRead' },
	},
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
	{ 'chrisbra/NrrwRgn', cmd = { 'NR' } },
}
