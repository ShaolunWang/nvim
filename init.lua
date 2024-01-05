vim.g.mapleader = ' '
vim.loader.enable() -- cache lua modules (https://github.com/neovim/neovim/pull/22668)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

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
-- ~/.config/nvim/plugin/0-tangerine.lua or ~/.config/nvim/init.lua
-- pick your plugin manager
local pack = 'tangerine' or 'lazy'

local function bootstrap(url, ref)
	local name = url:gsub('.*/', '')
	local path

	if pack == 'lazy' then
		path = vim.fn.stdpath('data') .. '/lazy/' .. name
		vim.opt.rtp:prepend(path)
	else
		path = vim.fn.stdpath('data') .. '/site/pack/' .. pack .. '/start/' .. name
	end

	if vim.fn.isdirectory(path) == 0 then
		print(name .. ': installing in data dir...')

		vim.fn.system({ 'git', 'clone', url, path })
		if ref then
			vim.fn.system({ 'git', '-C', path, 'checkout', ref })
		end

		vim.cmd('redraw')
		print(name .. ': finished installing')
	end
end

bootstrap('https://github.com/udayvir-singh/tangerine.nvim')
bootstrap('https://github.com/udayvir-singh/hibiscus.nvim')
vim.opt.rtp:prepend({ lazypath })

require('tangerine').setup({})
require('startup')
