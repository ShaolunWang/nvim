return {
	{
		'nvim-neorg/neorg',
		build = ':Neorg sync-parsers',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-treesitter/nvim-treesitter',
		},
		config = function()
			require('nvim-web-devicons').set_icon({
				norg = {
					icon = '',
					color = '#56949f',
					cterm_color = '65',
					name = 'Norg',
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
							workspace = 'notes',
						},
					},
					['core.ui.calendar'] = {},
					['core.dirman'] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = '~/notes',
							},
							default_workspace = 'notes',
						},
					},
				},
			})
		end,
		cmd = { 'Neorg' },
		ft = { 'norg' },
	},
	{
		'jbyuki/venn.nvim',
		config = function()
			vim.o.virtualedit = 'all'
		end,
		cmd = { 'VBox' },
	},
	{ 'ellisonleao/glow.nvim', opts = {}, cmd = { 'Glow' } },
	{
		'iamcco/markdown-preview.nvim',
		cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
		ft = { 'markdown' },
		build = function()
			vim.fn['mkdp#util#install']()
		end,
	},
}
