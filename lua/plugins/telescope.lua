function telescope_setup()
	local present, telescope = pcall(require, 'telescope')

	vim.cmd([[
  highlight TelescopePromptBorder guifg=#eeeeee      guibg=none     gui=none
  highlight TelescopeResultsBorder guifg=#eeeeee      guibg=none     gui=italic
  highlight TelescopePreviewBorder guifg=#eeeeee      guibg=none     gui=none
  ]])
	local options = telescope_options()
	telescope.setup(options)
end

function telescope_options()
	local options = {
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
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
			},
			prompt_prefix = '  ',
			selection_caret = '❯ ',
			entry_prefix = '  ',
			initial_mode = 'insert',
			selection_strategy = 'reset',
			sorting_strategy = 'ascending',
			layout_strategy = 'horizontal',
			layout_config = {
				horizontal = {
					prompt_position = 'top',
					preview_width = 0.55,
					results_width = 0.60,
				},
				vertical = {
					mirror = true,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
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
	}
	return options
end
return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	keys = { '<leader>' },
	cmd = { 'Telescope' },
	config = telescope_setup,
}
