return {

	{
		'tversteeg/registers.nvim',
		config = function()
			require('registers').setup({ bind_keys = { normal = false, insert = false } })
		end,
		keys = {
			{ '"', mode = { 'n', 'v' } },
		},
		cmd = 'Registers',
	},
	{
		'hauleth/asyncdo.vim',
	},
	{
		'stevearc/overseer.nvim',
		opts = {
			dap = false,
		},
		config = function()
			overseer = require('overseer')
			overseer.setup(opts)
			-- Add on_output_quickfix component to all "cargo" templates
			overseer.add_template_hook({ module = '^just$' }, function(task_defn, util)
				util.add_component(task_defn, { 'on_output_quickfix', open = true })
			end)
			-- Remove the on_complete_notify component from "cargo clean" task
			overseer.add_template_hook({ name = '^just$' }, function(task_defn, util)
				util.remove_component(task_defn, 'on_complete_notify')
			end)

			overseer.add_template_hook({ name = '^grep$' }, function(task_defn, util)
				util.remove_component(task_defn, 'on_complete_notify')
			end)
			-- Add an environment variable for all go tasks in a specific dir
		end,
	},
	{
		'NeogitOrg/neogit',
		cmd = 'Neogit',
		dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim', 'ibhagwan/fzf-lua' },
		opts = {
			auto_refresh = true,
			integrations = { diffview = true },
			kind = 'tab',
			use_magit_keybindings = true,
			disable_builtin_notifications = false,
		},
	},
	{
		'mihaifm/bufstop',
		config = function()
			vim.g.BufstopAutoSpeedToggle = true
		end,
		cmd = {
			'BufstopModeFast',
			'BufstopPreview',
		},
	},
}
