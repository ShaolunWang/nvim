local M = {}
M.plugins = {
	-- { 'akinsho/toggleterm.nvim', opt = true },
	{ 'nvzone/floaterm', opt = true },
}
function M.load()
	require('lze').load({
		--[[ {
			'toggleterm.nvim',
			after = function()
				require('toggleterm').setup({
					shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell' or vim.o.shell,
					open_mapping = '<c-s>',
				})
			end,
			keys = { '<c-s>' },
		}, ]]
		{
			'floaterm',
			cmd = 'FloatermToggle',
			after = function()
				require('floaterm').setup({
					border = false,
					size = { h = 60, w = 70 },

					-- to use, make this func(buf)
					mappings = { sidebar = nil, term = nil },

					-- Default sets of terminals you'd like to open
					terminals = {
						{ name = 'Terminal' },
						-- cmd can be function too
						{ name = 'Terminal', cmd = 'neofetch' },
						-- More terminals
					},
				})
			end,
		},
	})
end
return M
