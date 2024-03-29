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
		local fidget = require('fidget')
		fidget.notify('yanking', vim.log.levels.INFO)
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

local llvm_highlight = vim.api.nvim_create_augroup('llvm-highlight', {})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	group = llvm_highlight,
	pattern = { '*.mlir', '*.xdsl' },
	callback = function()
		vim.cmd([[set ft=mlir]])
	end,
})

vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

vim.api.nvim_create_autocmd('FileType', {
	group = llvm_highlight,
	pattern = { '*.td' },
	callback = function()
		vim.cmd([[set ft=tablegen]])
	end,
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = {
		'help',
		'NvimTree',
		'lazy',
		'Outline',
		'terminal',
		'fzf',
	},
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})

local group = vim.api.nvim_create_augroup('CscopeBuild', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
	pattern = { '*.cpp', '*.h' },
	callback = function()
		vim.cmd('Cscope build')
	end,
	group = group,
})
