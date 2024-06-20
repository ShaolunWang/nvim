return {
	{
		'folke/flash.nvim',
		opts = {

			label = { rainbow = { enabled = true } },

			jump = {
				nohlsearch = true,
			},
			modes = {
				char = {
					enabled = true,
					multi_line = false,
					autohide = true,
					jump_labels = true,
					highlight = { backdrop = false },
					--					jump = { autojump = true },
				},
			},
			search = {
				exclude = {
					'notify',
					'terminal',
					'cmp_menu',
					'noice',
					'flash_prompt',
					'NeogitStatus',
					'NeogitConsole',
					'NeogitStatusNew',
					'NeogitGitCommandHistory',
					'NeogitCommitSelectView',
					'NeogitLogView',
					'NeogitRebaseTodo',
					'NeogitPopup',
					'NeogitCommitView',
				},
				mode = 'exact',
			},
		},

		keys = {
			{
				's',
				mode = { 'n', 'x', 'o' },
				function()
					require('flash').jump()
				end,
				desc = 'Flash',
			},
			{
				'S',
				mode = { 'n', 'x', 'o' },
				function()
					require('flash').treesitter()
				end,
				desc = 'Flash Treesitter',
			},
			{
				'gs',
				mode = 'o',
				function()
					require('flash').remote()
				end,
				desc = 'Remote Flash',
			},
		},
	},
	{
		'cbochs/grapple.nvim',
		dependencies = { 'nvim-lua/plenary.nvim', 'j-hui/fidget.nvim' },
		config = function()
			local grapple = require('grapple')
			require('grapple').setup()

			vim.keymap.set('n', '<leader>gg', grapple.toggle, { desc = 'Grapple Tag' })
			vim.keymap.set('n', '<leader>gr', grapple.reset, { desc = 'Grapple Clear' })
			vim.keymap.set('n', '<leader>gp', grapple.open_tags, { desc = 'Grapple Menu' })
			vim.keymap.set('n', '[g', function()
				grapple.cycle_tags('prev')
				local fidget = require('fidget')
				fidget.notify('Grapple Cycle Backward')
			end, { desc = 'Grapple Prev' })
			vim.keymap.set('n', ']g', function()
				grapple.cycle_tags('next')
				local fidget = require('fidget')
				fidget.notify('Grapple Cycle Forward')
			end, { desc = 'Grapple Next' })
		end,

		keys = { '<leader>g', '[g', ']g' },
	},
	{
		'mrjones2014/smart-splits.nvim',
		config = function()
			require('smart-splits').setup()
		end,
		event = { 'WinEnter' },
	},
	{
		'andymass/vim-matchup',
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = 'popup' }
		end,
		event = 'BufReadPre',
	},
	{ 'kwkarlwang/bufjump.nvim', opts = {}, keys = { 'c-o', 'c-i' } },
	{
		'haya14busa/vim-asterisk',
		config = function()
			vim.keymap.set({ 'n', 'x' }, '*', '<Plug>(asterisk-*)', { silent = true, noremap = true })
			vim.keymap.set({ 'n', 'x' }, '#', '<Plug>(asterisk-#)', { silent = true, noremap = true })
			vim.keymap.set({ 'n', 'x' }, '*', '<Plug>(asterisk-*)', { silent = true, noremap = true })
			vim.keymap.set({ 'n', 'x' }, 'g#', '<Plug>(asterisk-g#)', { silent = true, noremap = true })
			vim.keymap.set({ 'n', 'x' }, 'z#', '<Plug>(asterisk-z#)', { silent = true, noremap = true })
			vim.keymap.set({ 'n', 'x' }, 'z*', '<Plug>(asterisk-z*)', { silent = true, noremap = true })
			vim.keymap.set({ 'n', 'x' }, 'gz*', '<Plug>(asterisk-gz*)', { silent = true, noremap = true })
			vim.g['asterisk#keeppos'] = 1
		end,
		event = { 'BufReadPost' },
	},
}
