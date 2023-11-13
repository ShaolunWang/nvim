return {
	'nvim-neorg/neorg',
	build = ':Neorg sync-parsers',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		require('neorg').setup({
			load = {
				['core.defaults'] = {}, -- Loads default behaviour
				['core.qol.toc'] = {},
				['core.qol.todo_items'] = {},
				['core.looking-glass'] = {},
				['core.concealer'] = {
					config = {
						icons = {
							todo = {
								undone = { icon = ' ' },
								on_hold = { icon = '=' },
							},
						},
					},
				},
				['core.journal'] = {
					config = {
						strategy = 'flat',
						workspace = 'Notes',
					},
				},
				['core.dirman'] = { -- Manages Neorg workspaces
					config = {
						workspaces = {
							notes = '', -- setup note dir
						},
					},
				},
			},
		})

		vim.keymap.set('n', '<leader>n', ':Neorg workspace notes', { noremap = true, desc = 'Neorg goto notes' })
	end,
	cmd = { 'Neorg' },
	ft = { 'norg' },
}
