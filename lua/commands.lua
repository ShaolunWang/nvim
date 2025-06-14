local ar = require('utils.arglist')
vim.api.nvim_create_user_command('G', function()
	vim.cmd([[Neogit]])
end, {})
vim.api.nvim_create_user_command('Sg', function()
	vim.cmd([[:lua require('grug-far').open({ engine = 'astgrep' }) ]])
end, {})
vim.api.nvim_create_user_command('B', function()
	require('buvvers').toggle()
end, {})
vim.api.nvim_create_user_command('Rg', function()
	vim.cmd([[:lua require('grug-far').open({ engine = 'ripgrep' }) ]])
end, {})
vim.api.nvim_create_user_command('UndotreeToggle', function()
	vim.cmd([[:lua require('undotree').toggle()]])
end, {})
vim.api.nvim_create_user_command('PReload', function()
	local luacache = (_G.__luacache or {}).cache
	-- TODO unload commands, mappings + ?symbols?
	for pkg, _ in pairs(package.loaded) do
		if pkg:match('^my_.+') then
			print(pkg)
			package.loaded[pkg] = nil
			if luacache then
				lucache[pkg] = nil
			end
		end
	end
	dofile(vim.env.MYVIMRC)
	vim.notify('Config reloaded!', vim.log.levels.INFO)
end, {})
vim.api.nvim_create_user_command('T', function()
	-- require('nvim-tree.api').tree.toggle()
	--	vim.cmd([[:lua MiniFiles.open()]])
	vim.cmd([[Otree]])
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

vim.api.nvim_create_user_command('ArgEdit', function()
	ar.arg_edit()
end, {})

vim.api.nvim_create_user_command('ArgAdd', function()
	local pos = vim.fn.getpos('.')
	local path = vim.fn.expand('%:.')
	ar.arg_add(path, pos)
end, {})

vim.api.nvim_create_user_command('ArgDebug', function()
	vim.cmd([[grep getqf]])
	ar.qf_to_arglist()
end, {})
