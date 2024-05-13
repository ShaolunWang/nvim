local lsp_keymap = require('keymap.lsp_keymaps')
local utils = require('utils.lsp')
return {
	{ 'folke/neodev.nvim', opts = {}, ft = { 'lua' } },
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
		'jakemason/ouroboros.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		ft = { 'cpp', 'h', 'hpp' },
	},
	{
		'Badhi/nvim-treesitter-cpp-tools',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'jakemason/ouroboros.nvim' },
		-- Optional: Configuration
		opts = function()
			local options = {
				preview = {
					quit = 'q',               -- optional keymapping for quit preview
					accept = '<tab>',         -- optional keymapping for accept preview
				},
				header_extension = 'h',       -- optional
				source_extension = 'cpp',     -- optional
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
			auto_close = true,
			auto_open = false,
			win = {
				type = 'split',
				position = 'left',
				relative = 'win',
				size = .25,
			},
		},
	},
}
