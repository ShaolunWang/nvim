local paq_plugins = {
	{ src = 'https://github.com/BirdeeHub/lze' },
}
vim.pack.add({ { src = 'https://github.com/BirdeeHub/lze' } })

local function merge(a, b)
	local result = { unpack(a) }
	table.move(b, 1, #b, #result + 1, result)
	return result
end

for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config') .. '/lua/plugins', [[v:val =~ '\.lua$']])) do
	local plugins_table = require('plugins.' .. file:gsub('%.lua$', '')).plugins
	paq_plugins = merge(paq_plugins, plugins_table)
end

return paq_plugins
