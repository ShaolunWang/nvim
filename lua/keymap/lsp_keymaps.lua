local M = {}

local opts = { noremap = true, silent = true }

local function add_desc(opt, description)
	opt.desc = description
	return opt
end

function M.on_attach(client, bufnr)
	--	local navic = require('nvim-navic')
	--	if client.server_capabilities.documentSymbolProvider then
	--		navic.attach(client, bufnr)
	--	end
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

	-- Enable completion triggered by <c-x><c-o>
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, add_desc(bufopts, 'hover'))
	vim.keymap.set('n', '\\D', vim.lsp.buf.type_definition, add_desc(bufopts, 'Jumps to type def'))
	vim.keymap.set('n', '\\r', vim.lsp.buf.rename, add_desc(bufopts, 'Rename Variable'))
	vim.keymap.set('n', '\\a', vim.lsp.buf.code_action, add_desc(bufopts, 'Code Action'))
	vim.keymap.set('n', '\\q', vim.diagnostic.setloclist, add_desc(opts, 'Diag Loclist'))
	vim.keymap.set('n', '\\f', function()
		require('conform').format()
		--		vim.lsp.buf.format({ async = true })
	end, add_desc(bufopts, 'format code'))
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, add_desc(bufopts, 'Goto Decl'))
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, add_desc(bufopts, 'Goto Def'))
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, add_desc(bufopts, 'Show Impl'))
	vim.keymap.set('n', 'gK', vim.diagnostic.open_float, add_desc(bufopts, 'Line Diag'))
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, add_desc(bufopts, 'Show References'))
end

return M
