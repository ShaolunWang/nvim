local map = vim.api.nvim_set_keymap

-- oil & tree
vim.keymap.set('n', '<c-n>', function()
	if vim.bo.filetype == 'oil' then
		require('oil').close()
	else
		require('oil').open()
	end
end, { desc = 'File navigation' })
-- neorg
vim.keymap.set('n', '<leader>n', ':Neorg<cr>', { noremap = true, desc = 'Neorg' })
vim.keymap.set('n', '  ', ':noh | Fidget clear<CR>', { noremap = true, silent = true })

vim.keymap.set('n', ',v', '<c-v>', { desc = 'visual select' })
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
-- grapple
local grapple = require('grapple')
vim.keymap.set('n', '<leader>gg', grapple.toggle, { desc = 'Grapple Tag' })
vim.keymap.set('n', '<leader>gr', grapple.reset, { desc = 'Grapple Clear' })
vim.keymap.set('n', '<leader>gp', grapple.open_tags, { desc = 'Grapple Menu' })
vim.keymap.set('n', '[g', function()
	grapple.cycle_backward()
	local fidget = require('fidget')
	fidget.notify('Grapple Cycle Backward')
end, { desc = 'Grapple Prev' })
vim.keymap.set('n', ']g', function()
	grapple.cycle_foward()
	local fidget = require('fidget')
	fidget.notify('Grapple Cycle Forward')
end, { desc = 'Grapple Next' })

-- Telescope
vim.keymap.set('n', '<leader>ff', function()
	require('fzf-lua').files()
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
vim.keymap.set('n', '<leader>tj', ':tabn<CR>', { noremap = true, desc = 'Next Tab' })
vim.keymap.set('n', '<leader>tk', ':tabp<CR>', { noremap = true, desc = 'Prev Tab' })
vim.keymap.set('n', '<leader>th', ':-tabmove<CR>', { noremap = true, desc = '-Move Tab' })
vim.keymap.set('n', '<leader>tl', ':+tabmove<CR>', { noremap = true, desc = '+Move Tab' })

-- misc
vim.keymap.set('n', '""', ':Registers<cr>', { noremap = true, desc = 'reg floating window', silent = true })
-- runner
vim.keymap.set('n', '<f5>', ':AsyncDo ', { noremap = true, desc = 'Runner' })
local toggle_qf = function()
	for _, info in ipairs(vim.fn.getwininfo()) do
		if info.quickfix == 1 then
			vim.cmd('cclose')
			return
		end
	end
	if next(vim.fn.getqflist()) == nil then
		vim.print('No Quickfix Entry')
		return
	end
	vim.cmd('copen')
end
vim.keymap.set('n', '<F6>', function()
	toggle_qf()
end, noremap_silent)

local toggle_loclist = function()
	for _, info in ipairs(vim.fn.getwininfo()) do
		if info.loclist == 1 then
			vim.cmd('lclose')
			return
		end
	end

	if next(vim.fn.getloclist(0)) == nil then
		vim.print('No Location List Entry')
		return
	end
	vim.cmd('lopen')
end

vim.keymap.set('n', '<F7>', function()
	toggle_loclist()
end, { noremap = true, silent = true })
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
