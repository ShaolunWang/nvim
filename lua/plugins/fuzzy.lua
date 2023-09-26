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
			require('fzf-lua').register_ui_select()
--[[ 			require('fzf-lua').register_ui_select(function(ui_opts, items)
				-- Auto-height
				local min_h, max_h = 0.15, 0.70
				local h = (#items + 2) / vim.o.lines
				if h < min_h then
					h = min_h
				elseif h > max_h then
					h = max_h
				end

				local min_w, max_w = 0.05, 0.70
				local longest = 0
				for i, e in ipairs(items) do
					local format_entry = ui_opts.format_item and ui_opts.format_item(e) or tostring(e)
					local length = tostring(format_entry):len()
					if length > longest then
						longest = length
					end
				end
				local w = (longest + 9) / vim.o.columns
				if w < min_w then
					w = min_w
				elseif w > max_w then
					w = max_w
				end
				-- end
				return {
					winopts = {
						height = h,
						width = w,
						row = 0.5,
						col = 0.5,
					},
					fzf_opts = {
						['--layout'] = 'reverse-list',
						['--info'] = 'hidden',
					},
				}
			end) ]]
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
