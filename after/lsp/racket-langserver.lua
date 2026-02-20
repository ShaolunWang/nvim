local utils = require('utils.lsp')

local c = require('blink.cmp').get_lsp_capabilities(utils.c)
local lsp_keymap = require('keymap.lsp_keymaps')

return {
	cmd = { 'racket', '--lib', 'racket-langserver' },
	filetypes = { 'racket', 'scheme' },
	root_markers = { '.git' },

	on_attach = lsp_keymap.on_attach,
	handlers = utils.lsp_handlers,
	capabilities = c,
}
