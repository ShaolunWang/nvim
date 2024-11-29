return {
	'saghen/blink.cmp',
	-- optional: provides snippets for the snippet source
	lazy = false,
	version = 'v0.*',
	dependencies = {
		{ 'rafamadriz/friendly-snippets' },
		{ 'saadparwaiz1/cmp_luasnip' },
		-- { 'lukas-reineke/cmp-rg' },
		{
			'saghen/blink.compat',
			opts = {
				-- lazydev.nvim only registers the completion source when nvim-cmp is
				-- loaded, so pretend that we are nvim-cmp, and that nvim-cmp is loaded.
				-- this option only has effect when using lazy.nvim
				-- this should not be required in most cases
				impersontate_nvim_cmp = true,
			},
		},
	},

	opts = {
		completion = {
			ghost_text = { enabled = true },
			list = { selection = 'auto_insert' },
			trigger = {
				show_on_insert_on_trigger_character = false,
			}
		},

		keymap = {
			['<c-m>'] = { 'show' },
			['<c-h>'] = { 'hide' },
			['<Tab>'] = { 'select_and_accept', 'fallback' },
			['<cr>']  = { 'select_and_accept', 'fallback' },
			['<C-p>'] = { 'select_prev' },
			['<C-n>'] = { 'select_next' },
			['<c-d>'] = { 'snippet_forward' },
			['<c-u>'] = { 'snippet_backward ' },
		},

		snippets = {
			expand = function(snippet)
				require('luasnip').lsp_expand(snippet)
			end,
			active = function(filter)
				if filter and filter.direction then
					return require('luasnip').jumpable(filter.direction)
				end
				return require('luasnip').in_snippet()
			end,
			jump = function(direction)
				require('luasnip').jump(direction)
			end,
		},
		sources = {
			completion = {
				enabled_providers = {
					'lsp',
					'path',
					'snippets',
					'luasnip',
					--[[ 'buffer', 'rg', 'luasnip' ]]
				},
			},
			providers = {
				lsp = { module = 'blink.cmp.sources.lsp', name = 'LSP', enabled = true, score_offset = -1 },
				path = {
					name = 'Path',
					module = 'blink.cmp.sources.path',
					score_offset = 0,
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context)
							return vim.fn.expand(('#%d:p:h'):format(context.bufnr))
						end,
						show_hidden_files_by_default = false,
					},
				},
				buffer = { module = 'blink.cmp.sources.buffer', name = 'Buffer', enabled = true, fallback_for = { 'LSP' } },
				luasnip = {
					name = 'luasnip',
					module = 'blink.compat.source',

					score_offset = -3,

					opts = {
						use_show_condition = false,
						show_autosnippets = true,
					},
				},
				--[[ 				rg = {
					module = 'blink.compat.source',
					name = 'rg',
					enabled = true,
					score_offset = -3,
					fallback_for = { 'Buffer' },
					transform_items = function(ctx, items)
						-- TODO: check https://github.com/Saghen/blink.cmp/pull/253#issuecomment-2454984622
						local kind = require('blink.cmp.types').CompletionItemKind.Text

						for i = 1, #items do
							items[i].kind = kind
						end

						return items
					end,
				}, ]]
			},
		},
	},
}
