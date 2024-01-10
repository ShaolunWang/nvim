-- :fennel:1704702217
local tree_opts = {
	actions = {
		open_file = { resize_window = true, window_picker = { chars = 'aoeui' } },
		remove_file = { close_window = false },
	},
	diagnostics = { enable = true, show_on_dirs = true },
	hijack_cursor = true,
	log = { enable = true, truncate = true, types = { diagnostics = true, git = true, profile = true, watcher = true } },
	renderer = {
		group_empty = true,
		icons = { git_placement = 'signcolumn', show = { file = true, folder_arrow = true, folder = false, git = false } },
		indent_markers = { enable = true },
		full_name = false,
	},
	sync_root_with_cwd = true,
	update_focused_file = { enable = true, ignore_list = { 'help' } },
	view = { adaptive_size = true },
}
local function _1_()
	return require('nvim-tree').setup(tree_opts)
end
return {
	{ 'nvim-tree/nvim-tree.lua', cmd = { 'NvimTreeToggle' }, config = _1_, dependencies = {
		'nvim-tree/nvim-web-devicons',
	} },
	{
		'stevearc/oil.nvim',
		cmd = { 'Oil' },
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			keymaps = {
				['-'] = 'actions.parent',
				['<CR>'] = 'actions.select',
				_ = 'actions.open_cwd',
				['`'] = 'actions.cd',
				['g.'] = 'actions.toggle_hidden',
				['~'] = 'actions.tcd',
				['<C-c>'] = false,
				['<C-h>'] = false,
				['<C-l>'] = false,
				['<C-p>'] = false,
				['<C-s>'] = false,
				['<C-t>'] = false,
				['g?'] = false,
				['g\\'] = false,
				gs = false,
				gx = false,
			},
			use_default_keymaps = false,
		},
	},
}
