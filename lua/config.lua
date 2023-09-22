local set = vim.o
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
set.autoindent = true
set.timeoutlen = 200
set.tabstop = 4
set.shiftwidth = 4
set.mouse = ""
set.backspace = "indent,eol,start"
set.cursorline = true
set.ttyfast = true
set.number = true
set.incsearch = true
set.clipboard = 'unnamedplus'
set.splitkeep = 'screen'
set.signcolumn = "yes"
set.lazyredraw = true

--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

vim.g.smartindent = 1
set.conceallevel = 2

vim.g.maplocalleader = ","
set.fillchars = "vert: ,eob: "
