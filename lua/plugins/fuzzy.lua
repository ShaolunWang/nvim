-- :fennel:1704702217
local telescope_opts
local function _1_()
	local options = {
		defaults = {
			border = {},
			borderchars = {
				{
					'\226\148\128',
					'\226\148\130',
					'\226\148\128',
					'\226\148\130',
					'\226\148\140',
					'\226\148\144',
					'\226\148\152',
					'\226\148\148',
				},
				preview = {
					'\226\148\128',
					'\226\148\130',
					'\226\148\128',
					'\226\148\130',
					'\226\148\140',
					'\226\148\144',
					'\226\148\152',
					'\226\148\148',
				},
				prompt = {
					'\226\148\128',
					'\226\148\130',
					' ',
					'\226\148\130',
					'\226\148\140',
					'\226\148\144',
					'\226\148\130',
					'\226\148\130',
				},
				results = {
					'\226\148\128',
					'\226\148\130',
					'\226\148\128',
					'\226\148\130',
					'\226\148\156',
					'\226\148\164',
					'\226\148\152',
					'\226\148\148',
				},
			},
			buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
			color_devicons = true,
			dynamic_preview_title = true,
			entry_prefix = '  ',
			file_previewer = require('telescope.previewers').vim_buffer_cat.new,
			file_sorter = require('telescope.sorters').get_fuzzy_file,
			generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
			grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
			initial_mode = 'insert',
			layout_config = {
				horizontal = {
					height = 0.8,
					preview_cutoff = 120,
					preview_width = 0.55,
					prompt_position = 'top',
					results_width = 0.6,
					width = 0.87,
				},
				vertical = { height = 0.5, prompt_position = 'top', width = 0.5 },
			},
			path_display = { 'truncate' },
			prompt_prefix = ' \239\128\130 ',
			qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
			selection_caret = '\226\157\175 ',
			selection_strategy = 'reset',
			sorting_strategy = 'ascending',
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
			winblend = 0,
		},
		extensions = {
			fzf = { case_mode = 'smart_case', fuzzy = true, override_file_sorter = true, override_generic_sorter = true },
			['ui-select'] = { require('telescope.themes').get_dropdown(), require('telescope.themes').get_ivy() },
		},
		pickers = {
			buffers = {
				initial_mode = 'normal',
				layout_strategy = 'vertical',
				mappings = { n = { dd = require('telescope.actions').delete_buffer } },
				prompt_position = 'top',
				theme = 'ivy',
				previewer = false,
			},
			builtin = { layout_strategy = 'vertical', prompt_position = 'top', theme = 'ivy', previewer = false },
			find_files = { layout_strategy = 'vertical', prompt_position = 'top', theme = 'ivy', previewer = false },
			live_grep = {},
			oldfiles = { layout_strategy = 'vertical', prompt_position = 'top', theme = 'ivy', previewer = false },
		},
	}
	return options
end
telescope_opts = _1_
local telescope_setup
local function _2_()
	local present, telescope = pcall(require, 'telescope')
	vim.cmd(
		'    highlight TelescopePromptBorder guifg=#eeeeee      guibg=none     gui=none\n    highlight TelescopeResultsBorder guifg=#eeeeee      guibg=none     gui=italic\n    highlight TelescopePreviewBorder guifg=#eeeeee      guibg=none     gui=none\n  '
	)
	local options = telescope_opts()
	telescope.setup(options)
	telescope.load_extension('ui-select')
	return telescope.load_extension('fzf')
end
telescope_setup = _2_
local fuzzy = {}
if vim.loop.os_uname().sysname ~= 'Windows_NT' then
	local function _3_()
		require('fzf-lua').setup({
			files = {
				color_icons = true,
				fd_opts = '--color=never --type f --hidden --follow --exclude .git',
				file_icons = true,
				git_icons = true,
				previewer = 'bat',
				prompt = 'Files\226\157\175 ',
			},
			winopts = {
				fullscreen = true,
				preview = { border = 'noborder', default = 'bat_native', layout = 'flex', scrollchars = '', scrollbar = false },
				border = false,
			},
		})
		return require('fzf-lua').register_ui_select()
	end
	fuzzy = {
		{
			'ibhagwan/fzf-lua',
			cmd = { 'FzfLua' },
			config = _3_,
			dependencies = { 'nvim-tree/nvim-web-devicons' },
			keys = { '<leader>' },
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
			cmd = { 'Telescope' },
			config = telescope_setup,
			dependencies = {
				'nvim-lua/plenary.nvim',
				'nvim-telescope/telescope-ui-select.nvim',
				'nvim-telescope/telescope-fzf-native.nvim',
			},
			keys = { '<leader>' },
			lazy = true,
		},
	}
end
return fuzzy
