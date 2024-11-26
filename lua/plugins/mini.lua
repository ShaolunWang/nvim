return {
	'echasnovski/mini.nvim',
	config = function()
		require('mini.ai').setup()
		require('mini.pick').setup()
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
		local win_config = function()
			local has_statusline = vim.o.laststatus > 0
			local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
			return { anchor = 'SE', col = vim.o.columns, row = vim.o.lines - pad }
		end
		require('mini.notify').setup({ window = { config = win_config } })
		require('mini.extra').setup()
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
		vim.ui.select = MiniPick.ui_select

		require('mini.jump2d').setup()
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
	end,
	events = 'VeryLazy',
}
