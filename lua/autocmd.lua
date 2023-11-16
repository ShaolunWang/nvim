vim.api.nvim_create_augroup('yank_highlight', {})
vim.api.nvim_create_autocmd('BufReadPost', {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
	group = 'yank_highlight',
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 400 })
	end,
})
-- Key mappings for 'qf' filetype
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'qf',
	callback = function()
		vim.api.nvim_buf_set_keymap(0, 'n', '<,o>', '<cmd>colder<CR>', { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, 'n', '<,i>', '<cmd>cnewer<CR>', { noremap = true, silent = true })
	end,
})
