local M = {}

M.plugins = {
	{ src = 'https://github.com/kevinhwang91/nvim-fundo' },
	{
		src = 'https://github.com/kazhala/close-buffers.nvim',
		name = 'close-buffers',
	},
	{
		src = 'https://github.com/chrisgrieser/nvim-early-retirement',
		name = 'early-retirement',
	},
	{ src = 'https://github.com/numToStr/Comment.nvim' },
	{ src = 'https://github.com/chrisbra/NrrwRgn' },
	{ src = 'https://github.com/danymat/neogen' },
	{ src = 'https://github.com/chrisgrieser/nvim-rip-substitute' },
	{ src = 'https://github.com/MagicDuck/grug-far.nvim' },
	{ src = 'https://github.com/monaqa/dial.nvim' },
	{ src = 'https://github.com/kevinhwang91/promise-async' },
}
function M.load()
	require('lze').load({
		{
			'close-buffers',
			after = function()
				require('close_buffers').setup({})
			end,
			cmd = { 'BDelete', 'BWipeout' },
			keys = { '<leader><leader>' },
		},
		{
			'early-retirement',
			after = function()
				require('early-retirement').setup({
					retirementAgeMins = 5,
				})
			end,
			event = 'BufReadPost',
		},
		{
			'nvim-fundo',
			after = function()
				require('fundo').setup()
			end,
			lazy = false,
		},
		{
			'Comment.nvim',
			after = function()
				local opts =
					function()
						local commentstring_avail, commentstring = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
						return commentstring_avail and commentstring and { pre_hook = commentstring.create_pre_hook() } or {}
					end, require('Comment').setup(opts)
			end,
			keys = {
				{ 'gc', mode = { 'n', 'v' }, desc = 'Comment toggle linewise' },
				{ 'gb', mode = { 'n', 'v' }, desc = 'Comment toggle blockwise' },
			},
		},
		{

			'dial.nvim',
			-- stylua: ignore

			after = function()
				local opts = function()
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

					local options = {
						groups = {
							default = {
								augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
								augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
								augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
								ordinal_numbers,
								augend.constant.alias.bool, -- boolean value (true <-> false)
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
					return options
				end
				require('dial.config').augends:register_group(opts().groups)
				vim.cmd([[
					nmap  <C-a>  <Plug>(dial-increment)
					nmap  <C-x>  <Plug>(dial-decrement)
					nmap g<C-a> g<Plug>(dial-increment)
					nmap g<C-x> g<Plug>(dial-decrement)
					vmap  <C-a>  <Plug>(dial-increment)
					vmap  <C-x>  <Plug>(dial-decrement)
					vmap g<C-a> g<Plug>(dial-increment)
					vmap g<C-x> g<Plug>(dial-decrement)
				]])
			end,
			keys = { '<C-a>', '<C-x>', 'g<C-a>', 'g<C-x>' },
		},

		{ 'NrrwRgn', cmd = { 'NR' } },
		{
			'neogen',
			after = function()
				require('neogen').setup({})
			end,
			keys = { ',g' },
			cmd = { 'Neogen' },
			on_require = { 'neogen' },
		},
		{
			'nvim-rip-substitute',
			after = function()
				require('rip-substitute').setup({
					-- default settings
					keymaps = {
						-- normal & visual mode
						confirm = '<CR>',
						abort = 'q',
						prevSubstutionInHistory = '<c-p>',
						nextSubstutionInHistory = '<c-n>',
						insertModeConfirm = '<C-CR>', -- (except this one, obviously)
					},
				})
			end,
			cmd = { 'RipSubstitute' },
		},
		{
			'grug-far.nvim',
			after = function()
				require('grug-far').setup({})
			end,
			cmd = { 'Rg', 'Sg', 'GrugFar' },
		},

		{ 'promise-async', dep_of = { 'nvim-fundo', 'nvim-ufo' } },
	})
end

return M
