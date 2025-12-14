local M = {}
M.plugins = {
	{ src = 'https://github.com/mfussenegger/nvim-dap' },
	{ src = 'https://github.com/igorlfs/nvim-dap-view' },
}
-- using ${PICKER} to pick executables

local function pick_executable(under_git_root, subdirs)
	return coroutine.create(function(dap_run_co)
		local root = '.'
		if under_git_root then
			root = Snacks.git.get_root()
		end

		local dirs = {}

		-- If subdirs is a list, append each one; otherwise fall back to root-only
		if type(subdirs) == 'table' then
			for _, subdir in ipairs(subdirs) do
				table.insert(dirs, root .. '/' .. subdir)
			end
		else
			-- No list provided; use just the root
			dirs = { root }
		end

		Snacks.picker.files({
			hidden = true,
			ignored = true,
			dirs = dirs, -- <-- now a list
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
				dap.adapters.codelldb = {
					initialize_timeout_sec = 10,
					type = 'executable',
					command = 'codelldb', -- adjust as needed, must be absolute path
					name = 'codelldb',
				}
				dap.configurations.cpp = {
					{
						name = 'Launch',
						type = 'codelldb',
						request = 'launch',
						initialize_timeout_sec = 10,
						program = function()
							return pick_executable(true, { 'build/', 'build_release/' })
						end,
						cwd = '${workspaceFolder}',
						stopOnEntry = false,
						args = {},
					},
				}
				dap.configurations.c = {
					{
						name = 'Launch',
						type = 'codelldb',
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
