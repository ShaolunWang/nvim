local branch = ''
if vim.loop.os_uname().sysname ~= 'Windows_NT' then
	fzf_branch = 'main'
else
	fzf_branch = 'windows'
end
return {
	{
		'ibhagwan/fzf-lua',
		-- optional for icon support
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		branch = fzf_branch,
		config = function()
			require('fzf-lua').setup({
				hls = { preview_border = 'FzfLuaBorder' },
				winopts = {
					fullscreen = false,
					border = 'single',
					preview = {
						delay = 0,
						default = 'bat_native',
						layout = 'flex',
						border = 'border',
						scrollbar = false,
						scrollchars = '', -- scrollbar chars ({ <full>, <empty> }
					},
				},
				fzf_colors = {
					['fg'] = { 'fg', 'CursorLine' },
					['bg'] = { 'bg', 'Normal' },
					['hl'] = { 'fg', 'Redfg' },
					['fg+'] = { 'fg', 'Blackfg' },
					['bg+'] = { 'bg', 'Greenbg' },
					['hl+'] = { 'fg', 'Redfg' },
					['info'] = { 'fg', 'PreProc' },
					['prompt'] = { 'fg', 'Conditional' },
					['pointer'] = { 'fg', 'Execption' },
					['marker'] = { 'fg', 'Keyword' },
					['spinner'] = { 'fg', 'Float' },
					['header'] = { 'fg', 'Comment' },
					['gutter'] = { 'bg', 'Normal' },
				},
				files = {
					prompt = 'Files❯ ',
					git_icons = true,
					file_icons = true,
					color_icons = true,
					previewer = 'bat',
					fd_opts = '--color=never --type f --hidden --follow --exclude .git',
				},
			})
			require('fzf-lua').register_ui_select()
		end,
		keys = { '<leader>' },
		cmd = { 'FzfLua' },
	},
}
