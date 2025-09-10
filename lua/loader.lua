M = {}
M.plugins = {}
vim.pack.add({
	{ src = 'https://github.com/BirdeeHub/lze' },
	{ src = 'https://github.com/BirdeeHub/lzextras' },
})

-- reading files from $configpath/lua/plugins/*
local config_files_table = vim.fn.readdir(vim.fn.stdpath('config') .. '/lua/plugins', [[v:val =~ '\.lua$']])

--  merging tables for plugins from each files
local function merge(a, b)
	if a == nil then
		return b
	elseif b == nil then
		return a
	end
	local result = { unpack(a) }
	table.move(b, 1, #b, #result + 1, result)
	return result
end

function M.get_all_plugins()
	for _, file in ipairs(config_files_table) do
		-- TODO: cache this plugins_table?
		local plugins_table = require('plugins.' .. file:gsub('%.lua$', '')).plugins
		M.plugins = merge(M.plugins, plugins_table)
	end
end
-- end merging tables

function M.load_all()
	for _, file in ipairs(config_files_table) do
		require('plugins.' .. file:gsub('%.lua$', '')).load()
	end
end

return M
