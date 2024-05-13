local set = vim.o
set.autoindent = true
set.tabstop = 4
set.laststatus = 3
set.scrolloff = 10
set.shiftwidth = 4
set.mouse = ''
set.cmdheight = 0
set.backspace = 'indent,eol,start'
set.cursorline = true
set.ttyfast = true
set.number = true
set.incsearch = true
set.clipboard = 'unnamedplus'
set.splitkeep = 'screen'
set.lazyredraw = true
set.termguicolors = true
set.foldcolumn = '1' -- '0' is not bad
set.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
set.foldlevelstart = 99
set.foldenable = true
set.ignorecase = true
set.smartcase = false
vim.g.smartindent = 1
vim.g.mapleader = ' '
set.conceallevel = 2
-- Neovim config for the links to show properly
set.conceallevel = 2
set.concealcursor = 'nc'

vim.g.maplocalleader = ','
set.fillchars =
	[[horiz:━,horizup:┻,horizdown:┳,vert:┃,vertleft:┫,vertright:┣,verthoriz:╋,foldopen:▼,foldclose:>,fold: ,eob: ]]

-- This works but don't abuse status column :)
--vim.o.statuscolumn = '%=%l%s%#FoldColumn#%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "▼ " : "> ") : "  " }%*'
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

-- grep
-- command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
--   vim.api.nvim_create_user_command("Grep", function(params)
-- Insert args at the '$*' in the grepprg
--
--[[ ]]

vim.cmd([[
  command! -bang -nargs=* -complete=file_in_path -bar Grep call asyncdo#run(
              \ <bang>0,
              \ { 'job': &grepprg, 'errorformat': &grepformat },
              \ <f-args>)
  command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

  noreabbrev  <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent Grep'  : 'grep'
  cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep'
  augroup init_quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l* lwindow
  augroup END
]])
