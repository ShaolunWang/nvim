local M = {}

M.plugins = {
	{ 'rafamadriz/friendly-snippets', opt = true },
	{
		'L3MON4D3/LuaSnip',
		-- follow latest release.
		branch = 'v2.3.0',
		opt = true,
	},
	{
		'chrisgrieser/nvim-scissors',
		opt = true,
	},
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
				require('luasnip.loaders.from_vscode').lazy_load()
			end,
		},
		{
			'scissors',
			after = function()
				require('scissors').setup({
					snippetDir = vim.fn.stdpath('config') .. '/snips/json_style/',
					jsonFormatter = 'jq',
				})
			end,
			cmd = { 'ScissorsAddNewSnippet', 'ScissorsEditSnippet' },
		},
		{
			'iurimateus/luasnip-latex-snippets.nvim',
			-- vimtex isn't required if using treesitter
			build = 'make install_jsregexp',
			after = function()
				require('luasnip-latex-snippets').setup()
				require('luasnip').config.setup({ enable_autosnippets = true })
			end,
			ft = { 'tex' },
		},
	})
end
return M
