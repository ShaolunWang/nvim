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

-- Key mappings for 'qf' filetype
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'qf',
	callback = function()
		vim.api.nvim_buf_set_keymap(0, 'n', '<c-o>', '<cmd>colder<CR>', { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, 'n', '<c-i>', '<cmd>cnewer<CR>', { noremap = true, silent = true })
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
		'Trouble',
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
		vim.cmd('silent Build')
	end,
	group = group,
})
vim.api.nvim_create_autocmd('TextYankPost', {
	group = 'yank_highlight',
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 400 })
	end,
})
local init_quickfix = vim.api.nvim_create_augroup('init_quickfix', { clear = true })
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
	pattern = { '[^l]*' },
	callback = function()
				require('quicker').open()
		--vim.cmd('Trouble quickfix')
		-- vim.cmd('cwindow')
	end,
	group = init_quickfix,
})
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
	pattern = { 'l*' },
	callback = function()
		require('quicker').open({ loclist = true })
		--vim.cmd('Trouble loclist')
		-- vim.cmd('lwindow')
	end,
	group = init_quickfix,
})
--[[ vim.api.nvim_create_autocmd('VimLeave', {
	pattern = { '*' },
	callback = function()
		local undo_path = vim.fn.stdpath('data') .. '/undo/'
		local delete_old_undo = 'silent  !fd . ' .. undo_path .. ' --changed-before 1week -x rm'
		vim.cmd(delete_old_undo)
		vim.print('cleaned undo files older than 1 week...')
	end,
}) ]]

local nui_au = vim.api.nvim_create_augroup('nui_au', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'nui' },
	callback = function()
		vim.keymap.set('n', '<c-n>', '<Down>', { buffer = true })
	end,
	group = nui_au,
})

-- vim.api.nvim_create_autocmd('BufRead', {
-- 	callback = function(ev)
-- 		local buftype = vim.bo[ev.buf].buftype
-- 		if buftype == 'quickfix' then
-- 			vim.schedule(function()
-- 				vim.cmd([[cclose]])
-- 				vim.cmd([[Trouble quickfix]])
-- 			end)
-- 		elseif buftype == 'loclist' then
-- 			vim.cmd([[lclose]])
-- 			vim.cmd([[Trouble loclist]])
-- 		end
-- 	end,
-- })
--[[ im.api.nvim_create_autocmd({ 'BufWritePost' }, {
	pattern = { '*.h', '*.cpp' },
	callback = function()
		-- try_lint without arguments runs the linters defined in `linters_by_ft`
		-- for the current filetype
		require('lint').try_lint()
		-- You can call `try_lint` with a linter name or a list of names to always
		-- run specific linters, independent of the `linters_by_ft` configuration
	end,
}) ]]
vim.api.nvim_create_autocmd({ 'InsertLeave', 'InsertEnter' }, {
	pattern = '*',
	callback = function()
		if vim.api.nvim_buf_line_count(0) > 10000 then
			vim.cmd('TSToggle highlight')
		end
	end,
})
vim.cmd([[
function! s:init_fern() abort
 nmap <buffer><expr>
      \ <Plug>(fern-my-expand-or-collapse)
      \ fern#smart#leaf(
      \   "\<Plug>(fern-action-collapse)",
      \   "\<Plug>(fern-action-expand)",
      \   "\<Plug>(fern-action-collapse)",
      \ )

  nmap <buffer><expr>
        \ <Plug>(fern-my-open-or-enter)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-enter)",
        \ )
  nmap <buffer><nowait> <Tab> <Plug>(fern-my-expand-or-collapse)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> r <Plug>(fern-action-rename)
  nmap <buffer> h <Plug>(fern-action-hidden-toggle)
  nmap <buffer> R <Plug>(fern-action-reload)
  nmap <buffer> ; <Plug>(fern-action-mark-toggle)
  nmap <buffer> <c-x> <Plug>(fern-action-open:split)
  nmap <buffer> <c-v> <Plug>(fern-action-open:vsplit)
  nmap <buffer><nowait> - <Plug>(fern-action-leave)
  nmap <buffer><nowait> <cr> <Plug>(fern-my-open-or-enter)
endfunction

augroup my-fern-preview
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END
]])
