-- :fennel:1704812508
local M = {}
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
local function opt_desc(opt, description)
	table.desc = description
	return opt
end
M.on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	local bufopts = { buffer = bufnr, noremap = true, silent = true }
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opt_desc(bufopts, 'hover'))
	vim.keymap.set('n', '\\D', vim.lsp.buf.type_definition, opt_desc(bufopts, 'Jumps to type def'))
	vim.keymap.set('n', '\\r', vim.lsp.buf.rename, opt_desc(bufopts, 'Rename Variable'))
	vim.keymap.set('n', '\\a', vim.lsp.buf.code_action, opt_desc(bufopts, 'Code Action'))
	vim.keymap.set('n', '\\q', vim.diagnostic.setloclist, opt_desc(opts, 'Diag Loclist'))
	local function _1_()
		return vim.lsp.buf.format({ async = true })
	end
	vim.keymap.set('n', '\\f', _1_, opt_desc(bufopts, 'format code'))
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opt_desc(bufopts, 'Goto Decl'))
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opt_desc(bufopts, 'Goto Def'))
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opt_desc(bufopts, 'Show Impl'))
	vim.keymap.set('n', 'gK', vim.diagnostic.open_float, opt_desc(bufopts, 'Line Diag'))
	return vim.keymap.set('n', 'gr', vim.lsp.buf.references, opt_desc(bufopts, 'Show References'))
end
return M
