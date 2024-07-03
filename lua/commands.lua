vim.api.nvim_create_user_command('G', function()
	require('neogit').open()
end, {})

vim.api.nvim_create_user_command('T', function()
	--	require('nvim-tree.api').tree.toggle()
	vim.cmd([[:lua MiniFiles.open()]])
end, {})

vim.api.nvim_create_user_command('Grep', function(params)
	-- Insert args at the '$*' in the grepprg
	local overseer = require('overseer')
	local cmd, num_subs = vim.o.grepprg:gsub('%$%*', params.args)
	if num_subs == 0 then
		cmd = cmd .. ' ' .. params.args
	end
	local task = overseer.new_task({
		name = 'grep',
		cmd = vim.fn.expandcmd(cmd),
		components = {
			{
				'on_output_quickfix',
				errorformat = vim.o.grepformat,
				open = true,
				set_diagnostics = false,
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

vim.api.nvim_create_user_command('Make', function(in_params)
	require('overseer').run_template({ name = 'just', params = in_params })
end, {
	desc = 'Make',
	nargs = '*',
	bang = true,
})
