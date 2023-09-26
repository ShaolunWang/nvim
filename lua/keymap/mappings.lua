local map = vim.api.nvim_set_keymap

vim.keymap.set('n', '<c-n>', ':NvimTreeToggle<CR>', { noremap = true })
vim.keymap.set('n', '  ', ':noh<CR>', { noremap = true })
-- leap.nvim mapping
vim.keymap.set({ 'n', 'x', 'o' }, 'gs', function()
	local current_window = vim.fn.win_getid()
	require('leap').leap({ target_windows = { current_window } })
end, { noremap = true, desc = 'leap' })

vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
	require('leap').leap({ offset = -1, inclusive_op = true })
end, { silent = true, noremap = true, desc = 'leap forward till' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', function()
	require('leap').leap({ backward = true, offset = 2 })
end, { silent = true, noremap = true, desc = 'leap backward till' })

-- Telescope
vim.keymap.set('n', ',v', '<c-v>', { desc = 'visual select' })
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set('n', '<leader>ff', function()
	require('telescope.builtin').find_files()
end, { noremap = true, desc = 'Find File' })

vim.keymap.set('n', '<leader>fg', function()
	require('telescope.builtin').live_grep()
end, { noremap = true, desc = 'Grep content' })

vim.keymap.set('n', '<leader>fh', function()
	require('telescope.builtin').help_tags()
end, { noremap = true, desc = 'Find Help' })

vim.keymap.set('n', '<leader>fo', function()
	require('telescope.builtin').oldfiles()
end, { noremap = true, desc = 'Search Old File' })

vim.keymap.set('n', '<leader>f<cr>', ':Telescope ', { noremap = true, desc = 'Custom picker' })

-- tabline
vim.keymap.set('n', '<leader>tt', ':$tabnew<CR>', { noremap = true, desc = 'New Tab' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { noremap = true, desc = 'Close Tab' })
vim.keymap.set('n', '<leader>to', ':tabonly<CR>', { noremap = true, desc = 'Close Other Tabs' })
vim.keymap.set('n', '<leader>tj', ':tabn<CR>', { noremap = true, desc = 'Next Tab' })
vim.keymap.set('n', '<leader>tk', ':tabp<CR>', { noremap = true, desc = 'Prev Tab' })
vim.keymap.set('n', '<leader>th', ':-tabmove<CR>', { noremap = true, desc = '-Move Tab' })
vim.keymap.set('n', '<leader>tl', ':+tabmove<CR>', { noremap = true, desc = '+Move Tab' })

-- misc
vim.keymap.set('n', '<f5>', ':AsyncRun ', { noremap = true, desc = 'Runner' })
