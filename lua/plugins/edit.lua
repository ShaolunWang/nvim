return {
	{
		'jiaoshijie/undotree',
		dependencies = 'nvim-lua/plenary.nvim',
		opts = {},
		events = { 'BufReadPost' },
	},
	{
		'kevinhwang91/nvim-fundo',
		dependencies = { 'kevinhwang91/promise-async' },
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
			local commentstring_avail, commentstring = pcall(require,
				'ts_context_commentstring.integrations.comment_nvim')
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
	{
		'kylechui/nvim-surround',
		opts = {
			keymaps = {
				insert = '<C-g>s',
				insert_line = '<C-g>S',
				normal = 'rs',
				normal_cur = 'rss',
				normal_line = 'rS',
				normal_cur_line = 'rSS',
				visual = 'rs',
				visual_line = 'rS',
				delete = 'drs',
				change = 'crs',
				change_line = 'crS',
			},
		},
		events = { 'BufReadPost' },
	},
	{
		'danymat/neogen',
		opts = {},
		keys = { ',c' },
	},
	{
		'chrisgrieser/nvim-rip-substitute',
		opts = {
			-- default settings
			keymaps = {
				-- normal & visual mode
				confirm = '<CR>',
				abort = 'q',
				prevSubst = '<c-p>',
				nextSubst = '<c-n>',
				insertModeConfirm = '<C-CR>', -- (except this one, obviously)
			},
		},
		cmd = { 'RipSubstitute' },
		keymaps = { '<c-s>' },
	},

	{
		'MagicDuck/grug-far.nvim',
		config = function()
			require('grug-far').setup({
				-- options, see Configuration section below
				-- there are no required options atm
				-- engine = 'ripgrep' is default, but 'astgrep' can be specified
			})
		end,
		cmd = { 'Rg', 'Sg' },
	},
	--[[ {
		'chrisgrieser/nvim-various-textobjs',
		opts = { useDefaultKeymaps = true },
	}, ]]
}
