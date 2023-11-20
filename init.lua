vim.g.mapleader = ' '
vim.loader.enable() -- cache lua modules (https://github.com/neovim/neovim/pull/22668)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Need to do this before lazyload
vim.g.coq_settings = {
	keymap = {
		recommended = false,
		jump_to_mark = '',
		pre_select = true,
	},
	auto_start = 'shut-up',
	clients = {
		snippets = { enabled = false },
	},
}

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

vim.g.mapleader = ' '
require('lazy').setup('plugins', {
	change_detection = {
		enabled = false,
	},
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
require('misc')
