vim.g.mapleader = ' '
vim.loader.enable()

local plugins = require('loader')
vim.pack.add(plugins, { load = function() end })
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config') .. '/lua/plugins', [[v:val =~ '\.lua$']])) do
	require('plugins.' .. file:gsub('%.lua$', '')).load()
end

require('config')
require('keymap')
require('theme')
require('autocmd')
require('commands')

vim.deprecate = function() end
