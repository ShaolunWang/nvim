return {
	'neovim/nvim-lspconfig',
	config = function()
		local utils = require('utils.lsp')
		vim.o.updatetime = 1
		vim.cmd([[
      highlight DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
      highlight DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
      highlight DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
      highlight DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

      sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
      sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
      sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
      sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
    ]])
		local coq_opts = require('coq')
		local lsp = require('lspconfig')
		local lsp_keymap = require('keymap.lsp_keymaps')

		-- simple example
		lsp.pyright.setup({
			on_attach = lsp_keymap.on_attach,
			capabilities = coq_opts.lsp_ensure_capabilities(utils.c),
			handlers = utils.lsp_handlers,
		})
		lsp.ruff_lsp.setup({
			on_attach = lsp_keymap.on_attach,
			capabilities = coq_opts.lsp_ensure_capabilities(utils.c),
			handlers = utils.lsp_handlers,
		})

		lsp.ocamllsp.setup({
			on_attach = lsp_keymap.on_attach,
			capabilities = coq_opts.lsp_ensure_capabilities(utils.c),
			handlers = utils.lsp_handlers,
		})
    local clang_handlers =  utils.lsp_handlers
    local no_diagnostic =  {
      ['textDocument/publishDiagnostics'] = function() end
    }
    for k, v in pairs(no_diagnostic) do
      clang_handlers[k] = v
    end 
		lsp.clangd.setup({
			on_attach = function(client, bufnr)
				require('clangd_extensions.inlay_hints').setup_autocmd()
				require('clangd_extensions.inlay_hints').set_inlay_hints()
				lsp_keymap.on_attach(client, bufnr)
			end,
			capabilities = coq_opts.lsp_ensure_capabilities(utils.c),
--			handlers = clang_handlers,
			handlers = utils.lsp_handlers,
		})
	end,
	ft = {
		-- make sure only adding configured ones here
		'python',
		'ocaml',
		'cpp',
		'ts',
	},
}
