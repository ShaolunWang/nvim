local M = {}
M.plugins = {
	{ src = 'https://github.com/mfussenegger/nvim-dap' },
	{ src = 'https://github.com/igorlfs/nvim-dap-view' },
}

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
							return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
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
