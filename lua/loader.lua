local paq_plugins = {
	{ 'savq/paq-nvim', branch = 'nightly' },
	{ 'BirdeeHub/lze' }, -- loader
}

-- local snip = require('plugins.luasnip').plugins
-- local compl = require('plugins.completion').plugins
-- local lsp = require('plugins.lsp').plugins
-- local treesitter = require('plugins.treesitter').plugins
-- local edit = require('plugins.edit').plugins
-- local dap = require('plugins.debugger').plugins
-- local pears = require('plugins.pairs').plugins
-- local file = require('plugins.file').plugins
-- local folds = require('plugins.folds').plugins
-- local fuzzy = require('plugins.fuzzy').plugins
-- local languages = require('plugins.languages').plugins
-- local mini = require('plugins.mini').plugins
-- local misc = require('plugins.misc').plugins
--
local function merge(a, b)
	local result = { unpack(a) }
	table.move(b, 1, #b, #result + 1, result)
	return result
end

-- paq_plugins = merge(paq_plugins, snip)
-- paq_plugins = merge(paq_plugins, compl)
-- paq_plugins = merge(paq_plugins, lsp)
-- paq_plugins = merge(paq_plugins, treesitter)
-- paq_plugins = merge(paq_plugins, edit)
-- paq_plugins = merge(paq_plugins, dap)
-- paq_plugins = merge(paq_plugins, pears)
-- paq_plugins = merge(paq_plugins, file)
-- paq_plugins = merge(paq_plugins, folds)
-- paq_plugins = merge(paq_plugins, fuzzy)
-- paq_plugins = merge(paq_plugins, languages)
-- paq_plugins = merge(paq_plugins, mini)
-- paq_plugins = merge(paq_plugins, misc)
--
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config') .. '/lua/plugins', [[v:val =~ '\.lua$']])) do
	vim.print('a')
	vim.print('plugins.' .. file:gsub('%.lua$', ''))
	local plugins_table = require('plugins.' .. file:gsub('%.lua$', '')).plugins
	paq_plugins = merge( paq_plugins, plugins_table)
end

-- require('plugins.luasnip').load()
-- require('plugins.lsp').load()
-- require('plugins.completion').load()
-- require('plugins.treesitter').load()
-- require('plugins.edit').load()
-- require('plugins.debugger').load()
-- require('plugins.pairs').load()
-- require('plugins.file').load()
-- require('plugins.folds').load()
-- require('plugins.fuzzy').load()
-- require('plugins.languages').load()
-- require('plugins.mini').load()
-- require('plugins.misc').load()
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config') .. '/lua/plugins', [[v:val =~ '\.lua$']])) do
	require('plugins.' .. file:gsub('%.lua$', '')).load()
end


return paq_plugins
