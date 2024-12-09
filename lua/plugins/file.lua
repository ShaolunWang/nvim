return {
	--[[ {
		'nvim-tree/nvim-tree.lua',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('nvim-tree').setup(tree_opts)
		end,
		cmd = { 'NvimTreeToggle' },
	},]]
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
	--[[ {
		'mikavilpas/yazi.nvim',
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				'<>',
				'<cmd>Yazi<cr>',
				desc = 'Open yazi at the current file',
			},
			{
				-- Open in the current working directory
				'<c-m>',
				'<cmd>Yazi cwd<cr>',
				desc = "Open the file manager in nvim's working directory",
			},
			},
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = true,
		},
	} ]]
	{
		'lambdalisue/vim-fern',
		dependencies = {
			'TheLeoP/fern-renderer-web-devicons.nvim',
			'lambdalisue/vim-fern-git-status',
		},
		config = function()
			vim.g['fern#renderer'] = 'nvim-web-devicons'
			vim.g['fern#hide_cursor'] = 1
			vim.g['fern#keepalt_on_edit'] = 1
			vim.g['fern#default_hidden'] = 1
			vim.g['fern#disable_default_mappings'] = 1
		end,
		cmd = { 'Fern' },
	},
}
