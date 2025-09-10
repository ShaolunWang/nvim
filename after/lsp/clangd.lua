local lsp_keymap = require('keymap.lsp_keymaps')
local utils = require('utils.lsp')

local c = require('blink.cmp').get_lsp_capabilities(utils.c)
return {
	filetypes = { 'c', 'h', 'cpp', 'hpp' },
	on_attach = lsp_keymap.on_attach,
	handlers = utils.lsp_handlers,
	capabilities = c,
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
	},
	cmd = {
		'clangd',
		'--background-index',
		'--clang-tidy',
		'--header-insertion=never',
		'--completion-style=detailed',
		'--function-arg-placeholders',
		'--fallback-style=llvm',
	},
}
