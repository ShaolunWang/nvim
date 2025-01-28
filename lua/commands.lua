vim.api.nvim_create_user_command('G', function()
	vim.cmd([[Neogit]])
end, {})
vim.api.nvim_create_user_command('Sg', function()
	vim.cmd([[:lua require('grug-far').open({ engine = 'astgrep' }) ]])
end, {})
vim.api.nvim_create_user_command('Rg', function()
	vim.cmd([[:lua require('grug-far').open({ engine = 'ripgrep' }) ]])
end, {})
vim.api.nvim_create_user_command('UndotreeToggle', function()
	vim.cmd([[:lua require('undotree').toggle()]])
end, {})

vim.api.nvim_create_user_command('T', function()
	-- require('nvim-tree.api').tree.toggle()
	--	vim.cmd([[:lua MiniFiles.open()]])
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
			'default',
		},
	})
	task:start()
end, {
	desc = 'Build, no quickfix list',
	nargs = '*',
	bang = true,
})

--[[ local function qftree(location)
	local entries
	local list_name
	local path
	if location == true then
		entries = vim.fn.getloclist(0)
		list_name = 'Location'
	else
		entries = vim.fn.getqflist(0)
		list_name = 'Quickfix'
	end
	if next(entries) == nil then
		vim.print(list_name + 'list is empty')
		return
	else
		for e in entries do
			vim.fn.fnamemodify(vim.api.nvim_buf_get_name(enties['bufnr']), ':p:.')
		end
	end
end ]]
