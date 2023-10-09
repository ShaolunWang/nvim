-- making some new commands
vim.api.nvim_create_user_command('Session', function(args)
	if args.fargs[1] == 'here' then
		require('persistence').load()
	end
	if args.fargs[1] == 'last' then
		require('persistence').load({ last = true })
	end
end, { nargs = 1, desc = 'Persistence' })
