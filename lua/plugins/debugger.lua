local M = {}
M.plugins = {
	{ 'mfussenegger/nvim-dap', opt = true },
	{ 'igorlfs/nvim-dap-view', opt = true },
}

function M.load()
	require('lze').load({
		{
			'nvim-dap',
			dep_of = { 'nvim-dap-view' },
			after = function()
				local dap = require('dap')
				dap.adapters.lldb = {
					type = 'executable',
					command = '/usr/bin/lldb', -- TODO: adjust as needed, must be absolute path
					name = 'lldb',
				}
				dap.configurations.cpp = {
					{
						name = 'Launch',
						type = 'lldb',
						request = 'launch',
						program = function()
							return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
						end,
						cwd = '${workspaceFolder}',
						stopOnEntry = false,
						args = {},

						-- 💀
						-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
						--
						--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
						--
						-- Otherwise you might get the following error:
						--
						--    Error on launch: Failed to attach to the target process
						--
						-- But you should be aware of the implications:
						-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
						-- runInTerminal = false,
					},
				}
			end,
		},
		{
			'nvim-dap-view',
			after = function()
				require('dap-view').setup()
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
			},
		},
	})
end

return M
