local M = {}
M.plugins = {
	{ 'saghen/blink.cmp', opt = true, build = 'cargo build --release' },
	{ 'mikavilpas/blink-ripgrep.nvim', opt = true },
	{ 'saghen/blink.compat', opt = true },
	{ 'xzbdmw/colorful-menu.nvim', opt = true },
}

function M.load()
	require('lze').load({
		{ 'blink-ripgrep.nvim', dep_of = { 'blink.cmp' } },
		{
			'colorful-menu.nvim',
			dep_of = { 'blink.cmp' },
			after = function()
				require('colorful-menu').setup({})
			end,
		},
		{ 'blink.compat', dep_of = { 'blink.cmp' } },
		{
			'blink.cmp',
			dep_of = { 'nvim-lspconfig' },
			after = function()
				require('blink.cmp').setup({
					completion = {
						ghost_text = { enabled = true },
						--			list = { selection = 'preselect' },
						trigger = {
							--show_on_keyword = false,
							show_on_trigger_character = false,
						},
						menu = {
							auto_show = function(ctx)
								return ctx.mode ~= 'cmdline'
							end,
							draw = {
								-- We don't need label_description now because label and label_description are already
								-- combined together in label by colorful-menu.nvim.
								columns = { { 'kind_icon' }, { 'label', gap = 1 } },
								components = {
									label = {
										text = function(ctx)
											return require('colorful-menu').blink_components_text(ctx)
										end,
										highlight = function(ctx)
											return require('colorful-menu').blink_components_highlight(ctx)
										end,
									},
								},
							},
						},
					},

					keymap = {
						['<c-m>'] = { 'show' },
						['<c-h>'] = { 'hide' },
						['<Tab>'] = { 'select_and_accept', 'fallback' },
						['<cr>'] = { 'select_and_accept', 'fallback' },
						['<C-p>'] = { 'select_prev' },
						['<C-n>'] = { 'select_next' },
						['<c-d>'] = { 'snippet_forward' },
						['<c-u>'] = { 'snippet_backward' },
					},
					cmdline = {
						keymap = { preset = 'none' },
					},

					snippets = { preset = 'luasnip' },
					sources = {
						default = {
							'lsp',
							'path',
							'snippets',
							-- 'ripgrep',
						},
						providers = {
							lsp = {
								module = 'blink.cmp.sources.lsp',
								name = 'LSP',
								enabled = true,
								score_offset = -1,
								fallbacks = { 'Buffer' },
							},
							path = {
								name = 'Path',
								module = 'blink.cmp.sources.path',
								score_offset = -3,
								opts = {
									trailing_slash = false,
									label_trailing_slash = true,
									get_cwd = function(context)
										return vim.fn.expand(('#%d:p:h'):format(context.bufnr))
									end,
									show_hidden_files_by_default = false,
								},
							},
							buffer = { module = 'blink.cmp.sources.buffer', name = 'Buffer', enabled = true },
							ripgrep = {
								module = 'blink-ripgrep',
								name = 'Ripgrep',
								opts = {
									prefix_min_len = 3,

									context_size = 5,

									max_filesize = '1M',
									project_root_marker = { '.git', '.rgignore' },

									-- The casing to use for the search in a format that ripgrep
									-- accepts. Defaults to "--ignore-case". See `rg --help` for all the
									-- available options ripgrep supports, but you can try
									-- "--case-sensitive" or "--smart-case".
									search_casing = '--smart-case',
									additional_rg_options = { '--hidden', '--vimgrep', '--no-heading' },

									fallback_to_regex_highlighting = true,

									debug = false,
								},
							},
						},
					},
				})
			end,
			event = 'InsertEnter',
		},
	})
end
return M
