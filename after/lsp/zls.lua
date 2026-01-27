local lsp_keymap = require('keymap.lsp_keymaps')
local utils = require('utils.lsp')

local c = require('blink.cmp').get_lsp_capabilities(utils.c)

return {
	filetypes = { 'zig', 'zir' },
	cmd = { 'zls' },
	root_markers = { 'zls.json', 'build.zig', '.git' },
	on_attach = lsp_keymap.on_attach,
	handlers = utils.lsp_handlers,
	capabilities = c,
}
