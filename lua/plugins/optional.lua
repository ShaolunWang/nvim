if vim.g.neovide then
	vim.o.guifont = 'BlexMono Nerd Font Mono:h10'
	vim.g.neovide_cursor_animation_length = 0
	vim.fn.setcellwidths({ { 0x2002, 0x2002, 2 } })
	vim.g.neovide_cursor_animate_command_line = false
end
local function _1_()
	return vim.cmd('\9       let g:cpp_attributes_highlight = 1\n\9       let g:cpp_member_highlight = 1\n\9     ')
end
local function _2_()
	vim.g.gutentags_generate_on_new = true
	vim.g.gutentags_generate_on_missing = true
	vim.g.gutentags_generate_on_write = true
	vim.g.gutentags_generate_on_empty_buffer = true
	vim.g.gutentags_define_advanced_commands = true
	vim.g.gutentags_add_default_project_roots = false
	vim.g.gutentags_modules = { 'cscope_maps' }
	vim.g.gutentags_cscope_build_inverted_index_maps = 1
	vim.g.gutentags_file_list_command = 'fd -e cpp -e h'
	vim.g.gutentags_project_root = { '.root' }
	return nil
end
local function _3_()
	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_cursor_animate_in_insert_mode = false
	vim.g.neovide_cursor_trail_size = 0
	require('cscope_maps').setup({
		cscope = {
			db_build_cmd_args = { '-bqkv', '-i', 'cscope.files' },
			exec = 'gtags-cscope',
			picker = 'fzf-lua',
			skip_picker_for_single_result = false,
		},
	})
	--	vim.cmd(
	--		"     function FormatBuffer()\n       if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))\n         let cursor_pos = getpos('.')\n         :%!clang-format\n         call setpos('.', cursor_pos)\n       endif\n     endfunction\n     \n     autocmd BufWritePre *.h,*.hpp,*.c,*.cpp,*.vert,*.frag :call FormatBuffer()\n  "
	--	)
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
	{ 'bfrg/vim-cpp-modern', config = _1_, ft = { 'c', 'cpp', 'h', 'hpp' } },
	{
		'dhananjaylatkar/cscope_maps.nvim',
		config = _3_,
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		ft = { 'cpp', 'h', 'hpp' },
	},
}
