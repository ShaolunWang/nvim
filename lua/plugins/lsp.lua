return {
	'neovim/nvim-lspconfig',
	opts = {},
	config = function()
		local utils = require('utils.lsp')
		local c = require('blink.cmp').get_lsp_capabilities(utils.c)
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
		local lsp = require('lspconfig')
		local lsp_keymap = require('keymap.lsp_keymaps')

		-- simple example
		lsp.pyright.setup({
			on_attach = lsp_keymap.on_attach,
			handlers = utils.lsp_handlers,
			capabilities = c,
		})
		lsp.ruff.setup({
			on_attach = lsp_keymap.on_attach,
			handlers = utils.lsp_handlers,
			capabilities = c,
		})

		lsp.ocamllsp.setup({
			on_attach = lsp_keymap.on_attach,
			handlers = utils.lsp_handlers,
			capabilities = c,
		})
		local clang_handlers = utils.lsp_handlers
		local no_diagnostic = {
			['textDocument/publishDiagnostics'] = function() end,
		}
		--[[ 		for k, v in pairs(no_diagnostic) do
			clang_handlers[k] = v
		end ]]
		lsp.clangd.setup({
			init_options = {
				usePlaceholders = true,
				completeUnimported = true,
				clangdFileStatus = true,
			},
			cmd = {
				'clangd',
				'--background-index',
				'--clang-tidy',
				'--header-insertion=iwyu',
				'--completion-style=detailed',
				'--function-arg-placeholders',
				'--fallback-style=llvm',
			},
			on_attach = function(client, bufnr)
				lsp_keymap.on_attach(client, bufnr)
			end,
			handlers = utils.lsp_handlers,
			capabilities = c,
		})
		lsp.lua_ls.setup({
			on_init = function(client)
				local path = client.workspace_folders[1].name
				if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
					client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
						Lua = {
							runtime = {
								-- Tell the language server which version of Lua you're using
								-- (most likely LuaJIT in the case of Neovim)
								version = 'LuaJIT',
							},
							completion = {
								callSnippet = 'Replace',
							},
							-- Make the server aware of Neovim runtime files
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME,
									-- "${3rd}/luv/library"
									-- "${3rd}/busted/library",
								},
								-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
								-- library = vim.api.nvim_get_runtime_file("", true)
							},
						},
					})

					client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
				end
				return true
			end,
			on_attach = lsp_keymap.on_attach,
			handlers = utils.lsp_handlers,
			capabilities = c,
		})
		lsp.zls.setup({
			on_attach = lsp_keymap.on_attach,
			handlers = utils.lsp_handlers,
			capabilities = c,
		})
	end,
	ft = {
		-- make sure only adding configured ones here
		'python',
		'ocaml',
		'cpp',
		'c',
		'ts',
		'lua',
	},
}
