vim.keymap.set('n', '<leader>s', function()
	vim.cmd([[Oil --float]])
end, { noremap = true, desc = 'float oil' })
vim.keymap.set('n', '<c-n>', function()
	vim.cmd([[Neotree toggle]])
end, { noremap = true, desc = 'neotree' })
vim.keymap.set('n', '  ', function()
	vim.cmd('noh')
	vim.cmd([[lua MiniNotify.clear()]])
	--	require('close_buffers').wipe({ type = 'hidden', force = true }) -- Delete all non-visible buffers
	require('close_buffers').wipe({ type = 'nameless' }) -- Delete all buffers without name
	--	vim.cmd('Fidget clear')
	--	vim.cmd('NoiceDismiss')
end, { noremap = true, silent = true })

vim.keymap.set('n', ',v', '<c-v>', { desc = 'visual select' })
-- moving between splits
vim.keymap.set('n', '<C-h>', ':SmartCursorMoveLeft<cr>', { noremap = true })
vim.keymap.set('n', '<C-j>', ':SmartCursorMoveDown<cr>', { noremap = true })
vim.keymap.set('n', '<C-k>', ':SmartCursorMoveUp<cr>', { noremap = true })
vim.keymap.set('n', '<C-l>', ':SmartCursorMoveRight<cr>', { noremap = true })

-- grapple

vim.keymap.set('n', '<leader>ff', function()
	Snacks.picker.files()
	-- MiniPick.builtin.files()
end, { desc = 'Picker: find files' })
vim.keymap.set('n', '<leader>fg', function()
	Snacks.picker.grep()

	-- MiniPick.builtin.grep_live()
end, { desc = 'Picker: live grep' })
vim.keymap.set('n', '<leader>fo', function()
	require('pickme').pick('oldfiles', { title = 'recent files' })
	-- Snacks.picker.recent()
end, { desc = 'Picker: oldfiles' })
vim.keymap.set('n', '<leader>fh', function()
	require('pickme').pick('help', { title = 'help' })
	-- Snacks.picker.help()
end, { desc = 'Picker: help tags' })
vim.keymap.set('n', '<leader>fp', function()
	require('pickme').pick('pickers')
	-- Snacks.picker()
end, { desc = 'Picker: pickers' })
vim.keymap.set('n', '<leader>fl', function()
	Snacks.picker.lsp_symbols({ layout = { preset = 'vscode', preview = 'main' } })
end, { desc = 'Picker: lsp symbols' })
--
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
	for _, info in ipairs(vim.fn.getwininfo()) do
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
end, { silent = rue })
vim.keymap.set('n', ',g', function()
	require('neogen').generate()
end, { noremap = true, desc = 'neogen' })
vim.keymap.set({ 'n', 'x' }, '<leader>r', function()
	require('refactoring').select_refactor()
end)
vim.keymap.set({ 'n' }, '\\s', ':ISwapNode<cr>', { desc = 'swap cursor node with' })
vim.keymap.set({ 'n', 'v' }, '<leader>i', function()
	require('utils.lsp').code_actions()
end, { desc = 'vscode like action' })
