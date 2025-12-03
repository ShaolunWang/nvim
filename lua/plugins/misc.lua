local M = {}
M.plugins = {
	{ src = 'https://github.com/stevearc/overseer.nvim' },
	{ src = 'https://github.com/OXY2DEV/helpview.nvim' },
	{ src = 'https://github.com/folke/which-key.nvim' },
	{ src = 'https://github.com/chrisgrieser/nvim-justice' },
	{ src = 'https://github.com/BartSte/nvim-project-marks' },
	{ src = 'https://github.com/pechorin/any-jump.vim' },
	{ src = 'https://github.com/folke/snacks.nvim' },
}

function M.load()
	require('lze').load({
		{
			'nvim-justice',
			after = function()
				require('justice').setup({})
			end,
			cmd = { 'Justice' },
		},
		{
			'nvim-project-marks',
			after = function()
				require('projectmarks').setup({
					mappings = true,
					shadafile = vim.fn.stdpath('data') .. '/shadas/' .. vim.fn.getcwd():gsub('[/\\]', '') .. '.shada',
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
					templates = { 'builtin' },
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
