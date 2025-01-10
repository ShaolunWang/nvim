return {
	'saghen/blink.cmp',
	-- optional: provides snippets for the snippet source
	event = 'InsertEnter',
	version = 'v0.*',
	dependencies = {
		{ 'rafamadriz/friendly-snippets' },
		--		{ 'saadparwaiz1/cmp_luasnip' },
		-- { 'lukas-reineke/cmp-rg' },
		'mikavilpas/blink-ripgrep.nvim',
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
			--			list = { selection = 'preselect' },
			trigger = {
				--show_on_keyword = false,
				show_on_trigger_character = false,
			},
			menu = {
				auto_show = function(ctx)
					return ctx.mode ~= 'cmdline'
				end,
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
			cmdline = {
				preset = 'none',
			},
		},

		snippets = { preset = 'luasnip' },
		sources = {
			default = {
				'lsp',
				'path',
				'snippets',
				'ripgrep',
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
	},
}
