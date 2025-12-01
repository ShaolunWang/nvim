local lsp_keymap = require('keymap.lsp_keymaps')
local utils = require('utils.lsp')
local M = {}
M.plugins = {
	{ src = 'https://github.com/vlime/vlime' },
	{ src = 'https://github.com/apyra/nvim-unity-sync' },
	{ src = 'https://github.com/windwp/nvim-ts-autotag' },
	{ src = 'https://github.com/folke/lazydev.nvim' },
	{ src = 'https://github.com/julienvincent/nvim-paredit' },
	{ src = 'https://github.com/mrcjkb/rustaceanvim' },
	{ src = 'https://github.com/p00f/clangd_extensions.nvim' },
	{ src = 'https://github.com/folke/trouble.nvim' },
	{ src = 'https://github.com/stevearc/conform.nvim' },
	{ src = 'https://github.com/fei6409/log-highlight.nvim' },
	{ src = 'https://github.com/Bekaboo/dropbar.nvim' },
	{ src = 'https://github.com/lervag/vimtex' },
	{ src = 'https://github.com/pmizio/typescript-tools.nvim' },
	{ src = 'https://github.com/seblyng/roslyn.nvim' },
}

function M.load()
	-- we don't need immediate load of any of these
	require('lze').load({
		{
			'nvim-ts-autotag',
			ft = { 'typescript', 'javascript' },
			after = function()
				require('nvim-ts-autotag').setup({
					opts = {
						-- Defaults
						enable_close = true, -- Auto close tags
						enable_rename = true, -- Auto rename pairs of tags
						enable_close_on_slash = true, -- Auto close on trailing </
					},
				})
			end,
		},
		{
			'vlime',
			after = function()
				vim.g['vlime_cl_impl'] = 'ccl'
				vim.g['vlime_force_default_keys'] = true
				vim.g['vlime_leader'] = ';'
				vim.g['vlime_contribs'] = {
					'SWANK-ASDF',
					'SWANK-PACKAGE-FU',
					'SWANK-PRESENTATIONS',
					'SWANK-FANCY-INSPECTOR',
					'SWANK-C-P-C',
					'SWANK-ARGLISTS',
					'SWANK-REPL',
					'SWANK-FUZZY',
					'SWANK-TRACE-DIALOG',
				}
			end,
			ft = 'lisp',
		},
		{
			'nvim-paredit',
			after = function()
				require('nvim-paredit').setup()
			end,
			ft = 'lisp',
		},
		{
			'lazydev.nvim',
			ft = 'lua', -- only load on lua files
			after = function()
				require('lazydev').setup({
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
						{ path = 'snacks.nvim', words = { 'Snacks' } },
						{ path = 'lazy.nvim', words = { 'LazyVim' } },
					},
				})
			end,
		},
		{
			'rustaceanvim',
			ft = 'rust',
			after = function()
				vim.lsp.inlay_hint.enable()
				vim.g.rustaceanvim = {
					-- Plugin configuration
					tools = {},
					-- LSP configuration
					server = {
						on_attach = lsp_keymap.on_attach,
						handlers = utils.lsp_handlers,
						settings = {
							-- rust-analyzer language server configuration
							['rust-analyzer'] = {
								checkOnSave = true,
								check = {
									enable = true,
									command = 'clippy',
									features = 'all',
								},
							},
						},
					},
					-- DAP configuration
					dap = {},
				}
			end,
		},
		{
			'trouble.nvim',
			after = function()
				require('trouble').setup({
					auto_close = false,
					auto_open = false,
					auto_preview = false, -- automatically open preview when on an item
					win = {
						type = 'split',
						relative = 'editor',
						size = 0.25,
					},
				})
			end,
			cmd = { 'Trouble' },
		},
		{
			'clangd_extensions.nvim',
			ft = { 'cpp', 'h', 'cxx', 'hpp' },
			after = function()
				require('clangd_extensions').setup({
					inlay_hints = {
						inline = false,
					},
					ast = {
						--These require codicons (https://github.com/microsoft/vscode-codicons)
						role_icons = {
							type = '',
							declaration = '',
							expression = '',
							specifier = '',
							statment = '',
							['template argument'] = '',
						},
						kind_icons = {
							Compound = '',
							Recovery = '',
							TranslationUnit = '',
							PackExpansion = '',
							TemplateTypeParm = '',
							TemplateTemplateParm = '',
							TemplateParamObject = '',
						},
					},
				})
			end,
		},

		{
			'vimtex',
			lazy = false,
			-- ft = { 'latex' },
			before = function()
				-- VimTeX configuration goes here, e.g.
				--			vim.g.vimtex_view_general_viewer = 'okular'
				--			vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'
				vim.g.vimtex_latex_viewer = 'skimpdf'
				vim.g.vimtex_compiler_method = 'latexmk'
				vim.g.vimtex_compiler_engine = 'lualatex'

				-- vim.cmd([[
				--   let g:vimtex_compiler_method = 'generic'
				--   let g:vimtex_compiler_generic = {
				-- 		\ 'command': 'ls *.tex | entr -c tectonic /_ --synctex --keep-logs',
				-- 		\}
				-- ]])
				vim.cmd([[
				let g:vimtex_compiler_latexmk = {
					\ 'options' : [
					\   '-interaction=nonstopmode',
					\   '-shell-escape',
					\ ],
					\ 'build_dir' : 'livepreview'}
				]])
			end,
		},
		{
			'dropbar.nvim',
			after = function()
				require('dropbar').setup({ { general = { enable = false } } })
			end,
			events = 'BufReadPost',
		},
		{
			'log-highlight.nvim',
			ft = { 'log' },
		},
		{
			'conform.nvim',
			event = { 'BufWritePre' },
			cmd = { 'ConformInfo' },
			keys = {
				{
					-- Customize or remove this keymap to your liking
					'\\f',
					function()
						require('conform').format({ async = true, lsp_format = 'fallback' })
					end,
					mode = '',
					desc = 'Format buffer',
				},
			},
			-- Everything in opts will be passed to setup()
			after = function()
				require('conform').setup({
					-- Define your formatters
					formatters_by_ft = {
						lua = { 'stylua' },
						python = { 'isort', 'black' },
						cpp = { 'clang-format' },
						format_on_save = { async = true },
					},
				})
			end,
			before = function()
				-- If you want the formatexpr, here is the place to set it
				vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
			end,
		},
		{
			'typescript-tools.nvim',
			after = function()
				require('typescript-tools').setup({
					on_attach = lsp_keymap.on_attach,
					handlers = utils.lsp_handlers,
				})
			end,
			ft = { 'typescript', 'typescriptreact', 'typescript.tsx' },
		},
		{
			'nvim-unity-sync',
			after = function()
				require('unity.plugin').setup()
			end,
			ft = { 'cs' },
		},
		{
			'roslyn.nvim',
			after = function()
				require('roslyn').setup()
			end,
			ft = { 'cs' },
		},
	})
end

return M
