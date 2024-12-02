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
		lazy = true,
		keys = {
			{
				'<c-q>',
				mode = 'n',
				function()
					require('utils.jump').two_label()
				end,
				desc = 'Jump 2c',
			},
		},
	},
	{
		'cbochs/grapple.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local grapple = require('grapple')
			require('grapple').setup()

			vim.keymap.set('n', '<leader>gg', grapple.toggle, { desc = 'Grapple Tag' })
			vim.keymap.set('n', '<leader>gr', grapple.reset, { desc = 'Grapple Clear' })
			vim.keymap.set('n', '<leader>gp', grapple.open_tags, { desc = 'Grapple Menu' })
			vim.keymap.set('n', '[g', function()
				grapple.cycle_tags('prev')
			end, { desc = 'Grapple Prev' })
			vim.keymap.set('n', ']g', function()
				grapple.cycle_tags('next')
			end, { desc = 'Grapple Next' })
		end,

		keys = { '<leader>g', '[g', ']g' },
	},
	{
		'mrjones2014/smart-splits.nvim',
		config = function()
			require('smart-splits').setup({
				ignored_buftypes = {
					'prompt',
				},
			})
		end,
		event = { 'WinEnter' },
	},
	{ 'kwkarlwang/bufjump.nvim', opts = {}, keys = { 'c-o', 'c-i' } },
	{ 'chentoast/marks.nvim', opts = {} },
}
