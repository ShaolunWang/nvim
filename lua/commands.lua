vim.api.nvim_create_user_command('EditSnip', function()
	require('scissors').editSnippet()
end, {})
vim.api.nvim_create_user_command('AddSnip', function()
	require('scissors').addNewSnippet()
end, {})

vim.api.nvim_create_user_command('G', function()
	require('neogit').open()
end, {})

vim.api.nvim_create_user_command('T', function()
	require('tfm').open()
end, {})
