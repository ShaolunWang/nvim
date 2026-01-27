vim.api.nvim_create_user_command('G', function()
	vim.cmd([[Neogit]])
end, {})
vim.api.nvim_create_user_command('Sg', function()
	vim.cmd([[:lua require('grug-far').open({ engine = 'astgrep' }) ]])
end, {})
vim.api.nvim_create_user_command('Rg', function()
	vim.cmd([[:lua require('grug-far').open({ engine = 'ripgrep' }) ]])
end, {})
vim.api.nvim_create_user_command('T', function()
	vim.cmd([[Neotree toggle]])
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

vim.api.nvim_create_user_command('Make', function(params)
	-- Insert args at the '$*' in the makeprg
	local cmd = 'just'
	cmd = cmd .. ' ' .. params.args
	local task = require('overseer').new_task({
		cmd = vim.fn.expandcmd(cmd),
		components = {
			{ 'on_output_quickfix', open = not params.bang, open_height = 8 },
			{ 'on_complete_dispose', timeout = 1 },
			'default',
		},
	})
	task:start()
end, {
	desc = 'make, with quickfix list',
	nargs = '*',
	bang = true,
})
vim.api.nvim_create_user_command('Build', function(params)
	-- Insert args at the '$*' in the makeprg
	local cmd = 'just'
	cmd = cmd .. ' ' .. params.args
	local task = require('overseer').new_task({
		cmd = vim.fn.expandcmd(cmd),
		components = {
			{ 'on_complete_dispose', timeout = 1 },
			'default',
		},
	})
	task:start()
end, {
	desc = 'Build, no quickfix list',
	nargs = '*',
	bang = true,
})

vim.api.nvim_create_user_command('OpenPdf', function()
	local filepath = vim.api.nvim_buf_get_name(0)
	if filepath:match('%.typ$') then
		os.execute('open ' .. vim.fn.shellescape(filepath:gsub('%.typ$', '.pdf')))
		-- replace open with your preferred pdf viewer
		-- os.execute("zathura " .. vim.fn.shellescape(filepath:gsub("%.typ$", ".pdf")))
	end
end, {})

vim.api.nvim_create_user_command('UpdatePlugins', function()
	local plugin_names = {}
	for _, v in ipairs(vim.pack.get()) do
		table.insert(plugin_names, v.spec.name)
	end
	vim.pack.update(plugin_names)
end, {})
vim.api.nvim_create_user_command('GetPlugins', function()
	local plugin_names = {}
	for _, v in ipairs(vim.pack.get()) do
		table.insert(plugin_names, v.spec.name)
	end
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, plugin_names)
	vim.api.nvim_set_current_buf(buf)
end, {})
