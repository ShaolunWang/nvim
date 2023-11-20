return {
	'nvim-neorg/neorg',
	build = ':Neorg sync-parsers',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
    require("nvim-web-devicons").set_icon({
      norg = {
        icon = "",
        color = "#56949f",
        cterm_color = "65",
        name = "Norg",
      },
    })
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
							notes = '~/notes',
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
