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

local M = {}
M.plugins = {
	{ 'dhananjaylatkar/cscope_maps.nvim', opt = true },
	{ 'folke/twilight.nvim',              opt = true },
}
function M.load()
	require('lze').load({
		{
			'cscope_maps.nvim',
			after = cscope_config,
			ft = { 'cpp', 'h', 'hpp', 'c' },
		},
		{
			'twilight.nvim',
			after = function()
				require('twilight').setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
			cmd = { 'Twilight' },
		},

	})
end

return M
