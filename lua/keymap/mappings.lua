local map = vim.api.nvim_set_keymap

--vim.keymap.set('n', '<c-n>', ':NvimTreeToggle<CR>', { noremap = true })
--
vim.keymap.set('n', '<c-n>', function()
	local oil = require('oil')
	oil.toggle_float()
end, { noremap = true, silent = true })
-- neorg
vim.keymap.set('n', '<leader>n', ':Neorg', { noremap = true, desc = 'Neorg' })
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

vim.keymap.set('n', ',v', '<c-v>', { desc = 'visual select' })
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Telescope
local function fuzzy_keymaps()
	if vim.loop.os_uname().sysname ~= 'Windows' then
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
	else
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
		vim.keymap.set('n', '<leader>fp', ':Telescope<cr>', { noremap = true, desc = 'Custom picker' })
	end
end
-- tabline
vim.keymap.set('n', '<leader>tt', ':$tabnew<CR>', { noremap = true, desc = 'New Tab' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { noremap = true, desc = 'Close Tab' })
vim.keymap.set('n', '<leader>to', ':tabonly<CR>', { noremap = true, desc = 'Close Other Tabs' })
vim.keymap.set('n', '<leader>tj', ':tabn<CR>', { noremap = true, desc = 'Next Tab' })
vim.keymap.set('n', '<leader>tk', ':tabp<CR>', { noremap = true, desc = 'Prev Tab' })
vim.keymap.set('n', '<leader>th', ':-tabmove<CR>', { noremap = true, desc = '-Move Tab' })
vim.keymap.set('n', '<leader>tl', ':+tabmove<CR>', { noremap = true, desc = '+Move Tab' })

-- misc
vim.keymap.set('n', '""', ':Registers', { noremap = true, desc = 'reg floating window', silent = true })
vim.keymap.set('n', '<f5>', ':AsyncRun ', { noremap = true, desc = 'Runner' })
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

fuzzy_keymaps()
