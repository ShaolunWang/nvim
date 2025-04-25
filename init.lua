vim.g.mapleader = ' '
vim.g.base46_cache = vim.fn.stdpath('data') .. '/base46_cache/'
-- put this after lazy setup

-- (method 1, For heavy lazyloaders)
vim.loader.enable()

local function clone_paq()
	local path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
	local is_installed = vim.fn.empty(vim.fn.glob(path)) == 0
	if not is_installed then
		vim.fn.system({ 'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', path })
		return true
	end
end

-- TODO: remove this

local function bootstrap_paq(packages)
	local first_install = clone_paq()
	vim.cmd.packadd('paq-nvim')
	local paq = require('paq')
	if first_install then
		vim.notify('Installing plugins... If prompted, hit Enter to continue.')
	end

	-- Read and install packages
	paq:setup({ verbose = false })

	paq(packages)
	paq.install()
end

-- Call helper function

local plugins = require('loader')
bootstrap_paq(plugins)

require('config')
require('keymap')
require('theme')
require('autocmd')
require('commands')

for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
	dofile(vim.g.base46_cache .. v)
end

vim.deprecate = function() end
