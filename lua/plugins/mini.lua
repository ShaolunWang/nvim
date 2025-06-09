local M = {}
M.plugins = {
	{ 'echasnovski/mini.nvim', branch = 'main' },
}

function M.load()
	require('lze').load({
		{ 'nvim-web-devicons', enabled = false, optional = true },
		{
			'mini.nvim',
			-- event = 'BufReadPost',
			-- on_require = { 'mini.pick' },
			-- cmd = { 'Pick' },
			lazy = false,
			after = function()
				require('mini.icons').setup()
				require('mini.icons').mock_nvim_web_devicons()
				-- require('mini.pick').setup()
				require('mini.ai').setup()
				require('mini.indentscope').setup({
					draw = {
						animation = function()
							return 1
						end,
					},
					symbol = '│',
				})
				--		require('mini.comment').setup()
				require('mini.animate').setup({
					scroll = { enable = false },
					cursor = { enable = false },
				})
				require('mini.cursorword').setup()
				require('mini.move').setup({
					mappings = {
						-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
						left = '',
						right = '',

						down = ']e',
						up = '[e',

						-- Move current line in Normal mode
						line_left = '',
						line_right = '',
						line_down = ']e',
						line_up = '[e',
					},
					options = {
						-- Automatically reindent selection during linewise vertical move
						reindent_linewise = true,
					},
				})
				require('mini.visits').setup()

				--		vim.ui.select = MiniPick.ui_select
				-- xxx cterm=underline gui=underline
				require('mini.surround').setup({
					mappings = {
						add = 'sa', -- Add surrounding in Normal and Visual modes
						delete = 'sd', -- Delete surrounding
						find = 'sf', -- Find surrounding (to the right)
						find_left = 'sF', -- Find surrounding (to the left)
						highlight = 'sh', -- Highlight surrounding
						replace = 'sr', -- Replace surrounding
						update_n_lines = 'sn', -- Update `n_lines`

						suffix_last = 'l', -- Suffix to search with "prev" method
						suffix_next = 'n', -- Suffix to search with "next" method
					},
				})
				require('mini.extra').setup()
			end,
		},
	})
end

return M
