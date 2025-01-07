local conditions = require('heirline.conditions')
local utils = require('heirline.utils')
--local TabLine = require("theme.tabline").TabLine
local M = {}
local dropbar = require('dropbar.utils')
local Align = { provider = '%=' }
--Heirline: utils.pick_child_on_condition() is deprecated, please use the fallthrough field instead. To retain the same functionality, replace `init = utils.pick_child_on_condition()` with `fallthrough = false`
--
local left_slant = ''
--local right_slant = ''
--
local right_slant = ''
local function empty(s)
	return type(s) ~= 'string' or string.len(s) == 0
end

local colors = {
	bright_bg = utils.get_highlight('Folded').bg,
	bright_fg = utils.get_highlight('Folded').fg,
	red = utils.get_highlight('DiagnosticError').fg,
	dark_red = utils.get_highlight('DiffDelete').bg,
	green = utils.get_highlight('String').fg,
	blue = utils.get_highlight('Function').fg,
	gray = utils.get_highlight('NonText').fg,
	orange = utils.get_highlight('Constant').fg,
	purple = utils.get_highlight('Statement').fg,
	cyan = utils.get_highlight('Special').fg,
	--diag_warn = utils.get_highlight('DiagnosticWarn').fg,
	--	diag_error = utils.get_highlight('DiagnosticError').fg,
	--	diag_hint = utils.get_highlight('DiagnosticHint').fg,
	--diag_info = utils.get_highlight('DiagnosticInfo').fg,
	--git_del = utils.get_highlight('diffDeleted').fg,
	--git_add = utils.get_highlight('diffAdded').fg,
	--git_change = utils.get_highlight('diffChanged').fg,
}
require('heirline').load_colors(colors)
-- Instead of `everforest.config`, you can add in your own config here by using
-- `everforest.setup({ show_eob = false)` before you generate the palette.
local Separator = {
	provider = ' ',
	hl = { fg = 'fg', bg = 'bg' },
}
local Space = {
	provider = ' ',
	hl = { fg = 'fg', bg = 'bg' },
}
local ViMode = {
	-- get vim current mode, this information will be required by the provider
	-- and the highlight functions, so we compute it only once per component
	-- evaluation and store it as a component attribute
	init = function(self)
		self.mode = vim.fn.mode(1) -- :h mode()

		-- execute this only once, this is required if you want the ViMode
		-- component to be updated on operator pending mode
		if not self.once then
			vim.api.nvim_create_autocmd('ModeChanged', { command = 'redrawstatus' })
			self.once = true
		end
	end,
	-- Now we define some dictionaries to map the output of mode() to the
	-- corresponding string and color. We can put these into `static` to compute
	-- them at initialisation time.
	-- We can now access the value of mode() that, by now, would have been
	-- computed by `init()` and use it to index our strings dictionary.
	-- note how `static` fields become just regular attributes once the
	-- component is instantiated.
	-- To be extra meticulous, we can also add some vim statusline syntax to
	-- control the padding and make sure our string is always at least 2
	-- characters long. Plus a nice Icon.
	static = {
		mode_names = {
			-- change the strings if you like it vvvvverbose!
			n = 'N',
			no = 'N?',
			nov = 'N?',
			noV = 'N?',
			['no\22'] = 'N?',
			niI = 'Ni',
			niR = 'Nr',
			niV = 'Nv',
			nt = 'Nt',
			v = 'V',
			vs = 'Vs',
			V = 'V_',
			Vs = 'Vs',
			['\22'] = '^V',
			['\22s'] = '^V',
			s = 'S',
			S = 'S_',
			['\19'] = '^S',
			i = 'I',
			ic = 'Ic',
			ix = 'Ix',
			R = 'R',
			Rc = 'Rc',
			Rx = 'Rx',
			Rv = 'Rv',
			Rvc = 'Rv',
			Rvx = 'Rv',
			c = 'C',
			cv = 'Ex',
			r = '...',
			rm = 'M',
			['r?'] = '?',
			['!'] = '!',
			t = 'T',
		},
		mode_colors = {
			n = 'green',
			i = 'green',
			v = 'cyan',
			V = 'cyan',
			['\22'] = 'cyan',
			c = 'orange',
			s = 'purple',
			S = 'purple',
			['\19'] = 'purple',
			R = 'orange',
			r = 'orange',
			['!'] = 'red',
			t = 'red',
		},
	},
	provider = function(self)
		return '%2(' .. self.mode_names[vim.fn.mode(1)] .. '%)'
	end,
	hl = function(self)
		local color = self:mode_color() -- here!
		return { fg = color, bold = true }
	end,
	-- Re-evaluate the component only on ModeChanged event!
	-- This is not required in any way, but it's there, and it's a small
	-- performance improvement.
	update = 'ModeChanged',
}
local FileName = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
	hl = { fg = 'bg', bg = 'fg' },

	-- file name
	{
		provider = left_slant,
		hl = { fg = 'fg', bg = 'bg' },
	},
	{
		provider = ' %t ',
	},
	{
		provider = function(self)
			self.filename = vim.api.nvim_buf_get_name(0)

			if empty(self.filename) then
				return ''
			end
			local modifiable = vim.api.nvim_get_option_value('modifiable', { buf = 0 })
			local readonly = vim.api.nvim_get_option_value('readonly', { buf = 0 })
			if not modifiable or readonly then
				return '[!] '
			end
			local modified = vim.api.nvim_get_option_value('modified', { buf = 0 })
			if modified then
				return '[+] '
			end
			return ''
		end,
		update = { 'OptionSet', 'BufWritePost', 'BufEnter', 'WinEnter' },
	},
	-- file size
	{
		provider = right_slant,
		hl = { fg = 'fg', bg = 'bg' },
	},
}
local FileFlags = {
	{
		condition = function()
			return vim.bo.modified
		end,
		provider = '[+]',
		hl = { fg = 'green' },
	},
	{
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = '',
		hl = { fg = 'orange' },
	},
}

