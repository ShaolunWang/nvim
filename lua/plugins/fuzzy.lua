function telescope_setup()
	local present, telescope = pcall(require, 'telescope')

	vim.cmd([[
    highlight TelescopePromptBorder guifg=#eeeeee      guibg=none     gui=none
    highlight TelescopeResultsBorder guifg=#eeeeee      guibg=none     gui=italic
    highlight TelescopePreviewBorder guifg=#eeeeee      guibg=none     gui=none
  ]])
	local options = telescope_options()
	telescope.setup(options)
	telescope.load_extension('ui-select')
	telescope.load_extension('fzf')
end

function telescope_options()
	local options = {
		extensions = {
			['fzf'] = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
			['ui-select'] = {
				require('telescope.themes').get_dropdown(),
				require('telescope.themes').get_ivy(),
			},
		},
		defaults = {
			vimgrep_arguments = {
				'rg',
				'--color=never',
				'--no-heading',
				'--with-filename',
				'--line-number',
				'--column',
				'--smart-case',
				'--glob=!.git/',
			},
			--			cache_picker = { num_pickers = 10 },
			dynamic_preview_title = true,
			prompt_prefix = '  ',
			selection_caret = '❯ ',
			entry_prefix = '  ',
			initial_mode = 'insert',
			selection_strategy = 'reset',
			sorting_strategy = 'ascending',
			-- layout_strategy = 'vertical',
			layout_config = {
				horizontal = {
					prompt_position = 'top',
					preview_width = 0.55,
					results_width = 0.60,
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				vertical = {
					prompt_position = 'top',
					width = 0.5,
					height = 0.5,
					--		mirror = true,
				},
			},
			file_sorter = require('telescope.sorters').get_fuzzy_file,
			generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
			path_display = { 'truncate' },
			winblend = 0,
			border = {},
			borderchars = {
				{ '─', '│', '─', '│', '┌', '┐', '┘', '└' },
				prompt = { '─', '│', ' ', '│', '┌', '┐', '│', '│' },
				results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
				preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
			},
			color_devicons = true,
			file_previewer = require('telescope.previewers').vim_buffer_cat.new,
			grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
			qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
			-- Developer configurations: Not meant for general override
			buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
		},
		pickers = {
			live_grep = {},
			builtin = { theme = 'ivy', previewer = false, layout_strategy = 'vertical', prompt_position = 'top' },
			oldfiles = { theme = 'ivy', previewer = false, layout_strategy = 'vertical', prompt_position = 'top' },
			find_files = { theme = 'ivy', previewer = false, layout_strategy = 'vertical', prompt_position = 'top' },
			buffers = {
				theme = 'ivy',
				previewer = false,
				layout_strategy = 'vertical',
				prompt_position = 'top',
				initial_mode = 'normal',
				mappings = {
					n = {
						['dd'] = require('telescope.actions').delete_buffer,
					},
				},
			},
		},
	}
	return options
end

local fuzzy = {}
if vim.loop.os_uname().sysname ~= 'Windows_NT' then
	fuzzy = {
		{
			'ibhagwan/fzf-lua',
			-- optional for icon support
			dependencies = { 'nvim-tree/nvim-web-devicons' },
			config = function()
				require('fzf-lua').setup({
					winopts = {
						fullscreen = true,
						border = false,
						preview = {
							default = 'bat_native',
							layout = 'flex',
							border = 'noborder',
							scrollbar = false,
							scrollchars = '', -- scrollbar chars ({ <full>, <empty> }
						},
					},
					files = {
						prompt = 'Files❯ ',
						git_icons = true,
						file_icons = true,
						color_icons = true,
						previewer = 'false',
						fd_opts = '--color=never --type f --hidden --follow --exclude .git',
					},
				})
			end,
			keys = { '<leader>' },
			cmd = { 'FzfLua' },
		},
	}
else
	fuzzy = {
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
			lazy = true,
		},
		{
			'nvim-telescope/telescope.nvim',
			dependencies = {
				'nvim-lua/plenary.nvim',
				'nvim-telescope/telescope-ui-select.nvim',
				'nvim-telescope/telescope-fzf-native.nvim',
			},
			keys = { '<leader>' },
			cmd = { 'Telescope' },
			lazy = true,
			config = telescope_setup,
		},
	}
end
return fuzzy
