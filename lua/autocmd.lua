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

vim.cmd([[
  function FormatBuffer()
    if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
      let cursor_pos = getpos('.')
      :%!clang-format
      call setpos('.', cursor_pos)
    endif
  endfunction

  autocmd BufWritePre *.h,*.hpp,*.c,*.cpp,*.vert,*.frag :call FormatBuffer()
]])
vim.api.nvim_create_autocmd('BufReadPre', {
	callback = function()
		require('fzf-lua').register_ui_select()
	end,
})

vim.api.nvim_create_autocmd('VimEnter', {
	callback = function()
		vim.print('Type [:Session here] to reload session')
	end,
})
vim.api.nvim_clear_autocmds({ group = 'Grapple', event = 'BufLeave' })
