local conditions = require('heirline.conditions')
local utils = require('heirline.utils')
--local TabLine = require("theme.tabline").TabLine
local M = {}
local Align = { provider = '%=' }
--Heirline: utils.pick_child_on_condition() is deprecated, please use the fallthrough field instead. To retain the same functionality, replace `init = utils.pick_child_on_condition()` with `fallthrough = false`

local Separator = { provider = ' ' }
local Space = { provider = ' ' }

--local everforest = require('everforest')
--M.colors = require('everforest.colours').generate_palette(everforest.config, vim.o.background)
--require('heirline').load_colors(M.colors)
require('heirline').load_colors({
	blue = '#005078',
	cyan = '#007676',
	green = '#015825',
	grey1 = '#0a0b10',
	grey2 = '#1c1d23',
	grey3 = '#2c2e33',
	grey4 = '#4f5258',
	magenta = '#4c0049',
	red = '#5e0009',
	yellow = '#6e5600',

	--[[ blue    = "#9fd8ff"
cyan    = "#83efef"
green   = "#aaedb7"
grey1   = "#ebeef5"
grey2   = "#d7dae1"
grey3   = "#c4c6cd"
grey4   = "#9b9ea4"
magenta = "#ffc3fa"
red     = "#ffbcb5"
yellow  = "#f4d88c" ]]
})
-- Instead of `everforest.config`, you can add in your own config here by using
-- `everforest.setup({ show_eob = false)` before you generate the palette.
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
	-- We can now access the value of mode() that, by now, would have been
	-- computed by `init()` and use it to index our strings dictionary.
	-- note how `static` fields become just regular attributes once the
	-- component is instantiated.
	-- To be extra meticulous, we can also add some vim statusline syntax to
	-- control the padding and make sure our string is always at least 2
	-- characters long. Plus a nice Icon.
	provider = function(self)
		return '%2(' .. self.mode_names[self.mode] .. '%)'
	end,
	-- Same goes for the highlight. Now the foreground will change according to the current mode.
	hl = function(self)
		local mode = self.mode:sub(1, 1) -- get only the first mode character
		return { fg = self.mode_colors[mode], bold = true }
	end,
	-- Re-evaluate the component only on ModeChanged event!
	-- This is not required in any way, but it's there, and it's a small
	-- performance improvement.
	update = 'ModeChanged',
}

local FileName = {
	provider = function(self)
		-- first, trim the pattern relative to the current directory. For other
		-- options, see :h filename-modifers
		local filename = vim.fn.fnamemodify(self.filename, ':.')
		if filename == '' then
			return '[No Name]'
		end
		-- now, if the filename would occupy more than 1/4th of the available
		-- space, we trim the file path to its initials
		-- See Flexible Components section below for dynamic truncation
		if not conditions.width_percent_below(#filename, 0.25) then
			filename = vim.fn.pathshorten(filename)
		end
		return filename
	end,
	hl = { fg = utils.get_highlight('Directory').fg },
}
local HelpFileName = {
	condition = function()
		return vim.bo.filetype == 'help'
	end,
	provider = function()
		local filename = vim.api.nvim_buf_get_name(0)
		return vim.fn.fnamemodify(filename, ':t')
	end,
	hl = { fg = 'blue' },
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
		--        local icon =" "
		local cwd = vim.fn.expand('%')
		cwd = vim.fn.fnamemodify(cwd, ':~')
		--        return icon .. cwd  --.. trail
		return cwd
	end,
	hl = {
		fg = utils.get_highlight('Directory').bg,
	},
}

local DefaultStatusline = {
	ViMode,
	Space,
	Separator,
	FileFlags,
	Space,
	WorkDir,
	Space,
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
	SpecialStatusline,
	TerminalStatusline,
	InactiveStatusline,
	DefaultStatusline,
	fallthrough = false,
}

require('heirline').setup({ statusline = StatusLines })
return M
