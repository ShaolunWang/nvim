-- :fennel:1704452965
local map = vim.api.nvim_set_keymap
local function _1_()
	return require('grapple').toggle({ use_cursor = true })
end
vim.keymap.set('n', '<leader>gg', _1_, { desc = 'Grappled Toggle' })
vim.keymap.set('n', '<leader>gp', require('grapple').popup_tags, { desc = 'Grappled Popup' })
vim.keymap.set('n', '<leader>gr', require('grapple').reset, { desc = 'Grappled Reset' })
local function _2_()
	if vim.bo.filetype == 'oil' then
		return require('oil').close()
	else
		return require('oil').open()
	end
end
vim.keymap.set('n', '<c-n>', _2_, { desc = 'File navigation' })
vim.keymap.set('n', '<leader>n', ':Neorg<cr>', { desc = 'Neorg', noremap = true })
vim.keymap.set('n', '  ', ':noh<CR>', { noremap = true })
local function _4_()
	return require('leap').leap({ inclusive_op = true, offset = -1 })
end
vim.keymap.set({ 'n', 'x', 'o' }, 's', _4_, { desc = 'leap forward till', noremap = true, silent = true })
local function _5_()
	return require('leap').leap({ backward = true, offset = 2 })
end
vim.keymap.set({ 'n', 'x', 'o' }, 'S', _5_, { desc = 'leap backward till', noremap = true, silent = true })
vim.keymap.set('n', ',v', '<c-v>', { desc = 'visual select' })
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
local function fuzzy_keymaps()
	if vim.loop.os_uname().sysname ~= 'Windows' then
		local function _6_()
			return require('fzf-lua').files()
		end
		vim.keymap.set('n', '<leader>ff', _6_, { desc = 'Find File', noremap = true })
		local function _7_()
			return require('fzf-lua').live_grep()
		end
		vim.keymap.set('n', '<leader>fg', _7_, { desc = 'Grep content', noremap = true })
		local function _8_()
			return require('fzf-lua').help_tags()
		end
		vim.keymap.set('n', '<leader>fh', _8_, { desc = 'Find Help', noremap = true })
		local function _9_()
			return require('fzf-lua').oldfiles()
		end
		vim.keymap.set('n', '<leader>fo', _9_, { desc = 'Search Old File', noremap = true })
		return vim.keymap.set('n', '<leader>fp', ':FzfLua<cr>', { desc = 'Custom picker', noremap = true })
	else
		local function _10_()
			return require('telescope.builtin').find_files()
		end
		vim.keymap.set('n', '<leader>ff', _10_, { desc = 'Find File', noremap = true })
		local function _11_()
			return require('telescope.builtin').live_grep()
		end
		vim.keymap.set('n', '<leader>fg', _11_, { desc = 'Grep content', noremap = true })
		local function _12_()
			return require('telescope.builtin').help_tags()
		end
		vim.keymap.set('n', '<leader>fh', _12_, { desc = 'Find Help', noremap = true })
		local function _13_()
			return require('telescope.builtin').oldfiles()
		end
		vim.keymap.set('n', '<leader>fo', _13_, { desc = 'Search Old File', noremap = true })
		return vim.keymap.set('n', '<leader>fp', ':Telescope<cr>', { desc = 'Custom picker', noremap = true })
	end
end
vim.keymap.set('n', '<leader>tt', ':$tabnew<CR>', { desc = 'New Tab', noremap = true })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close Tab', noremap = true })
vim.keymap.set('n', '<leader>to', ':tabonly<CR>', { desc = 'Close Other Tabs', noremap = true })
vim.keymap.set('n', '<leader>tj', ':tabn<CR>', { desc = 'Next Tab', noremap = true })
vim.keymap.set('n', '<leader>tk', ':tabp<CR>', { desc = 'Prev Tab', noremap = true })
vim.keymap.set('n', '<leader>th', ':-tabmove<CR>', { desc = '-Move Tab', noremap = true })
vim.keymap.set('n', '<leader>tl', ':+tabmove<CR>', { desc = '+Move Tab', noremap = true })
vim.keymap.set('n', '""', ':Registers<cr>', { desc = 'reg floating window', noremap = true, silent = true })
vim.keymap.set('n', '<f5>', ':AsyncDo ', { desc = 'Runner', noremap = true })
local function toggle_qf()
	for _, info in ipairs(vim.fn.getwininfo()) do
		if info.quickfix == 1 then
			vim.cmd('cclose')
			return
		else
		end
	end
	if next(vim.fn.getqflist()) == nil then
		vim.print('No Quickfix Entry')
		return
	else
	end
	return vim.cmd('copen')
end
local function _17_()
	return toggle_qf()
end
vim.keymap.set('n', '<F6>', _17_, { noremap = true, silent = true })
local function toggle_loclist()
	for _, info in ipairs(vim.fn.getwininfo()) do
		if info.loclist == 1 then
			vim.cmd('lclose')
			return
		else
		end
	end
	if next(vim.fn.getloclist(0)) == nil then
		vim.print('No Location List Entry')
		return
	else
	end
	return vim.cmd('lopen')
end
local function _20_()
	return toggle_loclist()
end
vim.keymap.set('n', '<F7>', _20_, { noremap = true, silent = true })
return fuzzy_keymaps()
