M = {}
M.plugins = {
	{ 'neovim/nvim-lspconfig' },
}
function M.load()
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

	vim.lsp.config('basedpyright', {
		filetypes = { 'python' },
		settings = {
			basedpyright = {
				analysis = {
					diagnosticMode = 'openFilesOnly',
				},
			},
		},
	})
	vim.lsp.config('clangd', {
		filetypes = { 'c', 'h', 'cpp', 'hpp' },
		init_options = {
			usePlaceholders = true,
			completeUnimported = true,
			clangdFileStatus = true,
		},
		cmd = {
			'clangd',
			'--background-index',
			'--clang-tidy',
			'--header-insertion=never',
			'--completion-style=detailed',
			'--function-arg-placeholders',
			'--fallback-style=llvm',
		},
	})
	vim.lsp.config('lua_ls', {
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath('config')
					and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
				then
					return
				end
			end

			client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
				runtime = {
					-- Tell the language server which version of Lua you're using (most
					-- likely LuaJIT in the case of Neovim)
					version = 'LuaJIT',
					-- Tell the language server how to find Lua modules same way as Neovim
					-- (see `:h lua-module-load`)
					path = {
						'lua/?.lua',
						'lua/?/init.lua',
					},
				},
				-- Make the server aware of Neovim runtime files
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
						-- Depending on the usage, you might want to add additional paths
						-- here.
						-- '${3rd}/luv/library'
						-- '${3rd}/busted/library'
					},
					-- Or pull in all of 'runtimepath'.
					-- NOTE: this is a lot slower and will cause issues when working on
					-- your own configuration.
					-- See https://github.com/neovim/nvim-lspconfig/issues/3189
					-- library = {
					--   vim.api.nvim_get_runtime_file('', true),
					-- }
				},
			})
		end,
		settings = {
			Lua = {},
		},
	})
	vim.lsp.config('tinymist', {
		filetypes = { 'typ' },
		settings = {
			formatterMode = 'typstyle',
			exportPdf = 'onType',
			semanticTokens = 'disable',
		},
	})
	vim.lsp.config('omnisharp', {
		filetypes = { 'cs' },
		settings = {
			FormattingOptions = {
				EnableEditorConfigSupport = false,
				OrganizeImports = true,
			},
			Sdk = {
				IncludePrereleases = true,
			},
		},
	})
	vim.lsp.enable({
		'lua_ls',
		'omnisharp',
		'clangd',
		'tinymist',
		'basedpyright',
	})
end
return M
