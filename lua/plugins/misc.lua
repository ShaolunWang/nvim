return {

	--[[ {
		'tversteeg/registers.nvim',
		config = function()
			require('registers').setup({ bind_keys = { normal = false, insert = false } })
		end,
		keys = {
			{ '"', mode = { 'n', 'v' } },
		},
		cmd = 'Registers',
	}, ]]
	{
		'stevearc/overseer.nvim',
		opts = {
			dap = false,
		},
		config = function()
			local overseer = require('overseer')
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
			local cmd = {
				'OverseerOpen',
				'OverseerClose',
				--				'OverseerToggle',
				'OverseerSaveBundle',
				'OverseerLoadBundle',
				'OverseerDeleteBundle',
				'OverseerRunCmd',
				-- 'OverseerRun',
				'OverseerInfo',
				'OverseerBuild',
				'OverseerQuickAction',
				'OverseerTaskAction',
				--				'OverseerClearCache',
			}
			for _, iter in pairs(cmd) do
				vim.api.nvim_del_user_command(iter)
			end
		end,
	},
	{
		'NeogitOrg/neogit',
		cmd = 'Neogit',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'sindrets/diffview.nvim',
			'ibhagwan/fzf-lua',
			{
				{
					'akinsho/git-conflict.nvim',
					version = '*',
					config = true,
				},
			},
		},
		opts = {
			graph_style = 'kitty',
			auto_refresh = true,
			integrations = { diffview = true },
			kind = 'tab',
			use_magit_keybindings = true,
			disable_builtin_notifications = false,
		},
	},

	{
		'folke/which-key.nvim',
		--		event = 'VeryLazy',
		config = function()
			require('which-key').setup({
				preset = 'helix',
				notify = false,
				show_keypress = false,
			})
		end,
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
		},
		opts = {
			completion = {
				-- Set to false to disable completion.
				nvim_cmp = false,
			},
			workspaces = {
				{
					name = "no-vault",
					path = function()
						return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
					end,
					overrides = {
						notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
						new_notes_location = "current_dir",
						templates = {
							folder = vim.NIL,
						},
						disable_frontmatter = true,
					},
				},
			},
		},
	}
}
