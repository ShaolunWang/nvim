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
				mode = 'fuzzy',
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
		'nanotee/zoxide.vim',
		cmd = { 'Z', 'LZ', 'Zi', 'Tz', 'Lzi', 'Tzi' },
	},
	{
		'cbochs/grapple.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {},
		keys = { '<leader>g' },
	},
	{
		'mrjones2014/smart-splits.nvim',
		config = function()
			require('smart-splits').setup()
		end,
	},
	{
		'andymass/vim-matchup',
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = 'popup' }
		end,
		event = 'BufReadPre',
	},
}
