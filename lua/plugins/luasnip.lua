return {
	'L3MON4D3/LuaSnip',
	-- follow latest release.
	version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	--	build = "make install_jsregexp",
	config = function()
		require('luasnip').config.set_config({ -- Setting LuaSnip config

			-- Enable autotriggered snippets
			enable_autosnippets = true,
		})
		require('luasnip.loaders.from_lua').load({ paths = vim.fn.stdpath('config') .. '/snippets/' })
	end,
	event = 'InsertEnter',
}
