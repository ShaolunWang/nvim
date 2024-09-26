return {
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		opts = {
			ensure_installed = {
				'c',
				'cpp',
				'lua',
				'python',
				'vim',
				'vimdoc',
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						['af'] = '@function.outer',
						['if'] = '@function.inner',
						['ac'] = '@class.outer',
						['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
						['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
					},
					selection_modes = {
						['@parameter.outer'] = 'v', -- charwise
						['@function.outer'] = 'V', -- linewise
						['@class.outer'] = '<c-v>', -- blockwise
					},
					include_surrounding_whitespace = true,
				},
				swap = {
					enable = true,
					swap_next = {
						[',a'] = '@parameter.inner',
					},
					swap_previous = {
						[',A'] = '@parameter.inner',
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						[']m'] = '@function.outer',
						[']]'] = { query = '@class.outer', desc = 'Next class start' },
						[']o'] = '@loop.*',
						[']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
						[']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
					},
					goto_next_end = {
						[']M'] = '@function.outer',
						[']['] = '@class.outer',
					},
					goto_previous_start = {
						['[m'] = '@function.outer',
						['[['] = '@class.outer',
					},
					goto_previous_end = {
						['[M'] = '@function.outer',
						['[]'] = '@class.outer',
					},
					goto_next = {
						[']w'] = '@conditional.outer',
					},
					goto_previous = {
						['[w'] = '@conditional.outer',
					},
				},
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
}
