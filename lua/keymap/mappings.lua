local map = vim.api.nvim_set_keymap
local which_key = require('keymap.which_key')

map('n', '<c-n>', ':NvimTreeToggle<CR>', { noremap = true })
map('n', '  ', ':noh<CR>', { noremap = true })

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
-- register
vim.keymap.set('n', '""', ':Telescope registers<cr>', { noremap = true, desc = 'Telescope reg & paste' })

-- misc
vim.keymap.set('n', ',v', '<c-v>')

-- Which-key mapping
which_key.telescope_which_key()
which_key.trouble_which_key()
which_key.diffview_which_key()
