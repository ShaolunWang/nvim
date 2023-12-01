local set = vim.o
set.autoindent = true
set.tabstop = 4
set.shiftwidth = 4
set.mouse = ''
set.backspace = 'indent,eol,start'
set.cursorline = true
set.ttyfast = true
set.number = true
set.incsearch = true
set.clipboard = 'unnamedplus'
set.splitkeep = 'screen'
set.signcolumn = 'yes'
set.lazyredraw = true
set.termguicolors = true

vim.g.smartindent = 1
set.conceallevel = 2
-- Neovim config for the links to show properly
vim.opt.conceallevel = 2
vim.opt.concealcursor = 'nc'

vim.g.maplocalleader = ','
set.fillchars = 'vert: ,eob: '

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = true,
})
local signs = { Error = '! ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
	local hl = 'DiagnosticSign' .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

if vim.fn.executable('rg') == 1 then
	vim.opt.grepprg = 'rg --no-heading --vimgrep --smart-case --hidden --glob=!.git/'
	vim.opt.grepformat = '%f:%l:%c:%m'
end

--command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
--command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)
-- grep
vim.cmd([[
  noreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent Grep'  : 'grep'
  cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep'
  augroup init_quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l* lwindow
  augroup END
]])
