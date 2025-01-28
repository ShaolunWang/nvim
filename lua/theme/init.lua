--vim.o.showtabline = 2
vim.g.termguicolors = true
vim.cmd('colorscheme onehalfdark')

local ts_extra_highlights = {
	['@text.strong'] = { bold = true },
	['@text.emphasis'] = { italic = true },
	['@text.title'] = { link = Function },
	['@text.literal'] = { link = '@parameters' },
	['@text.quote'] = { link = String },
	['@text.math'] = { link = Constant },
	['@text.environment'] = { link = Keyword },
	['@text.environment.name'] = { link = String },
	['@text.note'] = { bold = true, italic = true },
	['@text.warning'] = { link = WarningMsg, bold = true },
	['@text.danger'] = { link = ErrorMsg, bold = true },
	['@text.diff.add'] = { link = DiffAdd },
	['@text.diff.delete'] = { fg = DiffDelete },
}
for group, color in pairs(ts_extra_highlights) do
	vim.api.nvim_set_hl(0, group, color)
end

--require('theme.ui').override_ui_input()
--require('theme.ui').override_ui_select()

local function hl(highlight, fg, bg, link)
	if fg == nil then
		fg = 'none'
	end
	if bg == nil then
		bg = 'none'
	end
	vim.api.nvim_set_hl(0, highlight, { fg = fg, bg = bg, link = link })
	if link ~= nil then
		vim.api.nvim_set_hl(0, highlight, { link = link })
	end
end

local colors = {
	fg = '#BBB6B6',
	bg = '#1F1F1F',
	black = '#151515',
	darkgrey = '#2E2E2E',
	grey = '#424242',
	darkwhite = '#E8E3E3',
	white = '#E8E3E3',
	red = '#B66467',
	yellow = '#D9BC8C',
	green = '#8C977D',
	teal = '#8AA6A2',
	blue = '#8DA3B9',
	purple = '#A988B0',
	ash = '#BBB6B6',
}
-- vim.api.nvim_set_hl(0, 'FzfLuaBorder', { link = 'Directory' })
-- vim.api.nvim_set_hl(0, 'FzfLuaTitle', { link = 'Float' })
-- vim.api.nvim_set_hl(0, 'FzfLuaCursor', { link = 'Float' })
-- vim.api.nvim_set_hl(0, 'FzfLuaCursorLine', { link = 'Float' })
-- vim.api.nvim_set_hl(0, 'FzfLuaCursorLineNr', { link = 'Float' })
-- vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { fg = colors.darkwhite, bg = bg, link = link })
-- vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = colors.darkwhite, bg = bg, link = link })
vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = colors.darkwhite, bg = bg, link = link })
vim.api.nvim_set_hl(0, 'MiniCursorword', { underline = true })
vim.api.nvim_set_hl(0, 'MiniCursorwordCurrent', { underline = true })

--require('theme.tabby')
require('theme.line')
require('theme.ui')
