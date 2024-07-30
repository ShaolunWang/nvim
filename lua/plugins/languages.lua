local lsp_keymap = require('keymap.lsp_keymaps')
local utils = require('utils.lsp')
return {
	{ 'folke/lazydev.nvim', opts = {}, ft = { 'lua' } },
	{
		'mrcjkb/rustaceanvim',
		opts = {},
		config = function()
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
			require('clangd_extensions').setup()
		end,
		ft = { 'cpp', 'h' },
	},
	{
		'mrcjkb/haskell-tools.nvim',
		version = '^3', -- Recommended
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
		opts = {},
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
			format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
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
	{
		'mfussenegger/nvim-lint',
		config = function()
			require('lint').linters_by_ft = {
				markdown = { 'vale' },
			}
		end,
	},
}
