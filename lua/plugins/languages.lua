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
							}
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
}