-- (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " " ..

local WorkDir = {
	provider = function()
		local icon = ' '
		local cwd = vim.fn.expand('%')
		cwd = vim.fn.fnamemodify(cwd, ':~')
		--        return icon .. cwd  --.. trail
		return cwd
	end,
	hl = {
		fg = utils.get_highlight('Directory').bg,
	},
}
-- We're getting minimalists here!
local Ruler = {
	-- %l = current line number
	-- %L = number of lines in the buffer
	-- %c = column number
	-- %P = percentage through file of displayed window
	{
		provider = left_slant,
		hl = { fg = 'bg', bg = 'bg' },
	},
	{

		provider = '%7(%l/%3L%):%2c %P',
		hl = { fg = 'fg', bg = 'bg' },
	},
}
-- I take no credits for this! :lion:
local ScrollBar = {
	static = {
		sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
		-- Another variant, because the more choice the better.
		--sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
	},
	provider = function(self)
		local curr_line = vim.api.nvim_win_get_cursor(0)[1]
		local lines = vim.api.nvim_buf_line_count(0)
		local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
		return string.rep(self.sbar[i], 2)
	end,
	hl = { fg = 'blue', bg = colors.bright_bg },
}

-- Awesome plugin

-- Full nerd (with icon colors and clickable elements)!
-- works in multi window, but does not support flexible components (yet ...)
--[[ local Navic = {
	condition = function()
		--		return require('nvim-navic').is_available()
		return require('lazy.core.config').plugins['nvim-lspconfig']._.loaded
	end,
	static = {
		-- create a type highlight map
		type_hl = {
			File = 'Directory',
			Module = '@include',
			Namespace = '@namespace',
			Package = '@include',
			Class = '@structure',
			Method = '@method',
			Property = '@property',
			Field = '@field',
			Constructor = '@constructor',
			Enum = '@field',
			Interface = '@type',
			Function = '@function',
			Variable = '@variable',
			Constant = '@constant',
			String = '@string',
			Number = '@number',
			Boolean = '@boolean',
			Array = '@field',
			Object = '@type',
			Key = '@keyword',
			Null = '@comment',
			EnumMember = '@field',
			Struct = '@structure',
			Event = '@keyword',
			Operator = '@operator',
			TypeParameter = '@type',
		},
		-- bit operation dark magic, see below...
		enc = function(line, col, winnr)
			return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
		end,
		-- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
		dec = function(c)
			local line = bit.rshift(c, 16)
			local col = bit.band(bit.rshift(c, 6), 1023)
			local winnr = bit.band(c, 63)
			return line, col, winnr
		end,
	},
	init = function(self)
		local data = require('nvim-navic').get_data() or {}
		local children = {}
		-- create a child for each level
		for i, d in ipairs(data) do
			-- encode line and column numbers into a single integer
			local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
			local child = {
				{
					provider = d.icon,
					hl = self.type_hl[d.type],
				},
				{
					-- escape `%`s (elixir) and buggy default separators
					provider = d.name:gsub('%%', '%%%%'):gsub('%s*->%s*', ''),
					-- highlight icon only or location name as well
					-- hl = self.type_hl[d.type],

					on_click = {
						-- pass the encoded position through minwid
						minwid = pos,
						callback = function(_, minwid)
							-- decode
							local line, col, winnr = self.dec(minwid)
							vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
						end,
						name = 'heirline_navic',
					},
				},
			}
			-- add a separator only if needed
			if #data > 1 and i < #data then
				table.insert(child, {
					provider = ' > ',
					hl = { fg = 'bright_fg' },
				})
			end
			table.insert(children, child)
		end
		-- instantiate the new child, overwriting the previous one
		self.child = self:new(children, 1)
	end,
	-- evaluate the children containing navic components
	provider = function(self)
		return self.child:eval()
	end,
	hl = { fg = 'gray' },
	update = 'CursorMoved',
} ]]
local Dropbar = {
	condition = function(self)
		self.data = vim.tbl_get(dropbar.bar.get() or {}, vim.api.nvim_get_current_buf(), vim.api.nvim_get_current_win())
		return self.data
	end,
	static = { dropbar_on_click_string = 'v:lua.dropbar.callbacks.buf%s.win%s.fn%s' },
	init = function(self)
		local components = self.data.components
		local children = {}
		for i, c in ipairs(components) do
			local child = {
				{
					hl = c.icon_hl,
					provider = c.icon:gsub('%%', '%%%%'),
				},
				{
					hl = c.name_hl,
					provider = c.name:gsub('%%', '%%%%'),
				},
				on_click = {
					callback = self.dropbar_on_click_string:format(self.data.buf, self.data.win, i),
					name = 'heirline_dropbar',
				},
			}
			if i < #components then
				local sep = self.data.separator
				table.insert(child, {
					provider = sep.icon,
					hl = sep.icon_hl,
					on_click = {
						callback = self.dropbar_on_click_string:format(self.data.buf, self.data.win, i + 1),
					},
				})
			end
			table.insert(children, child)
		end
		self.child = self:new(children, 1)
	end,
	provider = function(self)
		return self.child:eval()
	end,
}

local Winbars = {
	Dropbar,
	--	Navic,
}
-- cmdline

local SearchCount = {
	condition = function()
		return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
	end,
	init = function(self)
		local ok, search = pcall(vim.fn.searchcount)
		if ok and search.total then
			self.search = search
		end
	end,
	provider = function(self)
		local search = self.search
		return string.format('[%d/%d]', search.current, math.min(search.total, search.maxcount))
	end,
}
local MacroRec = {
	condition = function()
		return vim.fn.reg_recording() ~= '' and vim.o.cmdheight == 0
	end,
	provider = ' ',
	hl = { fg = 'orange', bold = true },
	utils.surround({ '[', ']' }, nil, {
		provider = function()
			return vim.fn.reg_recording()
		end,
		hl = { fg = 'green', bold = true },
	}),
	update = {
		'RecordingEnter',
		'RecordingLeave',
	},
}

vim.opt.showcmdloc = 'statusline'

local ShowCmd = {
	condition = function()
		return vim.o.cmdheight == 0
	end,
	provider = ':%3.5(%S%)',
}
ViMode = utils.surround({ '', '' }, 'None', { MacroRec, ViMode, Snippets, ShowCmd })

local DefaultStatusline = {
	ViMode,
	Space,
	FileName,
	ShowCmd,
	Separator,
	Align, -- .., .., align would put on the left
	Align,
	Ruler,
	Space,
	ScrollBar,
	Space, -- align, .. ,.. would put it on the right
}

local InactiveStatusline = {
	condition = function()
		return not conditions.is_active()
	end,
	Separator,
	FileName,
	Align,
}

local TerminalStatusline = {
	condition = function()
		return conditions.buffer_matches({ buftype = { 'terminal' } })
	end,
	-- Quickly add a condition to the ViMode to only show it when buffer is active!
	{ condition = conditions.is_active, ViMode, Separator },
	TerminalName,
	Align,
}

local SpecialStatusline = {
	condition = function()
		return conditions.buffer_matches({
			buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
			filetype = { '^git.*', 'fugitive' },
		})
	end,
	Separator,
	HelpFileName,
	Align,
}

local StatusLines = {
	static = {
		mode_color = function(self)
			local mode = conditions.is_active() and vim.fn.mode() or 'n'
			return self.mode_colors[mode]
		end,
	},

	SpecialStatusline,
	TerminalStatusline,
	InactiveStatusline,
	DefaultStatusline,
	fallthrough = true,
	hl = { fg = 'fg', bg = 'bg' },
}
--local ts_utils = require('nvim-treesitter.utils')
require('heirline').setup({
	statusline = StatusLines,
	--winbar = Winbars,
	--statuscolumn = {},
	opts = {
		-- if the callback returns true, the winbar will be disabled for that window
		-- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
		disable_winbar_cb = function(args)
			return conditions.buffer_matches({
				buftype = { 'nofile', 'prompt', 'help', 'quickfix', 'terminal' },
				filetype = { '^git.*', 'fugitive', 'Trouble', 'dashboard', 'oil' },
			}, args.buf)
		end,
	},
})

return M
