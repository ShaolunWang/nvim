local lsp_keymap = require('keymap.lsp_keymaps')
local utils = require('utils.lsp')
local M = {}
M.plugins = {
	{ 'folke/lazydev.nvim', opt = true },
	{ 'mrcjkb/rustaceanvim', opt = true },
	{ 'folke/trouble.nvim', opt = true },
	{ 'p00f/clangd_extensions.nvim', opt = true },
	{ 'folke/trouble.nvim', opt = true },
	{ 'stevearc/conform.nvim', opt = true },
	{ 'fei6409/log-highlight.nvim', opt = true },
	{ 'Bekaboo/dropbar.nvim', opt = true },
	{ 'lervag/vimtex', opt = true },
	{ 'ThePrimeagen/refactoring.nvim', opt = true },
}

function M.load()
	require('lze').load({

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
			'refactoring.nvim',
			cmd = { 'Refactor' },
			-- fundo and ufo requires plenary and promise async before this
			keys = {'<leader>r'},
			after = function()
				require('refactoring').setup({
					prompt_func_return_type = {
						go = false,
						java = false,
						cpp = true,
						c = false,
						h = true,
						hpp = false,
						cxx = true,
					},
					prompt_func_param_type = {
						go = false,
						java = false,
						cpp = true,
						c = true,
						h = false,
						hpp = false,
						cxx = true,
					},
				})
			end,
		},
		{
			'vimtex',
			ft = { 'tex' },
			before = function()
				-- VimTeX configuration goes here, e.g.
				--			vim.g.vimtex_view_general_viewer = 'okular'
				--			vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'
				vim.g.vimtex_latex_viewer = 'sioyek'
				vim.g.vimtex_compiler_method = 'latexmk'
				-- vim.cmd([[
				--   let g:vimtex_compiler_method = 'generic'
				--   let g:vimtex_compiler_generic = {
				-- 		\ 'command': 'ls *.tex | entr -c tectonic /_ --synctex --keep-logs',
				-- 		\}
				-- ]])
			end,
		},
		{
			'dropbar.nvim',
			after = function()
				require('dropbar').setup({ { general = { enable = false } } })
			end,
			events = 'BufRead',
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
			on_require = { 'conform' },
			before = function()
				-- If you want the formatexpr, here is the place to set it
				vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
			end,
		},
	})
end

return M
