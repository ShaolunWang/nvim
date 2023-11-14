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
				git = false,
			},
		},
	},
	update_focused_file = {
		enable = true,
		update_root = true,
		ignore_list = { 'help' },
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
	actions = {
		change_dir = {
			enable = false,
			restrict_above_cwd = true,
		},
		open_file = {
			resize_window = true,
			window_picker = {
				chars = 'aoeui',
			},
		},
		remove_file = {
			close_window = false,
		},
	},
	log = {
		enable = true,
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
	'nvim-tree/nvim-tree.lua',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('nvim-tree').setup(tree_opts)
	end,
	cmd = { 'NvimTreeToggle' },
}
