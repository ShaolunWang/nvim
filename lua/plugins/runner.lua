return {
	{
		'stevearc/overseer.nvim',
		-- dev = true,
		cmd = { 'Make', 'Run' },
		init = function()
			local overseer = require('overseer')

			local function get_last()
				local tasks = overseer.list_tasks({ recent_first = true })
				if vim.tbl_isempty(tasks) then
					vim.notify('No tasks found', vim.log.levels.WARN)
					return false
				else
					return tasks[1]
				end
			end

			local function restart_last()
				overseer.run_action(get_last(), 'restart')
			end
		end,
		config = function()
			local overseer = require('overseer')

			local opts = {}

			overseer.setup(opts)
			local function spawn_cmd(cmd, params, stay_open)
				local task = overseer.new_task({
					cmd = cmd,
					-- strategy = strategy,
					components = {
						{
							'on_output_quickfix',
							errorformat = vim.o.efm,
							open_on_match = not params.bang,
							tail = false,
							open_height = 8,
						},
						'default',
					},
				})
				task:start()
			end

			vim.api.nvim_create_user_command('Make', function(params)
				local args = vim.fn.expandcmd(params.args)
				local cmd, num_subs = vim.o.makeprg:gsub('%$%*', args)
				if num_subs == 0 then
					cmd = cmd .. ' ' .. args
				end

				-- local strategy = opts.strategy
				-- strategy.open_on_start = not params.bang
				spawn_cmd(cmd, params)
			end, {
				desc = '',
				nargs = '*',
				bang = true,
			})

			vim.api.nvim_create_user_command('Run', function(params)
				local cmd = vim.fn.expandcmd(params.args)
				spawn_cmd(cmd, params)
			end, {
				desc = '',
				nargs = '*',
				bang = true,
			})

			vim.api.nvim_create_user_command('RunOpen', function(params)
				local cmd = vim.fn.expandcmd(params.args)
				spawn_cmd(cmd, params, true)
			end, {
				desc = '',
				nargs = '*',
				bang = true,
			})
			vim.api.nvim_create_user_command('Grep', function(params)
				-- Insert args at the '$*' in the grepprg
				local cmd, num_subs = vim.o.grepprg:gsub('%$%*', params.args)
				if num_subs == 0 then
					cmd = cmd .. ' ' .. params.args
				end
				local task = overseer.new_task({
					cmd = vim.fn.expandcmd(cmd),
					components = {
						{
							'on_output_quickfix',
							errorformat = vim.o.grepformat,
							open = not params.bang,
							open_height = 8,
							items_only = true,
						},
						-- We don't care to keep this around as long as most tasks
						{ 'on_complete_dispose', timeout = 30 },
						'default',
					},
				})
				task:start()
			end, { nargs = '*', bang = true, complete = 'file' })
		end,
	},
}
