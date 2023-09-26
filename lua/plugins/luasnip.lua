return {
	{
		'L3MON4D3/LuaSnip',

		dependencies = { 'rafamadriz/friendly-snippets' },
		-- follow latest release.
		version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- build = "make install_jsregexp",
		config = function()
			require('luasnip').config.set_config({ -- Setting LuaSnip config
				-- Enable autotriggered snippets
				enable_autosnippets = true,
			})
			require('luasnip.loaders.from_lua').load({ paths = vim.fn.stdpath('config') .. '/snips/lua_style/' })
			require('luasnip.loaders.from_vscode').lazy_load({ paths = vim.fn.stdpath('config') .. '/snips/json_style/' })
			require('luasnip.loaders.from_vscode').lazy_load()
		end,
		event = 'InsertEnter',
	},
	{
		'chrisgrieser/nvim-scissors',
		opts = {
			snippetDir = vim.fn.stdpath('config') .. '/snips/json_style/',
			jsonFormatter = 'jq',
		},
		cmd = { 'ScissorsAddNewSnippet', 'ScissorsEditSnippet' },
	},
}
