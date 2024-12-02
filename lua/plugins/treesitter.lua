return {
	{
		'nvim-treesitter/nvim-treesitter',
		opts = {
			ensure_installed = {
				'c',
				'cpp',
				'lua',
				'python',
				'vim',
				'vimdoc',
			},
			highlight = { enable = true },
			matchup = { enable = true },
		},

		config = function(_, opts)
			require('nvim-treesitter.configs').setup(opts)
			require('nvim-treesitter.install').compilers = { 'gcc' }
		end,
		event = { 'BufReadPre' },
	},
	{
		'chrisgrieser/nvim-various-textobjs',
		event = 'BufReadPre',
		opts = { useDefaultKeymaps = true },
	},
	{

		'Wansmer/sibling-swap.nvim',
		requires = { 'nvim-treesitter' },
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require('sibling-swap').setup({
				keymaps = {
					[',a'] = 'swap_with_right',
					[',A'] = 'swap_with_left',
					[',s'] = 'swap_with_right_with_opp',
					[',S'] = 'swap_with_left_with_opp',
				},
			})
		end,
		keys = { ',a', ',A' },
	},
}
