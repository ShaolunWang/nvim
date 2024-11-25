--vim.keymap.set('n', '<leader>bb',  ':ls<CR>:b<space>', {noremap = true, desc = 'buffers'})
--vim.keymap.set('n', '<leader>bd',  ':ls<CR>:bd <space>', {noremap = true, desc = 'buffers'})
--vim.keymap.set('n', '<leader>b',  ':BufExplorer<cr>', {noremap = true, desc = 'buffers'})

--[[ vim.keymap.set('n', '<c-n>', function()
	if vim.bo.filetype == 'oil' then
		require('oil').close()
	else
		require('oil').open()
	end
end, { desc = 'File navigation' }) ]]
-- neorg
vim.keymap.set('n', '<c-n>', function()
	vim.cmd([[Fern -drawer -stay -toggle -reveal=% .]])
end, { noremap = true, desc = 'Fern' })
vim.keymap.set('n', '  ', function()
	vim.cmd('noh')
	vim.cmd[[lua MiniNotify.clear()]]
--	vim.cmd('Fidget clear')
	--	vim.cmd('NoiceDismiss')
end, { noremap = true, silent = true })

vim.keymap.set('n', ',v', '<c-v>', { desc = 'visual select' })
-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left, { noremap = true })
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down, { noremap = true })
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up, { noremap = true })
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right, { noremap = true })
vim.keymap.set('n', '<C-p>', require('smart-splits').move_cursor_previous, { noremap = true })

-- grapple

-- Telescope
vim.keymap.set('n', '<leader>ff', function()
	vim.cmd([[Pick files]])
end, { noremap = true, desc = 'Find File' })
vim.keymap.set('n', '<leader>fg', function()
	require('fzf-lua').live_grep()
end, { noremap = true, desc = 'Grep content' })
vim.keymap.set('n', '<leader>fh', function()
	require('fzf-lua').help_tags()
end, { noremap = true, desc = 'Find Help' })
vim.keymap.set('n', '<leader>fo', function()
	require('fzf-lua').oldfiles()
end, { noremap = true, desc = 'Search Old File' })
vim.keymap.set('n', '<leader>fp', ':FzfLua<cr>', { noremap = true, desc = 'Custom picker' })
-- tabline
vim.keymap.set('n', '<leader>tt', ':$tabnew<CR>', { noremap = true, desc = 'New Tab' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { noremap = true, desc = 'Close Tab' })

vim.keymap.set('n', '<leader>to', ':tabonly<CR>', { noremap = true, desc = 'Close Other Tabs' })
vim.keymap.set('n', '<leader>th', ':-tabmove<CR>', { noremap = true, desc = '-Move Tab' })
vim.keymap.set('n', '<leader>tl', ':+tabmove<CR>', { noremap = true, desc = '+Move Tab' })
vim.keymap.set('n', '[t', ':tabn<CR>', { noremap = true, desc = 'Next Tab' })
vim.keymap.set('n', ']t', ':tabp<CR>', { noremap = true, desc = 'Prev Tab' })

-- misc
--vim.keymap.set('n', '""', ':Registers<cr>', { noremap = true, desc = 'reg floating window', silent = true })
-- runner
vim.keymap.set('n', '<f5>', ':Make ', { noremap = true, desc = 'Runner' })
local toggle_qf = function()
	for _, info in ipairs(vim.fn.getwininfo()) do
		if info.quickfix == 1 then
			vim.cmd('cclose')
			-- require('quicker').close()
			return
		elseif info.variables['trouble'] ~= nil then
			vim.print(info.variables['trouble'].mode)
			if info.variables['trouble'].mode == 'quickfix' then
				vim.cmd('Trouble quickfix close')
				return
			end
		end
	end
	if next(vim.fn.getqflist()) == nil then
		vim.print('No Quickfix Entry')
		return
	end
	--vim.cmd('Trouble quickfix')
	-- require('quicker').open()
	vim.cmd('copen')
end
vim.keymap.set('n', '<F6>', function()
	toggle_qf()
end, { noremap = true, silent = true })

local toggle_loclist = function()
	for win, info in ipairs(vim.fn.getwininfo()) do
		if info.loclist == 1 then
			vim.cmd('lclose')
			return
		elseif info.variables['trouble'] ~= nil then
			if info.variables['trouble'].mode == 'loclist' then
				vim.cmd('Trouble loclist close')
				return
			end
		end
	end

	if next(vim.fn.getloclist(0)) == nil then
		vim.print('No Location List Entry')
		return
	end
	vim.cmd('lopen')

	--	vim.cmd('Trouble loclist')
end

vim.keymap.set('n', '<F7>', function()
	toggle_loclist()
end, { noremap = true, silent = true })

vim.keymap.set({ 'i', 's' }, '<c-d>', function()
	require('luasnip').jump(1)
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<c-u>', function()
	require('luasnip').jump(-1)
end, { silent = true })
vim.api.nvim_set_keymap('n', ',c', ":lua require('neogen').generate()<CR>", { noremap = true, desc = 'neogen' })
vim.keymap.set({ 'n', 'x' }, '<c-s>', ':RipSubstitute<cr>', { desc = ' rip substitute' })
