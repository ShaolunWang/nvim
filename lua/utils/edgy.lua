return {
	keys = {
		-- increase width
		['<c-Right>'] = function(win)
			win:resize('width', 2)
		end,
		-- decrease width
		['<c-Left>'] = function(win)
			win:resize('width', -2)
		end,
		-- increase height
		['<c-Up>'] = function(win)
			win:resize('height', 2)
		end,
		-- decrease height
		['<c-Down>'] = function(win)
			win:resize('height', -2)
		end,
	},
	bottom = {
		--					{ ft = 'qf', title = 'QuickFix' },
		{
			ft = 'trouble',
			title = 'QuickFix',
			size = { width = 0.2, height = 0.2 },
			filter = function(_buf, win)
				if vim.api.nvim_win_get_config(win).relative == '' then
					return vim.w[win].trouble.mode == 'quickfix' and vim.api.nvim_win_get_config(win).relative == ''
				else
					return false
				end
			end,
		},
	},
	left = {
		{
			ft = 'NvimTree',
			pinned = true,
			title = 'File Tree',
			open = 'NvimTreeToggle',
			size = { width = 0.2, height = 0.5 },
		},
		{
			ft = 'trouble',
			pinned = true,
			title = 'Symbol',
			open = 'Trouble lsp_document_symbols',
			size = { width = 0.2, height = 0.5 },
			filter = function(_buf, win)
				if vim.api.nvim_win_get_config(win).relative == '' then
					return vim.w[win].trouble.mode == 'lsp_document_symbols'
				else
					return false
				end
			end,
		},
	},
	right = {
		{
			ft = 'trouble',
			pinned = true,
			title = 'Todo',
			open = 'Trouble todo',
			size = {
				width = 0.2,
				height = 0.3,
			},
			filter = function(_buf, win)
				if vim.api.nvim_win_get_config(win).relative == '' then
					return vim.w[win].trouble.mode == 'todo' and vim.api.nvim_win_get_config(win).relative == ''
				else
					return false
				end
			end,
		},
		{
			ft = 'undotree',
			pinned = true,
			title = 'Undo Tree',
			size = {
				width = 0.2,
				height = 0.3,
			},
			open = 'UndotreeToggle',
		},
		{
			ft = 'diff',
			title = 'Undotree diff',
			size = {
				width = 0.2,
				height = 0.3,
			},
		},
	},
}
