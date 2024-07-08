return {
	{
		'ibhagwan/fzf-lua',
		-- optional for icon support
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('fzf-lua').setup({
				defaults = { formatter = 'path.filename_first' },
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
				fzf_opts = {
					['--highlight-line'] = true,
					['--info'] = 'inline-right',
					['--ansi'] = true,
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
					-- can also be set to 'fzf-tmux'
					winopts = {
						height = 0.5, -- window height
						width = 0.5, -- window width
						row = 0.35, -- window row position (0=top, 1=bottom)
						col = 0.50, -- window col position (0=left, 1=right)
						--					previewer = 'bat',
					},
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
					winopts = {
						height = 0.35, -- window height
						width = 0.30, -- window width
						row = 0.35, -- window row position (0=top, 1=bottom)
						col = 0.50, -- window col position (0=left, 1=right)
						--					previewer = 'bat',
					},
				},
			})
			local utils = require('fzf-lua.utils')
		end,
		keys = { '<leader>' },
		cmd = { 'FzfLua' },
	},
	{
		'nanotee/zoxide.vim',
		dependencies = { 'ibhagwan/fzf-lua' },
		config = function()
			vim.g.zoxide_use_select = 1
		end,
		cmd = { 'Z', 'LZ', 'Zi', 'Tz', 'Lzi', 'Tzi' },
	},
}
