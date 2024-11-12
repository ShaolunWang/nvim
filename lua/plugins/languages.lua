local lsp_keymap = require('keymap.lsp_keymaps')
local utils = require('utils.lsp')
return {
	{ 'folke/lazydev.nvim', opts = {}, ft = { 'lua' } },
	{
		'folke/lazydev.nvim',
		ft = 'lua', -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = 'luvit-meta/library', words = { 'vim%.uv' } },
			},
		},
	},
	{ 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
	{
		'mrcjkb/rustaceanvim',
		opts = {},
		config = function()
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
		ft = { 'rust' },
	},
	{
		'p00f/clangd_extensions.nvim',
		config = function()
			require('clangd_extensions').setup({})
		end,
		ft = { 'cpp', 'h' },
	},
	{
		'mrcjkb/haskell-tools.nvim',
		version = '^3', -- Recommended
		config = function()
			vim.g.haskell_tools = {
				hls = {
					on_attach = lsp_keymap.on_attach,
				},
			}
		end,
		lazy = false,
		ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
	},
	{
		'Badhi/nvim-treesitter-cpp-tools',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'jakemason/ouroboros.nvim' },
		-- Optional: Configuration
		opts = function()
			local options = {
				preview = {
					quit = 'q', -- optional keymapping for quit preview
					accept = '<tab>', -- optional keymapping for accept preview
				},
				header_extension = 'h', -- optional
				source_extension = 'cpp', -- optional
				custom_define_class_function_commands = { -- optional
					TSCppImplWrite = {
						output_handle = require('nt-cpp-tools.output_handlers').get_add_to_cpp(),
					},
					--[[
                <your impl function custom command name> = {
                    output_handle = function (str, context)
                        -- string contains the class implementation
                        -- do whatever you want to do with it
                    end
                }
                ]]
				},
			}
			return options
		end,
		ft = { 'cpp', 'h' },
		-- End configuration
		--		config = true,
	},
	--[[ {
		'mfussenegger/nvim-lint',
		config = function()
			require('lint').linters_by_ft = {
				cpp = { 'clang-tidy', }
			}
		end,
	}, ]]
	{
		'folke/trouble.nvim',
		opts = {
			auto_close = false,
			auto_open = false,
			auto_preview = false, -- automatically open preview when on an item
			win = {
				type = 'split',
				relative = 'editor',
				size = 0.25,
			},
		},
		lazy = true,
		cmd = { 'Trouble' },
	},
	{
		'stevearc/conform.nvim',
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
		opts = {
			-- Define your formatters
			formatters_by_ft = {
				lua = { 'stylua' },
				python = { 'isort', 'black' },
				cpp = { 'clang-format' },
			},
			-- Set up format-on-save
			--			format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
			-- Customize formatters
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
	{
		'fei6409/log-highlight.nvim',
		opts = {},
		ft = { 'log' },
	},
	{ 'Bekaboo/dropbar.nvim', opts = { { general = { enable = false } } }, events = 'VeryLazy' },
	{
		'lervag/vimtex',
		dependencies = {},
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here, e.g.
			--			vim.g.vimtex_view_general_viewer = 'okular'
			--			vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'
			vim.g.vimtex_latex_viewer = 'skim'
			vim.g.vimtex_compiler_method = 'latexmk'
			-- vim.cmd([[
			--   let g:vimtex_compiler_method = 'generic'
			--   let g:vimtex_compiler_generic = {
			-- 		\ 'command': 'ls *.tex | entr -c tectonic /_ --synctex --keep-logs',
			-- 		\}
			-- ]])
		end,
	},
}
