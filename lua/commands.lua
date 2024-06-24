vim.api.nvim_create_user_command('G', function()
	require('neogit').open()
end, {})

vim.api.nvim_create_user_command('T', function()
	--	require('nvim-tree.api').tree.toggle()
	vim.cmd([[:lua MiniFiles.open()]])
end, {})
