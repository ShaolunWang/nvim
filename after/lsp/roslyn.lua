local lsp_keymap = require('keymap.lsp_keymaps')
local utils = require('utils.lsp')

local c = require('blink.cmp').get_lsp_capabilities(utils.c)

return {
	filetypes = { 'cs' },
	on_attach = lsp_keymap.on_attach,
	handlers = utils.lsp_handlers,
	capabilities = c,

	settings = {
		['csharp|inlay_hints'] = {
			csharp_enable_inlay_hints_for_implicit_object_creation = true,
			csharp_enable_inlay_hints_for_implicit_variable_types = true,
		},
		['csharp|code_lens'] = {
			dotnet_enable_references_code_lens = true,
		},
	},
}
