vim.g.showtabline = 2
vim.g.termguicolors = true
vim.cmd('colorscheme carbonfox')
require('theme.tabby')
require('theme.feline')
-- leap highlight
vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = '#777777' })

-- bqf

vim.cmd([[
    hi BqfPreviewBorder guifg=#3e8e2d ctermfg=71
    hi BqfPreviewTitle guifg=#3e8e2d ctermfg=71
    hi BqfPreviewThumb guibg=#3e8e2d ctermbg=71
    hi link BqfPreviewRange Search
]])
