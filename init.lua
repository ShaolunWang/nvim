if vim.env.PROF then
	-- example for lazy.nvim
	-- change this to the correct path for your plugin manager
	local snacks = vim.fn.stdpath('data') .. '/lazy/snacks.nvim'
	vim.opt.rtp:append(snacks)
	require('snacks.profiler').startup({
		startup = {
			event = 'VimEnter', -- stop profiler on this event. Defaults to `VimEnter`
			-- event = "UIEnter",
			-- event = "VeryLazy",
		},
	})
end
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
	rocks = { enalbed = false, hererocks = false },
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
