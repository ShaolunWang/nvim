M = {}
function M.setup()
	require('lualine').setup({
		options = {
			theme = 'auto',

			section_separators = { left = '', right = '' },
			component_separators = { left = '', right = '' },

			globalstatus = true, -- enable global statusline (have a single statusline
		},
		sections = {
			lualine_a = { { 'mode', separator = { left = '', right = '' }, right_padding = 2 } },
			lualine_z = {
				{
					function()
						return ' ' .. os.date('%R')
					end,
					separator = { left = '', right = '' },
					left_padding = 2,
				},
			},
		},
	})
end
return M
