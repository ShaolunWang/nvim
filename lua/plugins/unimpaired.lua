local M = {}
M.plugins = {

	{ 'tummetott/unimpaired.nvim', opt = true },
}
function M.load()
	require('lze').load({
		{
			'unimpaired.nvim',
			after = function()
				require('unimpaired').setup({
					default_keymaps = true,
					keymaps = {
						next = false,
						prev = false,
						toggle_spell = {
							mapping = ',s',
							description = 'Toggle spell check',
							dot_repeat = true,
						},
						toggle_background = {
							mapping = ',b',
							description = 'Toggle background light/dark',
							dot_repeat = true,
						},
						toggle_diff = false,
						enable_cursorline = false,
						disable_cursorline = false,
						toggle_cursorline = false,
						enable_diff = false,
						disable_diff = false,
						enable_hlsearch = false,
						disable_hlsearch = false,
						enable_ignorecase = false,
						disable_ignorecase = false,
						toggle_ignorecase = false,
						enable_list = false,
						disable_list = false,
						toggle_list = false,
						enable_number = false,
						disable_number = false,
						toggle_number = false,
						enable_relativenumber = false,
						disable_relativenumber = false,
						toggle_relativenumber = false,
						enable_spell = false,
						disable_spell = false,
						tprevious = false,
						tnext = false,
						-- exchange_section_above = {dot_repeat = true},
						-- exchange_section_below = {dot_repeat = true},
						-- exchange_above = {dot_repeat = true},
						-- exchange_below = {dot_repeat = true},
						exchange_section_above = false,
						exchange_section_below = false,
						exchange_above = false,
						exchange_below = false,
						enable_background = false,
						disable_background = false,
						enable_colorcolumn = false,
						disable_colorcolumn = false,
						toggle_colorcolumn = false,
						enable_cursorcolumn = false,
						disable_cursorcolumn = false,
						toggle_cursorcolumn = false,
						enable_virtualedit = false,
						disable_virtualedit = false,
						toggle_virtualedit = false,
						enable_wrap = false,
						disable_wrap = false,
						toggle_wrap = false,
						enable_cursorcross = false,
						disable_cursorcross = false,
						toggle_cursorcross = false,
					},
				})
			end,
			keys = { ',', '[', ']' },
		},
	})
end

return M
