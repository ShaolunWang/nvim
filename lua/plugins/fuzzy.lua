local function get_clients(opts)
	local ret = {} ---@type vim.lsp.Client[]
	if vim.lsp.get_clients then
		ret = vim.lsp.get_clients(opts)
	else
		---@diagnostic disable-next-line: deprecated
		ret = vim.lsp.get_active_clients(opts)
		if opts and opts.method then
			---@param client vim.lsp.Client
			ret = vim.tbl_filter(function(client)
				return client.supports_method(opts.method, { bufnr = opts.bufnr })
			end, ret)
		end
	end
	return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end
local fzf = {
	'ibhagwan/fzf-lua',
	-- optional for icon support
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = function(_, opts)
		local config = require('fzf-lua.config')
		local actions = require('fzf-lua.actions')

		-- Quickfix
		config.defaults.keymap.fzf['ctrl-q'] = 'select-all+accept'
		config.defaults.keymap.fzf['ctrl-u'] = 'half-page-up'
		config.defaults.keymap.fzf['ctrl-d'] = 'half-page-down'
		config.defaults.keymap.fzf['ctrl-x'] = 'jump'
		config.defaults.keymap.fzf['ctrl-f'] = 'preview-page-down'
		config.defaults.keymap.fzf['ctrl-b'] = 'preview-page-up'
		config.defaults.keymap.builtin['<c-f>'] = 'preview-page-down'
		config.defaults.keymap.builtin['<c-b>'] = 'preview-page-up'

		-- Trouble
		-- if LazyVim.has('trouble.nvim') then
		-- 	config.defaults.actions.files['ctrl-t'] = require('trouble.sources.fzf').actions.open
		-- end

		-- Toggle root dir / cwd
		--[[ 			config.defaults.actions.files['ctrl-r'] = function(_, ctx)
				local o = vim.deepcopy(ctx.__call_opts)
				o.root = o.root == false
				o.cwd = nil
				o.buf = ctx.__CTX.bufnr
				LazyVim.pick.open(ctx.__INFO.cmd, o)
			end ]]
		config.defaults.actions.files['alt-c'] = config.defaults.actions.files['ctrl-r']
		--			config.set_action_helpstr(config.defaults.actions.files['ctrl-r'], 'toggle-root-dir')

		-- use the same prompt for all
		local defaults = require('fzf-lua.profiles.default-title')
		local function fix(t)
			t.prompt = t.prompt ~= nil and ' ' or nil
			for _, v in pairs(t) do
				if type(v) == 'table' then
					fix(v)
				end
			end
		end
		fix(defaults)

		local img_previewer ---@type string[]?
		for _, v in ipairs({
			{ cmd = 'ueberzug', args = {} },
			{ cmd = 'chafa', args = { '{file}', '--format=symbols' } },
			{ cmd = 'viu', args = { '-b' } },
		}) do
			if vim.fn.executable(v.cmd) == 1 then
				img_previewer = vim.list_extend({ v.cmd }, v.args)
				break
			end
		end

		return vim.tbl_deep_extend('force', defaults, {
			fzf_colors = true,
			fzf_opts = {
				['--no-scrollbar'] = true,
				['--highlight-line'] = true,
				['--info'] = 'inline-right',
				['--ansi'] = true,
			},
			defaults = {
				formatter = 'path.filename_first',
			},
			previewers = {
				builtin = {
					extensions = {
						['png'] = img_previewer,
						['jpg'] = img_previewer,
						['jpeg'] = img_previewer,
						['gif'] = img_previewer,
						['webp'] = img_previewer,
					},
					ueberzug_scaler = 'fit_contain',
				},
			},
			-- Custom LazyVim option to configure vim.ui.select
			ui_select = function(fzf_opts, items)
				return vim.tbl_deep_extend('force', fzf_opts, {
					prompt = ' ',
					winopts = {
						title = ' ' .. vim.trim((fzf_opts.prompt or 'Select'):gsub('%s*:%s*$', '')) .. ' ',
						title_pos = 'center',
					},
				}, fzf_opts.kind == 'codeaction' and {
					winopts = {
						layout = 'vertical',
						-- height is number of items minus 15 lines for the preview, with a max of 80% screen height
						height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
						width = 0.5,
						preview = not vim.tbl_isempty(get_clients({ bufnr = 0, name = 'vtsls' })) and {
							layout = 'vertical',
							vertical = 'down:15,border-top',
							hidden = 'hidden',
						} or {
							layout = 'vertical',
							vertical = 'down:15,border-top',
						},
					},
				} or {
					winopts = {
						width = 0.5,
						-- height is number of items, with a max of 80% screen height
						height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
					},
				})
			end,
			winopts = {
				width = 0.8,
				height = 0.8,
				row = 0.5,
				col = 0.5,
				preview = {
					scrollchars = { '┃', '' },
				},
			},
			files = {
				prompt = 'Files❯ ',
				cwd_prompt = false,
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
			grep = {},
			lsp = {
				symbols = {
					symbol_hl = function(s)
						return 'TroubleIcon' .. s
					end,
					symbol_fmt = function(s)
						return s:lower() .. '\t'
					end,
					child_prefix = false,
				},
				code_actions = {
					previewer = vim.fn.executable('delta') == 1 and 'codeaction_native' or nil,
				},
			},
			oldfiles = {
				previewer = false,
			},
		})
	end,
	config = function(_, opts)
		require('fzf-lua').setup(opts)
		--			require('fzf-lua').register_ui_select(opts.ui_select or nil)
	end,
	-- 		config = function()
	-- 			require('fzf-lua').setup({
	-- 				defaults = { formatter = 'path.filename_first' },
	-- 				hls = { preview_border = 'FzfLuaBorder' },
	-- 				winopts = {
	-- 					fullscreen = false,
	--
	-- 					border = 'single',
	-- 					preview = {
	-- 						delay = 0,
	-- 						default = 'bat_native',
	-- 						layout = 'flex',
	-- 						border = 'border',
	-- 						scrollbar = false,
	-- 						scrollchars = '', -- scrollbar chars ({ <full>, <empty> }
	-- 					},
	-- 				},
	-- 				fzf_opts = {
	-- 					['--highlight-line'] = true,
	-- 					['--info'] = 'inline-right',
	-- 					['--ansi'] = true,
	-- 				},
	-- 				fzf_colors = {
	-- 					['fg'] = { 'fg', 'CursorLine' },
	-- 					['bg'] = { 'bg', 'Normal' },
	-- 					['hl'] = { 'fg', 'Redfg' },
	-- 					['fg+'] = { 'fg', 'Blackfg' },
	-- 					['bg+'] = { 'bg', 'Greenbg' },
	-- 					['hl+'] = { 'fg', 'Redfg' },
	-- 					['info'] = { 'fg', 'PreProc' },
	-- 					['prompt'] = { 'fg', 'Conditional' },
	-- 					['pointer'] = { 'fg', 'Execption' },
	-- 					['marker'] = { 'fg', 'Keyword' },
	-- 					['spinner'] = { 'fg', 'Float' },
	-- 					['header'] = { 'fg', 'Comment' },
	-- 					['gutter'] = { 'bg', 'Normal' },
	-- 				},
	-- 				files = {
	-- 					prompt = 'Files❯ ',
	-- 					cwd_prompt_shorten_len = 10, -- shorten prompt beyond this length
	-- 					git_icons = true,
	-- 					file_icons = true,
	-- 					color_icons = true,
	-- 					-- can also be set to 'fzf-tmux'
	-- 					winopts = {
	-- 						height = 0.5, -- window height
	-- 						width = 0.5, -- window width
	-- 						row = 0.35, -- window row position (0=top, 1=bottom)
	-- 						col = 0.50, -- window col position (0=left, 1=right)
	-- 						--					previewer = 'bat',
	-- 					},
	-- 					previewer = false,
	-- 					fd_opts = '--color=never --type f --hidden --follow --exclude .git',
	-- 				},
	-- 				buffers = {
	-- 					prompt = 'Buffers❯ ',
	-- 					file_icons = true, -- show file icons?
	-- 					color_icons = true, -- colorize file|git icons
	-- 					sort_lastused = true, -- sort buffers() by last used
	-- 					show_unloaded = true, -- show unloaded buffers
	-- 					cwd_only = false, -- buffers for the cwd only
	-- 					cwd = nil, -- buffers list for a given dir
	-- 					previewer = false,
	-- 					winopts = {
	-- 						height = 0.35, -- window height
	-- 						width = 0.30, -- window width
	-- 						row = 0.35, -- window row position (0=top, 1=bottom)
	-- 						col = 0.50, -- window col position (0=left, 1=right)
	-- 						--					previewer = 'bat',
	-- 					},
	-- 				},
	-- 			})
	--
	-- 			local utils = require('fzf-lua.utils')
	-- 			require('fzf-lua').register_ui_select()
	-- --[[ 			require('fzf-lua').register_ui_select(function(ui_opts, items)
	-- 				-- Auto-height
	-- 				local min_h, max_h = 0.15, 0.70
	-- 				local h = (#items + 2) / vim.o.lines
	-- 				if h < min_h then
	-- 					h = min_h
	-- 				elseif h > max_h then
	-- 					h = max_h
	-- 				end
	--
	-- 				local min_w, max_w = 0.05, 0.70
	-- 				local longest = 0
	-- 				for i, e in ipairs(items) do
	-- 					local format_entry = ui_opts.format_item and ui_opts.format_item(e) or tostring(e)
	-- 					local length = tostring(format_entry):len()
	-- 					if length > longest then
	-- 						longest = length
	-- 					end
	-- 				end
	-- 				local w = (longest + 9) / vim.o.columns
	-- 				if w < min_w then
	-- 					w = min_w
	-- 				elseif w > max_w then
	-- 					w = max_w
	-- 				end
	-- 				-- end
	-- 				return {
	-- 					winopts = {
	-- 						height = h,
	-- 						width = w,
	-- 						row = 0.5,
	-- 						col = 0.5,
	-- 					},
	-- 					fzf_opts = {
	-- 						['--layout'] = 'reverse-list',
	-- 						['--info'] = 'hidden',
	-- 					},
	-- 				}
	-- 			end) ]]
	-- 		end,

	keys = { '<leader>' },
	cmd = { 'FzfLua' },
}
return {
	{
		'nanotee/zoxide.vim',
		--		dependencies = { 'ibhagwan/fzf-lua' },
		config = function()
			vim.g.zoxide_use_select = 1
		end,
		cmd = { 'Z', 'LZ', 'Zi', 'Tz', 'Lzi', 'Tzi' },
	},
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'natecraddock/telescope-zf-native.nvim',
			'nvim-telescope/telescope-ui-select.nvim',
		},
		opts = {
			-- set default picker theme to ivy for all pickers
		},
		config = function()
			require('telescope').setup({
				extensions = {
					['ui-select'] = {},
				},
				defaults = require('telescope.themes').get_ivy({
					ripgrep_arguments = {
						'rg',
						'--color=never',
						'--no-heading',
						'--with-filename',
						'--line-number',
						'--column',
						'--smart-case',
						'--no-require-git',
					},

					layout_config = { height = 0.30 },
					prompt_prefix = '  ',
					selection_caret = '❯ ',
					entry_prefix = '  ',
					initial_mode = 'insert',
					selection_strategy = 'reset',
					preview = {
						hide_on_startup = true, -- hide previewer when picker starts
					},
				}),
				pickers = {
					find_files = {
						find_command = { 'fd', '--type', 'f', '--color', 'never', '--no-require-git' },
					},
				},
			})
			require('telescope').load_extension('zf-native')
			require('telescope').load_extension('scope')
			require('telescope').load_extension('ui-select')
		end,
		keys = {'<leader>f'}
	},
}
