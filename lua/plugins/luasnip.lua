local M = {}

M.plugins = {
	{ src = 'https://github.com/rafamadriz/friendly-snippets.git' },
	{ src = 'https://github.com/evesdropper/luasnip-latex-snippets.nvim.git' },
	{ src = 'https://github.com/L3MON4D3/LuaSnip.git' },
	{ src = 'https://github.com/chrisgrieser/nvim-scissors.git' },
}

function M.load()
	require('lze').load({
		{
			'LuaSnip',
			dep_of = { 'luasnip-latex-snippets', 'scissors', 'blink.cmp' },
			after = function()
				require('luasnip').config.set_config({ -- Setting LuaSnip config
					-- Enable autotriggered snippets
					enable_autosnippets = true,
				})
				require('luasnip.loaders.from_lua').load({ paths = vim.fn.stdpath('config') .. '/snips/lua_style/' })
				require('luasnip.loaders.from_vscode').lazy_load({ paths = vim.fn.stdpath('config') .. '/snips/json_style/' })
			end,
			on_require = { 'luasnip' },
		},
		{
			'nvim-scissors',
			after = function()
				require('scissors').setup({
					snippetDir = vim.fn.stdpath('config') .. '/snips/json_style/',
					jsonFormatter = 'jq',
				})
			end,
			cmd = { 'ScissorsAddNewSnippet', 'ScissorsEditSnippet' },
		},
		{
			'luasnip-latex-snippets.nvim',
			-- vimtex isn't required if using treesitter
			-- build = 'make install_jsregexp',
			on_require = { 'luasnip' },
		},
	})
end
return M
