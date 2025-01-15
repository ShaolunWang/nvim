return {
	{
		'nanotee/zoxide.vim',
		--		dependencies = { 'ibhagwan/fzf-lua' },
		config = function()
			vim.g.zoxide_use_select = 1
		end,
		cmd = { 'Z', 'LZ', 'Zi', 'Tz', 'Lzi', 'Tzi' },
	},
}
