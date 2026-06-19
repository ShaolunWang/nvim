M = {}
M.plugins = {}
vim.pack.add({
	{ src = 'https://github.com/BirdeeHub/lze' },
	{ src = 'https://github.com/BirdeeHub/lzextras' },
	{ src = 'https://github.com/edisj/msgarea.nvim' }, -- this needs to be loaded early
})

local config_files_table = vim.fn.readdir(vim.fn.stdpath('config') .. '/lua/plugins', [[v:val =~ '\.lua$']])

function M.get_all_plugins()
	local list = {}
	for _, file in ipairs(config_files_table) do
		local _, module = pcall(require, 'plugins.' .. file:gsub('%.lua$', ''))
		if module.plugins ~= nil then
			for _, p in ipairs(module.plugins) do
				table.insert(list, vim.deepcopy(p))
			end
		end
		M.plugins = list
	end
end

function M.load_all()
	for _, file in ipairs(config_files_table) do
		require('plugins.' .. file:gsub('%.lua$', '')).load()
	end
end

return M
