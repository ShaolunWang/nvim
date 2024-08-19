vim.g.mapleader = ' '
vim.loader.enable()
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
-- put this after lazy setup
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
	change_detection = {
		enabled = false,
	},
	rocks = { hererocks = false },
	performance = {
		rtp = {
			disabled_plugins = {
				'matchit',
				'matchparen',
				'tutor',
			},
		},
	},
})

require('config')
require('keymap')
require('theme')
require('autocmd')
require('commands')
