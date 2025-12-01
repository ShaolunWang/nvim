local M = {}
M.plugins = {
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/chrisgrieser/nvim-early-retirement' },
	{ src = 'https://github.com/MunifTanjim/nui.nvim' },
	{ src = 'https://github.com/stevearc/oil.nvim' },
	{ src = 'https://github.com/alexpasmantier/tv.nvim' },
	{ src = 'https://github.com/nvim-neo-tree/neo-tree.nvim' },
}

function M.load()
	require('lze').load({
		{ 'plenary.nvim', on_require = 'plenary' },

		{
			'nvim-early-retirement',
			after = function()
				require('early-retirement').setup({ retirementAgeMins = 1 })
			end,
		},
		{ 'nui.nvim', on_require = 'nui' },
		{
			'oil.nvim',
			cmd = { 'Oil' },
			on_require = 'oil',
			dep_of = 'Otree',
			after = function()
				require('oil').setup({
					float = {
						-- optionally override the oil buffers window title with custom function: fun(winid: integer): string
						get_win_title = nil,
						-- preview_split: Split direction: "auto", "left", "right", "above", "below".
						preview_split = 'right',
						-- This is the config that will be passed to nvim_open_win.
						-- Change values here to customize the layout
						override = function(conf)
							return conf
						end,
					},
					default_file_explorer = false,
					use_default_keymaps = false,

					preview_win = {
						update_on_cursor_moved = true,
					},
					keymaps = {
						['<CR>'] = 'actions.select',
						['-'] = 'actions.parent',
						['_'] = 'actions.open_cwd',
						['~'] = 'actions.tcd',
						['g.'] = 'actions.toggle_hidden',
						['<c-p>'] = 'actions.preview',
						['g?'] = false,
						['<C-s>'] = false,
						['<C-h>'] = false,
						['<C-t>'] = false,
						['<C-c>'] = false,
						['<C-l>'] = false,
						['gs'] = false,
						['gx'] = false,
						['g\\'] = false,
					},
				})
			end,
		},
		{
			'neo-tree.nvim',
			cmd = { 'Neotree' },
			after = function()
				require('neo-tree').setup({
					enable_diagnostics = false,
					default_component_configs = {
						indent = {
							with_markers = false,
						},
					},
					window = {
						width = 25,
						mappings = {
							['<space>'] = {
								'toggle_node',
								nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
							},
							['<2-LeftMouse>'] = 'open',
							['<cr>'] = 'open',
							['l'] = 'open',
							['<esc>'] = 'cancel', -- close preview or floating neo-tree window
							['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = false } },
							['<c-x>'] = 'open_split',
							['<c-v>'] = 'open_vsplit',
							['t'] = 'open_tabnew',
							['<tab>'] = 'open',
							['C'] = 'close_node',
							['z'] = 'close_all_nodes',
							['a'] = {
								'add',
								-- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
								-- some commands may take optional config options, see `:h neo-tree-mappings` for details
								config = {
									show_path = 'none', -- "none", "relative", "absolute"
								},
							},
							['A'] = 'add_directory', -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
							['d'] = 'delete',
							['r'] = 'rename',
							['b'] = 'rename_basename',
							['y'] = 'copy_to_clipboard',
							['x'] = 'cut_to_clipboard',
							['p'] = 'paste_from_clipboard',
							['c'] = 'copy', -- takes text input for destination, also accepts the optional config.show_path option like "add":
							-- ["c"] = {
							--  "copy",
							--  config = {
							--    show_path = "none" -- "none", "relative", "absolute"
							--  }
							--}
							['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like "add".
							['q'] = 'close_window',
							['R'] = 'refresh',
							['?'] = 'show_help',
							['<'] = 'prev_source',
							['>'] = 'next_source',
							['i'] = 'show_file_details',
							-- ["i"] = {
							--   "show_file_details",
							--   -- format strings of the timestamps shown for date created and last modified (see `:h os.date()`)
							--   -- both options accept a string or a function that takes in the date in seconds and returns a string to display
							--   -- config = {
							--   --   created_format = "%Y-%m-%d %I:%M %p",
							--   --   modified_format = "relative", -- equivalent to the line below
							--   --   modified_format = function(seconds) return require('neo-tree.utils').relative_date(seconds) end
							--   -- }
							-- },
						},
					},
				})
			end,
		},
		{
			'tv.nvim',
			after = function()
				require('tv').setup({
					keybindings = {
						files = '<C-p>', -- or false to disable
						text = '<leader><leader>',
						channels = '<leader>tv', -- channel selector
						files_qf = '<C-q>', -- quickfix binding (inside tv)
						text_qf = '<C-q>',
					},
					quickfix = {
						auto_open = true, -- auto-open quickfix window
					},
					window = {
						width = 0.8, -- 80% of editor
						height = 0.8,
						border = 'none', -- none|single|double|rounded|solid|shadow
						title = ' tv ',
					},
					files = {
						args = { '--preview-size', '70' },
						window = {}, -- override window config for files
					},
					text = {
						args = { '--preview-size', '70' },
						window = {}, -- override window config for text
					},
				})
			end,
		},
	})
end

return M
