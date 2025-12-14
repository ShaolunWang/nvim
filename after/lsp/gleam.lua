local lsp_keymap = require('keymap.lsp_keymaps')
local utils = require('utils.lsp')
local c = require('blink.cmp').get_lsp_capabilities(utils.c)

return {
	filetype = { 'gleam' },
	cmd = { 'gleam', 'lsp' },
	root_markers = { 'gleam.toml', '.git' },
	on_attach = lsp_keymap.on_attach,
	handlers = utils.lsp_handlers,
	capabilities = c,
}
