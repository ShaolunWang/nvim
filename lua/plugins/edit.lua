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
	{
		'monaqa/dial.nvim',
		-- stylua: ignore
		opts = function()
			local augend = require("dial.augend")

			local logical_alias = augend.constant.new({
				elements = { "&&", "||" },
				word = false,
				cyclic = true,
			})

			local ordinal_numbers = augend.constant.new({
				-- elements through which we cycle. When we increment, we go down
				-- On decrement we go up
				elements = {
					"first",
					"second",
					"third",
					"fourth",
					"fifth",
					"sixth",
					"seventh",
					"eighth",
					"ninth",
					"tenth",
				},
				-- if true, it only matches strings with word boundary. firstDate wouldn't work for example
				word = false,
				-- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
				-- Otherwise nothing will happen when there are no further values
				cyclic = true,
			})

			local weekdays = augend.constant.new({
				elements = {
					"Monday",
					"Tuesday",
					"Wednesday",
					"Thursday",
					"Friday",
					"Saturday",
					"Sunday",
				},
				word = true,
				cyclic = true,
			})

			local months = augend.constant.new({
				elements = {
					"January",
					"February",
					"March",
					"April",
					"May",
					"June",
					"July",
					"August",
					"September",
					"October",
					"November",
					"December",
				},
				word = true,
				cyclic = true,
			})

			local capitalized_boolean = augend.constant.new({
				elements = {
					"True",
					"False",
				},
				word = true,
				cyclic = true,
			})

			return {
				groups = {
					default = {
						augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
						augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
						augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
						ordinal_numbers,
   						augend.constant.alias.bool,    -- boolean value (true <-> false)
						weekdays,
						months,
					},
					markdown = {
						augend.misc.alias.markdown_header,
					},
					lua = {
						augend.integer.alias.decimal, -- nonnegative and negative decimal number
						augend.constant.alias.bool, -- boolean value (true <-> false)
						augend.constant.new({
							elements = { "and", "or" },
							word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
							cyclic = true, -- "or" is incremented into "and".
						}),
					},
					python = {
						augend.integer.alias.decimal, -- nonnegative and negative decimal number
						capitalized_boolean,
						logical_alias,
					},
				},
			}
		end,
		config = function(_, opts)
			require('dial.config').augends:register_group(opts.groups)
			vim.cmd [[
				nmap  <C-a>  <Plug>(dial-increment)
				nmap  <C-x>  <Plug>(dial-decrement)
				nmap g<C-a> g<Plug>(dial-increment)
				nmap g<C-x> g<Plug>(dial-decrement)
				vmap  <C-a>  <Plug>(dial-increment)
				vmap  <C-x>  <Plug>(dial-decrement)
				vmap g<C-a> g<Plug>(dial-increment)
				vmap g<C-x> g<Plug>(dial-decrement)
			]]
		end,
		keys = { '<C-a>', '<C-x>', 'g<C-a>', 'g<C-x>', },
	},
	--[[ {
		'chrisgrieser/nvim-various-textobjs',
		opts = { useDefaultKeymaps = true },
	}, ]]
}
