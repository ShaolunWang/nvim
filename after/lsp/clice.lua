local lsp_keymap = require('keymap.lsp_keymaps')
local utils = require('utils.lsp')

local c = require('blink.cmp').get_lsp_capabilities(utils.c)

local clice = {
	filetypes = { 'c', 'cpp', 'h', 'hpp' },

	root_markers = {
		'.git/',
		'clice.toml',
		'.clang-tidy',
		'.clang-format',
		'compile_commands.json',
		'compile_flags.txt',
		'configure.ac', -- AutoTools
	},
	handlers = utils.lsp_handlers,
	on_attach = lsp_keymap.on_attach,
	capabilities = vim.tbl_deep_extend('force', c, {
		textDocument = {
			completion = {
				editsNearCursor = true,
			},
		},
		offsetEncoding = { 'utf-8' },
	}),

	cmd = {
		'clice',
		'server',
	},
}

return clice
