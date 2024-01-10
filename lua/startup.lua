-- :fennel:1704812508
require('config')
require('plug')
require('theme')
require('keymap')
require('autocmd')
require('commands')
if vim.loader then
	vim.loader.enable()
else
end
vim.g['loader_luv'] = true
return nil
