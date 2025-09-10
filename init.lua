vim.g.mapleader = ' '
vim.loader.enable()

local loader = require('loader')
loader.get_all_plugins()

vim.pack.add(loader.plugins, { load = function() end })

loader.load_all()

require('config')
require('keymap')
require('theme')
require('autocmd')
require('commands')

vim.deprecate = function() end
