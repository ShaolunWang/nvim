if vim.g.neovide then
	vim.g.neovide_cursor_animation_length = 0
	vim.fn.setcellwidths({ { 0x2002, 0x2002, 2 } })
	vim.g.neovide_cursor_animate_command_line = false
	vim.g.neovide_cursor_animate_in_insert_mode = false
	vim.g.neovide_cursor_trail_size = 0
end
local function cpp_modern_config()
	return vim.cmd('\9       let g:cpp_attributes_highlight = 1\n\9       let g:cpp_member_highlight = 1\n\9     ')
end

local function cscope_config()
	require('cscope_maps').setup({
		cscope = {
			db_build_cmd = { script = 'default', args = { '-bqkv -i ./cscope.files' } },
			exec = 'gtags-cscope',
			picker = 'quickfix',
			skip_picker_for_single_result = true,
		},
	})
	local sym_map = {
		a = 'Assignment',
		c = 'Functions Calling this',
		d = 'Functions called',
		e = 'EGrep Pattern',
		f = 'File',
		g = 'Def',
		i = 'Files #including this File',
		s = 'Symbol',
		t = 'Text String',
	}
	local function get_cscope_prompt_cmd(operation, selection)
		local sel = 'cword'
		if selection == 'f' then
			sel = 'cfile'
		else
		end
		return string.format(
			"<cmd>lua require('cscope_maps').cscope_prompt('%s', vim.fn.expand(\"<%s>\"))<cr>",
			operation,
			sel
		)
	end
	vim.keymap.set(
		'n',
		'<leader>cs',
		get_cscope_prompt_cmd('s', 'w'),
		{ desc = sym_map.s, noremap = true, silent = true }
	)
	vim.keymap.set(
		'n',
		'<leader>cg',
		get_cscope_prompt_cmd('g', 'w'),
		{ desc = sym_map.g, noremap = true, silent = true }
	)
	vim.keymap.set(
		'n',
		'<leader>cc',
		get_cscope_prompt_cmd('c', 'w'),
		{ desc = sym_map.c, noremap = true, silent = true }
	)
	vim.keymap.set(
		'n',
		'<leader>ct',
		get_cscope_prompt_cmd('t', 'w'),
		{ desc = sym_map.t, noremap = true, silent = true }
	)
	vim.keymap.set(
		'n',
		'<leader>ce',
		get_cscope_prompt_cmd('e', 'w'),
		{ desc = sym_map.e, noremap = true, silent = true }
	)
	vim.keymap.set(
		'n',
		'<leader>cf',
		get_cscope_prompt_cmd('f', 'f'),
		{ desc = sym_map.f, noremap = true, silent = true }
	)
	vim.keymap.set(
		'n',
		'<leader>ci',
		get_cscope_prompt_cmd('i', 'f'),
		{ desc = sym_map.i, noremap = true, silent = true }
	)
	vim.keymap.set(
		'n',
		'<leader>cd',
		get_cscope_prompt_cmd('d', 'w'),
		{ desc = sym_map.d, noremap = true, silent = true }
	)
	vim.keymap.set(
		'n',
		'<leader>ca',
		get_cscope_prompt_cmd('a', 'w'),
		{ desc = sym_map.a, noremap = true, silent = true }
	)
	vim.keymap.set(
		'n',
		'<C-]>',
		'<cmd>exe "Cstag" expand("<cword>")<cr>',
		{ desc = 'ctag', noremap = true, silent = true }
	)
	vim.b.miniclue_config = { clues = { { desc = '+Cscope Find ...', keys = '<Leader>c', mode = 'n' } } }
	return nil
end
return {
	{ 'bfrg/vim-cpp-modern', config = cpp_modern_config, ft = { 'c', 'cpp', 'h', 'hpp' } },
	{
		'dhananjaylatkar/cscope_maps.nvim',
		config = cscope_config,
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		ft = { 'cpp', 'h', 'hpp', 'c' },
	},
	-- Lua
	{
		'folke/twilight.nvim',
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		cmd = { 'Twilight' },
	},
	{
		'MunifTanjim/nui.nvim',
		lazy = true,
	},
	--[[ {
		'folke/noice.nvim',
		event = 'VeryLazy',
		dependencies = {
			'MunifTanjim/nui.nvim',
		},
		opts = {
			-- add any options here
			views = {
				cmdline_popup = {
					position = {
						row = '97%',
						col = '50%',
					},
					size = {
						width = 60,
						height = 1,
					},
					border = {
						style = 'none',
						padding = { 0, 0 },
					},
				},
			},
			lsp = {
				override = {
					['vim.lsp.util.convert_input_to_markdown_lines'] = true,
					['vim.lsp.util.stylize_markdown'] = true,
					['cmp.entry.get_documentation'] = true,
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
			notify = {
				enabled = true, -- enables the Noice messages UI
			},
			message = {
				true,
			},
			cmdline = {
				view = 'cmdline_popup',
			},
		},
	}, ]]
	{
		'folke/zen-mode.nvim',
		opts = {},
		cmd = { 'ZenMode' },
	},
	{
		'michaelrommel/nvim-silicon',
		cmd = 'Silicon',
		opts = {
			disable_defaults = true,
			to_clipboard = true,
		},
		keys = {
			{
				'<leader>sc',
				function()
					require('nvim-silicon').clip()
				end,
				desc = 'Copy code screenshot to clipboard',
			},
		},
	},
}
