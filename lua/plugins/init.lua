local paq_plugins = {
	{ 'savq/paq-nvim', branch = 'nightly' },
	{ 'BirdeeHub/lze' }, -- loader
	{ 'folke/tokyonight.nvim', opt = true },
	{ 'catppuccin/nvim', opt = true },
	{ 'Mofiqul/vscode.nvim', opt = true },
	{ 'rebelot/kanagawa.nvim', opt = true },
	{ 'AlexvZyl/nordic.nvim', opt = true },
}

local snip = require('plugins.luasnip').plugins
local compl = require('plugins.completion').plugins
local lsp = require('plugins.lsp').plugins

local function merge(a, b)
	local result = { unpack(a) }
	table.move(b, 1, #b, #result + 1, result)
	return result
end

paq_plugins = merge(paq_plugins, snip)
paq_plugins = merge(paq_plugins, compl)
paq_plugins = merge(paq_plugins, lsp)
--for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config')..'/lua/plugins', [[v:val =~ '\.lua$']])) do
--  local plugins_table = require('plugins.'..file:gsub('%.lua$', ''))
--  paq_plugins = vim.tbl_deep_extend('error', paq_plugin, plugins_table)
--end
return paq_plugins
