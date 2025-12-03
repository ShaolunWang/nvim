local M = {}
M.plugins = {
	{ src = 'https://github.com/sindrets/diffview.nvim' },
	{ src = 'https://github.com/NeogitOrg/neogit' },
	{ src = 'https://github.com/akinsho/git-conflict.nvim' },
	{ src = 'https://github.com/FabijanZulj/blame.nvim' },
	{ src = 'https://github.com/lewis6991/gitsigns.nvim' },
	{ src = 'https://github.com/NicolasGB/jj.nvim' },
}
function M.load()
	require('lze').load({
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
			'diffview.nvim',
			cmd = { 'DiffviewOpen' },
		},
		{
			'gitsigns.nvim',
			after = function()
				require('gitsigns').setup()
			end,
			cmd = { 'Gitsigns' },
		},
		{
			'jj.nvim',
			after = function()
				require('jj').setup()
			end,
			cmd = { 'J' },
		},
	})
end
return M
