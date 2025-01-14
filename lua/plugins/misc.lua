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
				'OverseerToggle',
				'OverseerSaveBundle',
				'OverseerLoadBundle',
				'OverseerDeleteBundle',
				'OverseerRunCmd',
				-- 'OverseerRun',
				'OverseerInfo',
				'OverseerBuild',
				'OverseerQuickAction',
				'OverseerTaskAction',
				'OverseerClearCache',
			}
			for _, iter in pairs(cmd) do
				vim.api.nvim_del_user_command(iter)
			end
		end,
		cmd = { 'OverseerRun' },
		keys = { '<F5>' },
	},
	{
		'NeogitOrg/neogit',
		cmd = 'Neogit',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'sindrets/diffview.nvim',
			{
				'FabijanZulj/blame.nvim',
				lazy = true,
				config = function()
					require('blame').setup()
				end,
				opts = {
					blame_options = { '-w' },
				},
			},
			{
				'akinsho/git-conflict.nvim',
				version = '*',
				config = true,
			},
		},
		opts = {
			graph_style = 'unicode',
			auto_refresh = true,
			integrations = { diffview = true },
			kind = 'floating',
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
		'folke/snacks.nvim',
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- Toggle the profiler
			bigfile = { enabled = true },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = false },
			styles = {
				notification = {
					wo = { wrap = true }, -- Wrap notifications
				},
			},
			picker = {
				layout = {
					preset = 'ivy',
				},
			},
			dashboard = { enabled = false },
			indent = { enabled = false },
			input = { enabled = true },
			notifier = { enabled = false },
			scroll = { enabled = false },
		},
		keys = {
			{
				',x',
				function()
					Snacks.bufdelete()
				end,
				desc = 'Delete Buffer',
			},
			{
				']]',
				function()
					Snacks.words.jump(vim.v.count1)
				end,
				desc = 'Next Reference',
			},
			{
				'[[',
				function()
					Snacks.words.jump(-vim.v.count1)
				end,
				desc = 'Prev Reference',
			},
		},
		init = function()
			vim.api.nvim_create_autocmd('User', {
				pattern = 'VeryLazy',
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command

					-- Create some toggle mappings
					Snacks.toggle.diagnostics():map(',d')
					Snacks.toggle
						.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
						:map(',c')
					Snacks.toggle.treesitter():map(',t')
					Snacks.toggle.inlay_hints():map(',h')
				end,
			})
		end,
	},
}
