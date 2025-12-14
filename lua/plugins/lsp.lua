M = {}
M.plugins = {}
vim.pack.add({ { src = 'https://github.com/neovim/nvim-lspconfig' } })

function M.load()
	require('lze').load({
		{
			'nvim-lspconfig',
			ft = { 'lua', 'cpp', 'c', 'h', 'typst', 'swift', 'csharp', 'hpp', 'python', 'gleam' },
			before = function()
				vim.lsp.log.set_level(vim.log.levels.ERROR)
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

				local lsp_keymap = require('keymap.lsp_keymaps')
				local utils = require('utils.lsp')

				local c = require('blink.cmp').get_lsp_capabilities(utils.c)
				vim.lsp.config('*', {
					on_attach = lsp_keymap.on_attach,
					handlers = utils.lsp_handlers,
					capabilities = c,
				})
				vim.lsp.enable({
					'lua_ls',
					'clangd',
					'gleam',
					'tinymist',
					'basedpyright',
					'sourcekit',
					'roslyn',
				})
			end,
		},
	})
end
return M
