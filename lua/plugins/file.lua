local tree_opts = {
	hijack_cursor = true,
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = false,
	},
	on_attach = on_attach,
	view = { adaptive_size = true },
	renderer = {
		full_name = false,
		group_empty = true,
		indent_markers = {
			enable = true,
		},
		icons = {
			git_placement = 'signcolumn',
			show = {
				file = true,
				folder = false,
				folder_arrow = true,
				git = true,
			},
		},
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
	actions = {
		open_file = {
			resize_window = true,
			window_picker = {
				chars = 'aoeui',
				exclude = {
					filetype = { 'undotree', 'trouble', 'diff' },
				},
			},
		},
		remove_file = {
			close_window = false,
		},
	},
	log = {
		enable = false,
		truncate = true,
		types = {
			diagnostics = true,
			git = true,
			profile = true,
			watcher = true,
		},
	},
}
return {
	{
		'nvim-tree/nvim-tree.lua',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('nvim-tree').setup(tree_opts)
		end,
		cmd = { 'NvimTreeToggle' },
	},
	{
		'stevearc/oil.nvim',
		opts = {
			use_default_keymaps = false,
			keymaps = {
				['<CR>'] = 'actions.select',
				['-'] = 'actions.parent',
				['_'] = 'actions.open_cwd',
				['`'] = 'actions.cd',
				['~'] = 'actions.tcd',
				['g.'] = 'actions.toggle_hidden',
				['g?'] = false,
				['<C-s>'] = false,
				['<C-h>'] = false,
				['<C-t>'] = false,
				['<C-p>'] = false,
				['<C-c>'] = false,
				['<C-l>'] = false,
				['gs'] = false,
				['gx'] = false,
				['g\\'] = false,
			},
		},
		-- Optional dependencies
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		cmd = { 'Oil' },
	},
}
