local M = {}
M.plugins = {
	{ src = 'https://github.com/mfussenegger/nvim-dap' },
	{ src = 'https://github.com/igorlfs/nvim-dap-view' },
}
-- using ${PICKER} to pick executables
local function pick_executable(under_git_root, subdir)
	return coroutine.create(function(dap_run_co)
		local root = '.'
		if under_git_root then
			root = Snacks.git.get_root()
		end
		if subdir ~= nil then
			root = root .. '/' .. subdir
		end
		-- NOTE: replace this with other pickers
		Snacks.picker.files({
			hidden = true,
			ignored = true,
			dirs = { root },
			cmd = 'fd',
			type = { 'x' },
			confirm = function(picker, item)
				picker:norm(function()
					picker:close()
					coroutine.resume(dap_run_co, item.text)
				end)
			end,
		})
	end)
end

function M.load()
	require('lze').load({
		{
			'nvim-dap',
			dep_of = { 'nvim-dap-view' },
			after = function()
				local dap = require('dap')
				dap.adapters.lldb = {
					initialize_timeout_sec = 10,
					type = 'executable',
					command = '/usr/local/bin/codelldb_adapter/adapter/codelldb', -- adjust as needed, must be absolute path
					name = 'lldb',
				}
				dap.configurations.cpp = {
					{
						name = 'Launch',
						type = 'lldb',
						request = 'launch',
						initialize_timeout_sec = 10,
						program = function()
							return pick_executable(true, 'build/')
						end,
						cwd = '${workspaceFolder}',
						stopOnEntry = false,
						args = {},
					},
				}
			end,
		},
		{
			'nvim-dap-view',
			after = function()
				require('dap-view').setup({
					winbar = {
						default_section = 'scopes',
							controls = { enabled = true },
					},
					windows = { position = 'right' },
				})
			end,
			keys = {
				{
					'<leader>v',
					mode = 'n',
					function()
						require('dap-view').toggle()
					end,
					{ desc = 'Toggle nvim-dap-view' },
				},
				'<leader>l',
			},
		},
	})
end

return M
