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

vim.api.nvim_create_autocmd({ 'InsertLeave', 'InsertEnter' }, {
	pattern = '*',
	callback = function()
		if vim.api.nvim_buf_line_count(0) > 10000 then
			vim.cmd('TSToggle highlight')
		end
	end,
})

--[[ vim.api.nvim_create_autocmd('User', {
	pattern = 'OilEnter',
	callback = vim.schedule_wrap(function(args)
		local oil = require('oil')
		if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
			oil.open_preview()
		end
	end),
}) ]]
vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = '*',
	callback = vim.schedule_wrap(function(args)
		require('conform').format({ async = true, lsp_format = 'fallback' })
	end),
})
vim.cmd([[
 augroup diffcolors
     autocmd!
     autocmd Colorscheme * call s:SetDiffHighlights()
 augroup END



 function! s:SetDiffHighlights()
     if &background == "dark"
         highlight DiffAdd gui=bold guifg=none guibg=#2e4b2e
         highlight DiffDelete gui=bold guifg=none guibg=#4c1e15
         highlight DiffChange gui=bold guifg=none guibg=#45565c
         highlight DiffText gui=bold guifg=none guibg=#996d74
     else
         highlight DiffAdd gui=bold guifg=none guibg=palegreen
         highlight DiffDelete gui=bold guifg=none guibg=tomato
         highlight DiffChange gui=bold guifg=none guibg=lightblue
         highlight DiffText gui=bold guifg=none guibg=lightpink
     endif
 endfunction
]])
vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = { 'dap-view', 'dap-view-term', 'dap-repl' }, -- dap-repl is set by `nvim-dap`
	callback = function(args)
		vim.keymap.set({ 'n' }, '<leader>b', ':DapToggleBreakpoint<cr>', { desc = 'toggle breakpoint' })
		vim.keymap.set({ 'n' }, '1', ':DapStepInto<cr>', { desc = 'Step Into' })
		vim.keymap.set({ 'n' }, '2', ':DapStepOver<cr>', { desc = 'Step Over' })
		vim.keymap.set({ 'n' }, '3', ':DapStepOut<cr>', { desc = 'Step Out' })
		vim.keymap.set({ 'n' }, '<leader>a', ':DapContinue<cr>', { desc = 'Continue' })
	end,
})
