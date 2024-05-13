return {
	{
		'ibhagwan/fzf-lua',
		-- optional for icon support
		dependencies = { 'nvim-tree/nvim-web-devicons' },
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
					cwd_prompt_shorten_len = 10, -- shorten prompt beyond this length
					git_icons = true,
					file_icons = true,
					color_icons = true,
					--					previewer = 'bat',
					previewer = false,
					fd_opts = '--color=never --type f --hidden --follow --exclude .git',
				},
				buffers = {
					prompt = 'Buffers❯ ',
					file_icons = true, -- show file icons?
					color_icons = true, -- colorize file|git icons
					sort_lastused = true, -- sort buffers() by last used
					show_unloaded = true, -- show unloaded buffers
					cwd_only = false, -- buffers for the cwd only
					cwd = nil, -- buffers list for a given dir
					previewer = false,
				},
			})
			--			require('fzf-lua').register_ui_select()
		end,
		keys = { '<leader>' },
		cmd = { 'FzfLua' },
	},
}
