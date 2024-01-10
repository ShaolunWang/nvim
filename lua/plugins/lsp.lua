-- :fennel:1704812508
local function _1_()
	local utils = require('utils.lsp')
	vim.o.updatetime = 1
	vim.cmd(
		'      highlight DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold\n      highlight DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold\n      highlight DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold\n      highlight DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold\n\n      sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError\n      sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn\n      sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo\n      sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint\n    '
	)
	local lsp = require('lspconfig')
	local lsp_keymap = require('keymap.lsp_keymaps')
	lsp.pyright.setup({ handlers = utils.lsp_handlers, on_attach = lsp_keymap.on_attach })
	lsp.ruff_lsp.setup({ handlers = utils.lsp_handlers, on_attach = lsp_keymap.on_attach })
	lsp.ocamllsp.setup({ handlers = utils.lsp_handlers, on_attach = lsp_keymap.on_attach })
	local clang_handlers = utils.lsp_handlers
	local no_diagnostic
	local function _2_() end
	no_diagnostic = { ['textDocument/publishDiagnostics'] = _2_ }
	for k, v in pairs(no_diagnostic) do
		clang_handlers[k] = v
	end
	local function _3_(client, bufnr)
		require('clangd_extensions.inlay_hints').setup_autocmd()
		require('clangd_extensions.inlay_hints').set_inlay_hints()
		return lsp_keymap.on_attach(client, bufnr)
	end
	return lsp.clangd.setup({ handlers = utils.lsp_handlers, on_attach = _3_ })
end
return { 'neovim/nvim-lspconfig', config = _1_, ft = { 'python', 'ocaml', 'cpp', 'ts' } }
