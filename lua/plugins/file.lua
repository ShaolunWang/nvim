local M = {}
M.plugins = {
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/chrisgrieser/nvim-early-retirement' },
	{ src = 'https://github.com/MunifTanjim/nui.nvim' },
	{ src = 'https://github.com/barrettruth/canola.nvim', version = 'canola' },
	{ src = 'https://github.com/nvim-neo-tree/neo-tree.nvim' },
	{ src = 'https://github.com/refractalize/oil-git-status.nvim' },
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
			'canola.nvim',
			cmd = { 'Canola' },
			-- on_require = 'oil',
			-- beforeAll = function()
			-- 	require('utils.oil')
			-- end,
			beforeAll = function()
				vim.g.canola = {
					float = {
						default = true,
						title = false,
						padding = 2,
						max_width = 0,
						max_height = 0,
						border = 'rounded',
						preview_split = 'auto',
						win = {
							winblend = 0,
						},
					},
					columns = { 'icon' },
					cursor = true,
					hidden = {
						enabled = true,
					},
					keymaps = {
						['-'] = 'actions.parent',
						['<C-c>'] = false,
						['<C-h>'] = false,
						['<C-l>'] = false,
						['<C-p>'] = false,
						['<C-s>'] = false,
						['<C-t>'] = false,
						['<CR>'] = 'actions.select',
						['<c-p>'] = 'actions.preview',
						_ = 'actions.open_cwd',
						['`'] = false,
						desc = 'Open in target window',
						['g.'] = 'actions.toggle_hidden',
						['g?'] = false,
						['g\\'] = false,
						gs = false,
						gx = false,
						gy = false,
						['g~'] = false,
						mode = 'n',
						q = false,
						-- ['~'] = 'actions.tcd',
					},
					watch = false,
					win = {
						concealcursor = 'nvic',
						conceallevel = 3,
						cursorcolumn = false,
						foldcolumn = '0',
						list = false,
						signcolumn = 'yes:2',
						spell = false,
						wrap = false,
					},
				}

				-- require('oil-git-status').setup()
			end,
		},
		-- { 'oil-git-status.nvim', on_require = 'oil-git-status' },
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
	})
end

return M
