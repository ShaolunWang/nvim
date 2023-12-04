vim.g.showtabline = 2
vim.g.termguicolors = true
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

-- leap highlight
vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = '#777777' })
-- bqf
require('theme.tabby')
require('theme.line')

vim.cmd([[
    hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
    hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
    hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
    hi link BqfPreviewRange Search
]])
local starter = require('mini.starter')
local my_items = starter.setup({
	items = {
		starter.sections.sessions(5, true),
		{ name = 'Open file manager', action = 'Oil', section = 'File' },
		{ name = 'fzf', action = 'FzfLua', section = 'Fuzzy' },
	},
	footer = '',
})
