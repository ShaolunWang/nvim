local lsp_keymap = require('keymap.lsp_keymaps')
local utils = require('utils.lsp')

local c = require('blink.cmp').get_lsp_capabilities(utils.c)

return {
	on_attach = lsp_keymap.on_attach,
	handlers = utils.lsp_handlers,
	capabilities = c,

	filetypes = { 'python' },
}
