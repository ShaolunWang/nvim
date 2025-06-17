local M = {}
M.plugins = {
	{ 'stevearc/overseer.nvim', opt = true },
	{ 'OXY2DEV/helpview.nvim', opt = false },
	{ 'NeogitOrg/neogit', opt = true },
	{ 'folke/which-key.nvim' },
	{ 'OneOfOne/spm.nvim', opt = false },
	{ 'pechorin/any-jump.vim', opt = true },
	{ 'folke/snacks.nvim', opt = true },
	{ 'sindrets/diffview.nvim', opt = true },
	{ 'FabijanZulj/blame.nvim', opt = true },
	{ 'akinsho/git-conflict.nvim', opt = true },
	{ 'lewis6991/gitsigns.nvim' },
}

function M.load()
	require('lze').load({
		{
			'spm.nvim',
			after = function()
				-- default settings
				require('spm').setup({
					dir = '.nvim',
					set_cwd = true,
					use_views = true,
					local_only = true, -- don't save views / files unless they're in the project
					use_shada = true,
					keys = {
						create = '<leader>pc',
					},

					pre_load_fn = function() end,
					post_load_fn = function() end,
				})
			end,
		},
		{
			'overseer.nvim',
			on_require = { 'overseer' },
			after = function()
				local overseer = require('overseer')
				overseer.setup({
					dap = false,
					strategy = 'jobstart',
				})
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
			'helpview.nvim',
			after = function()
				require('helpview').setup()
			end,
		},
		{
			'blame.nvim',
			after = function()
				require('blame').setup({
					blame_options = { '-w' },
				})
			end,
			cmd = { 'BlameToggle' },
		},
		{
			'git-conflict.nvim',
			after = function()
				require('git-conflict').setup({
					default_mappings = false,
				})
			end,
			cmd = {
				'GitConflictListQf',
				'GitConflictRefresh',
				'GitConflictChooseBase',
				'GitConflictChooseBoth',
				'GitConflictChooseNone',
				'GitConflictChooseOurs',
				'GitConflictChooseTheirs',
				'GitConflictNextConflict',
				'GitConflictPrevConflict',
			},
		},
		{
			'neogit',
			cmd = 'Neogit',
			-- plenary should already be loaded here, no need to load it again
			after = function()
				require('neogit').setup({
					graph_style = 'unicode',
					auto_refresh = true,
					integrations = { diffview = true },
					kind = 'tab',
					use_magit_keybindings = true,
					disable_builtin_notifications = false,
				})
			end,
		},
		{
			'which-key.nvim',
			after = function()
				require('which-key').setup({
					preset = 'helix',
					notify = false,
					show_keypress = false,
				})
			end,
		},
		{
			'diffview.nvim',
			cmd = { 'DiffviewOpen' },
		},
		{
			'snacks.nvim',
			priority = 1000,
			lazy = false,
			after = function()
				require('snacks').setup({
					-- Toggle the profiler
					bigfile = { enabled = true },
					quickfile = { enabled = true },
					statuscolumn = { enabled = false },
					words = { enabled = false },
					styles = {
						---@diagnostic disable-next-line: missing-fields
						notification = {
							wo = { wrap = true }, -- Wrap notifications
						},
					},
					picker = {
						formatters = {
							file = {
								filename_first = true,
							},
						},
						layout = {
							preset = 'ivy',
						},
					},
					dashboard = { enabled = false },
					indent = { enabled = false },
					input = { enabled = true },
					notifier = { enabled = false },
					scroll = { enabled = false },
				})
				-- Snacks.toggle.diagnostics():map(',d')
				Snacks.toggle
					.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map('\\c')
			end,
			keys = {
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
		},
		{
			'gitsigns.nvim',
			after = function()
				require('gitsigns').setup()
			end,
			--			cmd = { 'G' },
		},
		{
			'any-jump.vim',
			after = function()
				vim.g.any_jump_window_width_ratio = 0.8
				vim.g.any_jump_window_height_ratio = 0.8
				vim.g.any_jump_disable_default_keybindings = 1
			end,
			cmd = { 'AnyJump', 'AnyJumpArg', 'AnyJumpVisual', 'AnyJumpBack', 'AnyJumpLastResults' },
		},
	})
end

return M
