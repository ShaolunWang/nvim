vim.g.maplocalleader = ';'
vim.keymap.del('n', '  ')
vim.keymap.set('n', '  ', function()
	vim.cmd('noh')
	require('close_buffers').delete({ glob = '*vlime*', force = true })
end, { noremap = true, silent = true })
