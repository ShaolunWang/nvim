local set = vim.o
set.autoindent = true
set.tabstop = 4
set.laststatus = 3
set.scrolloff = 10
set.shiftwidth = 4
set.mouse = ''
set.cmdheight = 0
set.synmaxcol = 180
set.backspace = 'indent,eol,start'
set.cursorline = false
set.ttyfast = true
set.number = true
set.incsearch = true
set.inccommand = 'split'
set.clipboard = 'unnamedplus'
set.splitkeep = 'screen'
set.lazyredraw = false
set.undofile = true
set.termguicolors = true
set.cursorline = true
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
if vim.uv.os_uname().sysname == 'Windows_NT' then
	local powershell_options = {
		shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell',
		shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
		shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait',
		shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode',
		shellquote = '',
		shellxquote = '',
	}
	for option, value in pairs(powershell_options) do
		vim.opt[option] = value
	end
else
	set.shell = 'zsh'
end

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
	vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
end

-- grep
-- command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
--   vim.api.nvim_create_user_command("Grep", function(params)
-- Insert args at the '$*' in the grepprg
--
--[[
  command! -bang -nargs=* -complete=file_in_path -bar Grep call asyncdo#run( \ <bang>0,
           \ { 'job': &grepprg, 'errorformat': &grepformat },
          \ <f-args>)
--]]

vim.cmd([[
  command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)
  noreabbrev  <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent Grep'  : 'grep'
  cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep'
]])
